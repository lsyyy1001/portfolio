* Unemployment and personal saving rate analysis
* Reproduces the documented regression and correlation workflow.

clear all
set more off

tempfile unemployment saving

import delimited "https://fred.stlouisfed.org/graph/fredgraph.csv?id=UNRATE", clear
rename date observation_date
save `unemployment'

import delimited "https://fred.stlouisfed.org/graph/fredgraph.csv?id=PSAVERT", clear
rename date observation_date
save `saving'

use `unemployment', clear
merge 1:1 observation_date using `saving', keep(match) nogen
drop if missing(UNRATE, PSAVERT)

describe
summarize UNRATE PSAVERT
regress UNRATE PSAVERT
correlate UNRATE PSAVERT
