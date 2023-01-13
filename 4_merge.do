* Merge with TA dummies 

use dva_gtrade, clear 
drop if exporter == "ROW" | importer == "ROW"
merge m:1 exporter importer year using rta_selected_bi, keep(1 3)
drop _merge
sort year exporter importer

save dva_gtrade_dummies.dta, replace



* Merge with other trade cost variables 

use dva_gtrade_dummies.dta
merge m:1 exporter importer year using Gravity_selected.dta, keep(3)
drop _merge

save Final_dva_gtrade.dta, replace



