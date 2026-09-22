# Week 1: The Handoff

*A CRM is being retired. Its nightly export is the only way the customer list gets out.*

[The Gauntlet on DataDriven](https://datadriven.io/community/week-1)

You're a data engineer migrating away from a CRM your company has used since 2019, through 3 rewrites and a change of owner. Its nightly export is the only feed left: 1 JSON object per customer, written by whoever last touched the exporter. The finance team needs 1 clean row per customer to close the fiscal year. Your CRM team all left the company, but before they did, they set up 1 final data stream that you *must* capture accurately. Write the code to turn a messy stream of questionable data into a clean table of actionable financial raw data.

## Result

| | |
|---|---|
| Score | 0.8154 |
| Rank | #4 of 11, top 36% |
| Points | +40 |
| Records recovered | 835,179 of 951,089 |
| Work per record | 0.82x median |
| Statements | 46 |
| Scored | 2026-09-21 |

## Columns

| Column | Correct | Wrong | Missed |
|---|---:|---:|---:|
| `signup_at` | 77% | 38 | 214,658 |
| `plan` | 80% | 19 | 187,634 |
| `mrr_usd` | 82% | 5,907 | 164,413 |
| `seats` | 82% | 0 | 168,912 |
| `email` | 83% | 21,666 | 143,325 |
| `customer_id` | 88% | 0 | 115,910 |

## What the stream held

Every condition in the data, ordered by what it cost. "Handled" means its records came through about as well as the rest of the run.

| Condition | Of stream | Recovered | Handled |
|---|---:|---:|:---:|
| Key order changes | 30.0% | 82% | yes |
| Broken JSON structure | 6.0% | 12% | no |
| Nesting and flattening | 10.0% | 50% | no |
| Localized key names | 5.0% | 2% | no |
| Padding and casing | 12.0% | 78% | yes |
| Nulls spelled as strings | 30.0% | 83% | yes |
| Mixed date formats | 8.0% | 69% | no |
| Epoch seconds or millis | 8.0% | 75% | no |
| Export bookkeeping fields | 10.0% | 82% | yes |
| Plan aliases | 6.0% | 69% | no |
| Numbers as strings | 5.0% | 71% | no |
| Emails with display names | 4.0% | 71% | no |
| Duplicate records | 4.0% | 88% | yes |
| Truncated lines | 0.8% | 2% | no |
| Plans outside the contract | 1.0% | 84% | yes |

### Why these happen

**Key order changes.** The exporter builds each object from a dict, so key order is arbitrary. A parser that relies on position reads the wrong field.

**Broken JSON structure.** The exporter concatenates strings instead of serialising, so quoting and commas depend on the values. A strict parser drops the whole line.

**Nesting and flattening.** 3 rewrites moved fields in and out of sub-objects and never migrated old rows. The same value sits at a different depth depending on its write date.

**Localized key names.** Regional instances localised their field labels. The export pools all of them and never translates the keys back.

**Padding and casing.** Values pasted from spreadsheets and email keep their padding and casing. Nothing upstream ever trimmed or lowercased.

**Nulls spelled as strings.** 12 integrations each wrote absence their own way. The column holds several spellings of nothing, and none of them is null.

**Mixed date formats.** Every writer had its own timestamp convention, and some dropped the zone. An ambiguous date resolves only by the source's own rule.

**Epoch seconds or millis.** Some services wrote the field as epoch seconds, others as milliseconds, some as strings. All of them parse as plausible integers.

**Export bookkeeping fields.** The export stamps its own batch and source markers on every record. They describe the run, not the customer.

**Plan aliases.** The plan field was free text before it became a picklist, and the picklist was relabelled twice. Every row keeps the spelling of its era.

**Numbers as strings.** Money and counts were formatted for humans: thousands separators, currency symbols, units, and decimal commas from EU instances.

**Emails with display names.** Addresses copied from mail clients arrive with the display name, angle brackets and sometimes a mailto: prefix still attached.

**Duplicate records.** Retries and overlapping export windows resend records that already shipped. At-least-once delivery means the reader settles identity.

**Truncated lines.** A buffer or timeout cut the write mid-line. Everything before the cut is real; everything after is gone.

**Plans outside the contract.** Retired and internal plans survive on old accounts. A value outside the contract cannot be mapped, so it stages as null.

Concepts exercised: pyBooleanOps, pyClassBasic, pyCsvJson, pyDataTypes, pyDictCreate, pyDictMethods, pyDunderMethods, pyExceptionTypes, pyFStrings, pyFuncDef, pyGuardClauses, pyIfElse, pyJsonHandling, pyListCreate, pyModules, pySets, pyStringBasic, pyStringMethods, pyStringSplitJoin, pyTryExcept, pyTuples, pyTypeConversion, pyVariables

## Submission

The handler that was graded is in [`handler.py`](./handler.py).
