use rta_20200520.dta, clear
keep if year==2002 | year==2005 | year==2008 | year==2011 | year==2014
drop rta 
save rta_selected_bi.dta, replace 


use Gravity_V202102.dta, clear
keep if year==2002 | year==2005 | year==2008 | year==2011 | year==2014
rename (iso3_o iso3_d) (exporter importer)
keep exporter importer year dist contig comlang_off col45
save Gravity_selected, replace 

