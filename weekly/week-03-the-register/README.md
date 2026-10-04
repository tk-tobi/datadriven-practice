# Week 3: The Register

*A utility's new billing system goes live on the 1st. Every half hour of every smart meter has to move over, and the meter feed is the only copy.*

[The Gauntlet on DataDriven](https://datadriven.io/community/week-3)

You're a data engineer at an electric utility. Each half hour, every smart meter reports the energy it used and its register, the total it has counted since it was installed. A feed forwards each report as 1 JSON line, and billing needs 1 clean row per meter per half hour from it. Write the code that turns the feed into that table.

## Result

| | |
|---|---|
| Score | 0.9262 |
| Rank | #2 of 14, top 14% |
| Points | +150 |
| Records recovered | 853,305 of 900,971 |
| Work per record | 37x median |
| Statements | 563 |
| Scored | 2026-10-04 |

131 rows matched no record. Together they cost 262 points.

## Columns

| Column | Correct | Wrong | Missed |
|---|---:|---:|---:|
| `usage_kwh` | 91% | 21,667 | 59,101 |
| `register_kwh` | 93% | 18,897 | 47,875 |
| `quality` | 95% | 433 | 47,541 |
| `meter_id` | 95% | 0 | 47,666 |
| `interval_end` | 95% | 0 | 47,666 |

## What the stream held

Every condition in the data, ordered by what it cost. "Handled" means its records came through about as well as the rest of the run.

| Condition | Of stream | Recovered | Handled |
|---|---:|---:|:---:|
| Local time, CDT or CST | 8.0% | 31% | no |
| Key order changes | 30.0% | 93% | yes |
| Wh in place of kWh | 8.0% | 83% | no |
| Running totals, no usage | 20.0% | 91% | yes |
| Head-end bookkeeping fields | 10.0% | 93% | yes |
| Read flags per maker | 6.0% | 93% | yes |
| Padding and casing | 6.0% | 93% | yes |
| Stamped at the start | 5.0% | 93% | yes |
| Numbers as strings | 5.0% | 93% | yes |
| CDC envelopes | 2.5% | 96% | yes |
| Fill-in, then the real read | 10.0% | 98% | yes |
| JSON as a quoted string | 2.0% | 93% | yes |
| Broken JSON structure | 2.0% | 93% | yes |
| Nulls spelled as strings | 15.0% | 96% | yes |
| Reads that come in late | 3.0% | 98% | yes |
| Duplicate records | 2.0% | 96% | yes |
| Flag outside the contract | 1.0% | 92% | yes |
| Epoch seconds or millis | 5.0% | 99% | yes |
| Truncated lines | 0.5% | 92% | yes |

### Why these happen

**Local time, CDT or CST.** Meter clocks and some head-ends keep the utility's wall time and label it with the zone in force. On the fall-back night 01:30 happens twice, once as CDT and once as CST, and only the label tells the 2 half hours apart.

**Key order changes.** JSON objects are unordered, and every head-end builds them from a map. Key order carries no meaning and should never be relied on.

**Wh in place of kWh.** A meter counts in watt hours internally and each head-end decides what to send: the raw count with a unit beside it, a unit written into the value, or a field named for the unit. The number means nothing without it.

**Running totals, no usage.** Older meters report only their register, the count of energy since installation, so the half hour's usage is the difference from the previous half hour's register. That difference has to be taken in interval order, not in the order lines arrive.

**Head-end bookkeeping fields.** The feed adds its own collector, sequence and receipt markers. They describe how the read travelled, not the read, and do not belong in the table.

**Read flags per maker.** Each head-end writes its own code for a read taken from the meter and for one the system filled in. SUB, short for substituted, is the validation step's word for an estimate.

**Padding and casing.** Meter ids were keyed in at installation and printed on work orders, so they carry the padding, casing and missing dashes of whoever typed them.

**Stamped at the start.** Interval data has 2 conventions: name the half hour by when it ends, or by when it begins. 1 head-end uses the beginning. Read as an end, every such row lands on the half hour before and overwrites it.

**Numbers as strings.** Values that passed through a CSV stage or a shell template arrive quoted. The number is intact; the type is not.

**CDC envelopes.** Part of the feed is replicated out of the meter database by change data capture: each line is an operation with the row before and after it. The row is the after image; the before image is what it replaced.

**Fill-in, then the real read.** The real read replaces the estimate whenever it lands. A replay of the estimation run can also re-send an estimate after its real read went out, and the real read still stands.

**JSON as a quoted string.** Every line crosses a message queue, and 1 producer serialized the read to text before handing it to a client that serialized it again. The record is intact inside a string, sometimes inside the queue's own envelope.

**Broken JSON structure.** Some collectors assemble their lines by hand: a log prefix, a byte-order mark, a stray trailing character, quoting that depends on the value, a tab written into a string unescaped. A strict parser rejects the whole line.

**Nulls spelled as strings.** A head-end that had no value writes whatever its template uses for absence, and 3 templates means several spellings of nothing.

**Reads that come in late.** A meter that loses its radio link keeps its half hours in memory and uploads them when the link returns, as 1 burst in interval order.

**Duplicate records.** A collector that times out resends its whole batch. At-least-once delivery is the norm, so the reader has to settle identity.

**Flag outside the contract.** Reads waiting in the validation queue carry workflow states like PENDING or HOLD. They say where the read is in a process, not whether it came from the meter, so billing stages them as unknown.

**Epoch seconds or millis.** Different services wrote the same field as epoch seconds or milliseconds, sometimes as a string. Both look like plausible integers.

**Truncated lines.** A collector whose buffer fills mid-write leaves a partial line. What was written before the cut is still real; the rest is gone.

Concepts exercised: pyArithmetic, pyBooleanOps, pyBreakContinue, pyClassBasic, pyCollections, pyCsvJson, pyDataTypes, pyDictCreate, pyDictIterate, pyDictMerge, pyDictMethods, pyDunderMethods, pyEnumerate, pyExceptionTypes, pyForBasic, pyFuncDef, pyFuncDefault, pyGenerators, pyGuardClauses, pyIfElse, pyJsonHandling, pyLambda, pyListCopy, pyListCreate, pyListModify, pyListSort, pyMathOps, pyModules, pyNestedLoops, pyRecursion, pyRegex, pySetComprehension, pySetOperations, pySets, pySlicing, pyStackQueue, pyStringBasic, pyStringFormat, pyStringMethods, pyStringSplitJoin, pyTernary, pyTryExcept, pyTuples, pyTypeConversion, pyUnpacking, pyVariables

## Submission

The handler that was graded is in [`handler.py`](./handler.py).
