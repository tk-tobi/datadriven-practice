/* dag.yml
dag: the_timetable
schedule: nightly
tasks:
  trip_updates_history:
    materialized: incremental
    incremental_strategy: merge
    unique_key: [update_id]
    depends_on: [trip_updates]
  trips_history:
    materialized: incremental
    incremental_strategy: merge
    unique_key: [trip_id, feed_version, feed_start_date, _batch_id, _loaded_at]
    depends_on: [trips]
  trip_actuals:
    materialized: table
    depends_on: [trip_updates_history, trips_history]
*/

-- task: trip_updates_history
SELECT DISTINCT update_id, trip_id, start_date, route_id, vehicle_id, event_type,
       schedule_relationship, event_time, feed, _batch_id, _loaded_at
FROM trip_updates
WHERE trip_id IS NOT NULL
{% if is_incremental() %}
  AND (_loaded_at IS NULL OR _loaded_at >= coalesce((SELECT max(_loaded_at) FROM {{ this }}), ''))
{% endif %}
;

-- task: trips_history
SELECT DISTINCT trip_id, route_id, service_id, direction_id, trip_headsign, first_departure,
       feed_version, feed_start_date, _batch_id, _loaded_at
FROM trips
WHERE trip_id IS NOT NULL
{% if is_incremental() %}
  AND (_loaded_at IS NULL OR _loaded_at >= coalesce((SELECT max(_loaded_at) FROM {{ this }}), ''))
{% endif %}
;

