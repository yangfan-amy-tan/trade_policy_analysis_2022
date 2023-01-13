* http://www.tradeconomics.com/icio/ 


***** Year 2014 *****
* 1. load icio tables in wiodn version for year 2014:
icio_load, iciotable(wiodn) year(2014)


* 2. load country list 
use exporter_list
levelsof exporter, local(exporter)

* 3. create excel file 
putexcel set gtrade_2014
putexcel A1 = "exporter"
putexcel B1 = "importer"
putexcel C1 = "gtrade"
putexcel D1 = "share"

* 4. loop through each exporter and get dva 
local i = 2
foreach x in `exporter' {
icio, exporter(`x') destination(all) return(gtrade)
matrix results_exp_`x' = r(gtrade)
putexcel set gtrade_2014, modify
putexcel A`i' = "`x'"
putexcel B`i' = matrix(results_exp_`x'), rownames nformat(number_d2) 
local i = `i' + 44
}



***** Year 2011 *****
* 1. load icio tables in wiodn version for year 2011:
icio_load, iciotable(wiodn) year(2011)


* 2. load country list 
use exporter_list
levelsof exporter, local(exporter)

* 3. create excel file 
putexcel set gtrade_2011
putexcel A1 = "exporter"
putexcel B1 = "importer"
putexcel C1 = "gtrade"
putexcel D1 = "share"

* 4. loop through each exporter and get dva 
local i = 2
foreach x in `exporter' {
icio, exporter(`x') destination(all) return(gtrade)
matrix results_exp_`x' = r(gtrade)
putexcel set gtrade_2011, modify
putexcel A`i' = "`x'"
putexcel B`i' = matrix(results_exp_`x'), rownames nformat(number_d2) 
local i = `i' + 44
}


***** Year 2008 *****
* 1. load icio tables in wiodn version for year 2008:
icio_load, iciotable(wiodn) year(2008)


* 2. load country list 
use exporter_list
levelsof exporter, local(exporter)

* 3. create excel file 
putexcel set gtrade_2008
putexcel A1 = "exporter"
putexcel B1 = "importer"
putexcel C1 = "gtrade"
putexcel D1 = "share"

* 4. loop through each exporter and get dva 
local i = 2
foreach x in `exporter' {
icio, exporter(`x') destination(all) return(gtrade)
matrix results_exp_`x' = r(gtrade)
putexcel set gtrade_2008, modify
putexcel A`i' = "`x'"
putexcel B`i' = matrix(results_exp_`x'), rownames nformat(number_d2) 
local i = `i' + 44
}



***** Year 2005 *****
* 1. load icio tables in wiodn version for year 2005:
icio_load, iciotable(wiodn) year(2005)


* 2. load country list 
use exporter_list
levelsof exporter, local(exporter)

* 3. create excel file 
putexcel set gtrade_2005
putexcel A1 = "exporter"
putexcel B1 = "importer"
putexcel C1 = "gtrade"
putexcel D1 = "share"

* 4. loop through each exporter and get dva 
local i = 2
foreach x in `exporter' {
icio, exporter(`x') destination(all) return(gtrade)
matrix results_exp_`x' = r(gtrade)
putexcel set gtrade_2005, modify
putexcel A`i' = "`x'"
putexcel B`i' = matrix(results_exp_`x'), rownames nformat(number_d2) 
local i = `i' + 44
}


***** Year 2002 *****
* 1. load icio tables in wiodn version for year 2002:
icio_load, iciotable(wiodn) year(2002)


* 2. load country list 
use exporter_list
levelsof exporter, local(exporter)

* 3. create excel file 
putexcel set gtrade_2002
putexcel A1 = "exporter"
putexcel B1 = "importer"
putexcel C1 = "gtrade"
putexcel D1 = "share"

* 4. loop through each exporter and get dva 
local i = 2
foreach x in `exporter' {
icio, exporter(`x') destination(all) return(gtrade)
matrix results_exp_`x' = r(gtrade)
putexcel set gtrade_2002, modify
putexcel A`i' = "`x'"
putexcel B`i' = matrix(results_exp_`x'), rownames nformat(number_d2) 
local i = `i' + 44
}