-- task: trip_actuals
WITH RECURSIVE
tu0 AS (
  SELECT update_id, _loaded_at,
         trim(trip_id) AS tid,
         replace(replace(replace(replace(trim(coalesce(start_date, '')), '-', ''), '/', ''), '.', ''), ' ', '') AS sd8,
         trim(coalesce(event_time, '')) AS et,
         lower(trim(coalesce(event_type, ''))) AS ety,
         upper(trim(coalesce(schedule_relationship, ''))) AS rel,
         trim(coalesce(vehicle_id, '')) AS veh,
         trim(coalesce(route_id, '')) AS rte
  FROM trip_updates_history
),
tu1 AS (
  SELECT update_id, _loaded_at, veh,
    CASE WHEN tid LIKE '%.0' THEN substr(tid, 1, length(tid) - 2) ELSE tid END AS tid,
    CASE WHEN sd8 GLOB '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
          AND date(substr(sd8,1,4) || '-' || substr(sd8,5,2) || '-' || substr(sd8,7,2))
              = substr(sd8,1,4) || '-' || substr(sd8,5,2) || '-' || substr(sd8,7,2)
         THEN substr(sd8,1,4) || '-' || substr(sd8,5,2) || '-' || substr(sd8,7,2) END AS sd,
    CASE
      WHEN et GLOB '[0-9]*' AND NOT et GLOB '*[^0-9]*' AND length(et) >= 12 THEN CAST(et AS INTEGER) / 1000
      WHEN et GLOB '[0-9]*' AND NOT et GLOB '*[^0-9]*' AND length(et) BETWEEN 9 AND 11 THEN CAST(et AS INTEGER)
      WHEN et GLOB '[0-9]*.[0-9]*' AND NOT et GLOB '*[^0-9.]*'
        THEN CASE WHEN CAST(et AS REAL) >= 100000000000.0 THEN CAST(CAST(et AS REAL) / 1000 AS INTEGER) ELSE CAST(CAST(et AS REAL) AS INTEGER) END
      WHEN et GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]*' THEN CAST(strftime('%s', replace(et, 'T', ' ')) AS INTEGER)
    END AS et_s,
    CASE
      WHEN ety IN ('start','started','starting','starts','depart','departed','departing','departure','dep','dpt','begin','began','begun','begins','trip_start','tripstart','start_trip','trip-start','trip started','in_progress','in-progress','inprogress','running','underway','en_route','enroute','abfahrt','salida','départ','partenza','vertrek','s','st','str') THEN 'started'
      WHEN ety IN ('end','ended','ending','ends','finish','finished','finishes','complete','completed','completes','arrive','arrived','arriving','arrival','arr','trip_end','tripend','end_trip','trip-end','trip ended','trip_complete','tripcomplete','done','terminated','terminate','terminus','ankunft','llegada','arrivée','arrivee','arrivo','aankomst','fin','fine','e','en','cmp') THEN 'completed'
      WHEN ety IN ('cancel','canceled','cancelled','cancellation','cancelation','cancels','canc','cncl','cxl','cx','cnl','trip_cancel','tripcancel','trip_canceled','trip_cancelled','trip-cancel','abort','aborted','skipped','skip','no_show','noshow','no-show','dropped','withdrawn','ausfall','entfällt','entfaellt','entfallen','storniert','abgesagt','annulé','annule','annulation','annulée','annulee','cancelado','cancelada','cancelación','cancelacion','annullato','annullata','geannuleerd','c','can') OR rel IN ('CANCELED','CANCELLED','CANCEL') THEN 'cancelled'
    END AS st,
    CASE WHEN lower(rte) IN ('', '\N', 'null', 'none', 'n/a', 'na', 'nan', '-', 'unknown') THEN NULL ELSE rte END AS rte
  FROM tu0
  WHERE tid <> '' AND lower(tid) NOT IN ('\N', 'null', 'none', 'n/a', 'na', 'nan', 'trip_id')
),
vraw AS (
  SELECT DISTINCT CASE WHEN veh LIKE '%.0' THEN substr(veh, 1, length(veh) - 2) ELSE veh END AS veh FROM tu1 WHERE veh <> ''
),
vfast AS (
  SELECT veh, veh AS vclean FROM vraw WHERE veh GLOB '[0-9]*' AND NOT veh GLOB '*[^0-9]*'
),
vstrip(veh, rest, outp) AS (
  SELECT veh, substr(veh, 1, 48), '' FROM vraw WHERE NOT (veh GLOB '[0-9]*' AND NOT veh GLOB '*[^0-9]*')
  UNION ALL
  SELECT veh, substr(rest, 2), outp || CASE WHEN substr(rest, 1, 1) GLOB '[0-9]' THEN substr(rest, 1, 1) ELSE '' END
  FROM vstrip WHERE rest <> ''
),
vmap AS (
  SELECT veh, vclean FROM vfast
  UNION ALL
  SELECT veh, nullif(outp, '') FROM vstrip WHERE rest = ''
),
tu2 AS (
  SELECT tu1.*, v.vclean FROM tu1
  LEFT JOIN vmap v ON v.veh = CASE WHEN tu1.veh LIKE '%.0' THEN substr(tu1.veh, 1, length(tu1.veh) - 2) ELSE tu1.veh END
),
tt_raw AS (
  SELECT
    CASE WHEN tid0 LIKE '%.0' THEN substr(tid0, 1, length(tid0) - 2) ELSE tid0 END AS tid,
    CASE WHEN rte0 IN ('', '\N', 'null', 'none', 'n/a', 'na', 'nan', '-') THEN NULL ELSE rtex END AS rte,
    CASE WHEN fsd8 GLOB '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' THEN substr(fsd8,1,4) || '-' || substr(fsd8,5,2) || '-' || substr(fsd8,7,2) END AS fsd,
    coalesce(_loaded_at, '') || '|' || coalesce(_batch_id, '') AS fkey,
    _batch_id, _loaded_at,
    CASE WHEN uf LIKE '%PM%' OR uf LIKE '%P.M.%' THEN 1 ELSE 0 END AS pm,
    CASE WHEN (uf LIKE '%AM%' OR uf LIKE '%A.M.%') AND uf NOT LIKE '%PM%' AND uf NOT LIKE '%P.M.%' THEN 1 ELSE 0 END AS am,
    trim(replace(replace(replace(replace(uf, 'P.M.', ''), 'A.M.', ''), 'PM', ''), 'AM', '')) AS core,
    CASE WHEN fd GLOB '1899-12-31*' OR fd GLOB '1900-01-01*' THEN 86400 WHEN fd GLOB '1900-01-02*' THEN 172800 ELSE 0 END AS dayoff
  FROM (
    SELECT trim(trip_id) AS tid0, lower(trim(coalesce(route_id, ''))) AS rte0, trim(coalesce(route_id, '')) AS rtex,
           trim(coalesce(first_departure, '')) AS fd,
           upper(CASE WHEN trim(coalesce(first_departure, '')) GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]*' THEN trim(substr(trim(first_departure), 12)) ELSE trim(coalesce(first_departure, '')) END) AS uf,
           replace(replace(replace(replace(trim(coalesce(feed_start_date, '')), '-', ''), '/', ''), '.', ''), ' ', '') AS fsd8,
           _batch_id, _loaded_at
    FROM trips_history
  )
  WHERE tid0 <> '' AND tid0 NOT IN ('\N', 'null', 'none', 'n/a', 'na', 'nan', 'trip_id')
),
tt AS (
  SELECT tid, rte, fsd, fkey, _batch_id, _loaded_at,
    CASE
      WHEN core GLOB '[0-9]*:[0-9][0-9]:[0-9][0-9]*' THEN
        dayoff + (CAST(substr(core, 1, instr(core, ':') - 1) AS INTEGER)
          + CASE WHEN pm = 1 AND CAST(substr(core, 1, instr(core, ':') - 1) AS INTEGER) < 12 THEN 12
                 WHEN am = 1 AND CAST(substr(core, 1, instr(core, ':') - 1) AS INTEGER) = 12 THEN -12 ELSE 0 END) * 3600
        + CAST(substr(core, instr(core, ':') + 1, 2) AS INTEGER) * 60
        + CAST(substr(core, instr(core, ':') + 4, 2) AS INTEGER)
      WHEN core GLOB '[0-9][0-9][0-9][0-9][0-9][0-9]'
        THEN CAST(substr(core, 1, 2) AS INTEGER) * 3600 + CAST(substr(core, 3, 2) AS INTEGER) * 60 + CAST(substr(core, 5, 2) AS INTEGER)
    END AS dep_secs
  FROM tt_raw
),
tt_d AS (SELECT tid, fkey, max(dep_secs) AS dep_secs, max(rte) AS rte FROM tt GROUP BY tid, fkey),
files AS (SELECT fkey, coalesce(max(fsd), max(_batch_id)) AS fsd, max(_loaded_at) AS la, max(_batch_id) AS bid FROM tt GROUP BY fkey),
in_force AS (SELECT fsd, fkey FROM (SELECT fsd, fkey, row_number() OVER (PARTITION BY fsd ORDER BY la DESC, bid DESC) AS rn FROM files) WHERE rn = 1 AND fsd IS NOT NULL),
late AS (SELECT tid, max(dep_secs) AS mx FROM tt GROUP BY tid),
ev AS (
  SELECT tid, et_s, st, rte, vclean, _loaded_at, update_id, sd AS svc FROM tu2 WHERE sd IS NOT NULL
  UNION ALL
  SELECT u.tid, u.et_s, u.st, u.rte, u.vclean, u._loaded_at, u.update_id,
    CASE WHEN u.et_s IS NULL THEN NULL
         WHEN ((u.et_s - 25200) % 86400) < 14400 AND coalesce(l.mx, 0) >= 86400 THEN date(u.et_s - 25200 - 86400, 'unixepoch')
         ELSE date(u.et_s - 25200, 'unixepoch') END
  FROM tu2 u LEFT JOIN late l ON l.tid = u.tid WHERE u.sd IS NULL
),
agg AS (
  SELECT tid, svc,
    CAST(strftime('%s', svc) AS INTEGER) + 25200 AS day0,
    min(CASE WHEN st = 'started' AND et_s >= CAST(strftime('%s', svc) AS INTEGER) + 25200 THEN et_s END) AS first_valid_start,
    min(CASE WHEN st = 'started' THEN et_s END) AS first_any_start,
    max(printf('%012d', coalesce(et_s, -1)) || coalesce(_loaded_at, '') || update_id || '|' || coalesce(st, '')) AS lastkey,
    min(CASE WHEN st = 'started' THEN printf('%d%d%012d', CASE WHEN et_s IS NULL OR et_s < CAST(strftime('%s', svc) AS INTEGER) + 25200 THEN 1 ELSE 0 END, CASE WHEN vclean IS NULL THEN 1 ELSE 0 END, coalesce(et_s, 0)) || '|' || coalesce(vclean, '') END) AS vehkey,
    min(CASE WHEN rte IS NOT NULL THEN printf('%012d', coalesce(et_s, 0)) || '|' || rte END) AS rkey
  FROM ev WHERE svc IS NOT NULL GROUP BY tid, svc
),
grp AS (
  SELECT tid, svc, day0, first_valid_start, first_any_start,
         nullif(substr(lastkey, instr(lastkey, '|') + 1), '') AS status,
         nullif(substr(vehkey, instr(vehkey, '|') + 1), '') AS vehicle_id,
         substr(rkey, instr(rkey, '|') + 1) AS feed_rte
  FROM agg
),
vers AS (SELECT fsd, fkey, lead(fsd) OVER (ORDER BY fsd) AS nfsd FROM in_force),
base AS (
  SELECT g.tid, g.svc, g.day0, g.first_valid_start, g.first_any_start, g.status, g.vehicle_id, g.feed_rte, v.fkey
  FROM grp g LEFT JOIN vers v ON v.fsd <= g.svc AND (v.nfsd IS NULL OR g.svc < v.nfsd)
),
joined AS (
  SELECT b.*, t.rte AS tt_rte, t.dep_secs, (t.tid IS NOT NULL) AS listed
  FROM base b LEFT JOIN tt_d t ON t.tid = b.tid AND t.fkey = b.fkey
),
calc AS (
  SELECT j.tid,
    CASE WHEN j.listed THEN j.svc ELSE coalesce(date(j.first_any_start - 25200, 'unixepoch'), j.svc) END AS service_date,
    CASE WHEN j.listed THEN coalesce(j.tt_rte, j.feed_rte) ELSE j.feed_rte END AS route_id,
    CASE WHEN j.listed AND j.dep_secs IS NOT NULL THEN j.day0 + j.dep_secs END AS sched0,
    CASE WHEN j.listed THEN j.first_valid_start ELSE j.first_any_start END AS act_s,
    j.status, j.vehicle_id,
    CASE WHEN j.listed THEN 0 ELSE 1 END AS unscheduled
  FROM joined j
),
calc2 AS (
  SELECT *, CASE WHEN sched0 IS NOT NULL AND act_s IS NOT NULL AND act_s - sched0 > 72000 THEN sched0 + 86400 WHEN sched0 IS NOT NULL AND act_s IS NOT NULL AND act_s - sched0 < -72000 THEN sched0 - 86400 ELSE sched0 END AS sched_s
  FROM calc
),
final AS (
  SELECT *, row_number() OVER (PARTITION BY tid, service_date ORDER BY (act_s IS NULL), (status IS NULL)) AS rn FROM calc2
)
SELECT CAST(tid AS TEXT) AS trip_id, CAST(service_date AS TEXT) AS service_date, CAST(route_id AS TEXT) AS route_id,
       strftime('%Y-%m-%dT%H:%M:%SZ', sched_s, 'unixepoch') AS scheduled_start,
       strftime('%Y-%m-%dT%H:%M:%SZ', act_s, 'unixepoch') AS actual_start,
       CAST(act_s - sched_s AS INTEGER) AS delay_s, status, vehicle_id, unscheduled
FROM final WHERE rn = 1 AND service_date IS NOT NULL;
