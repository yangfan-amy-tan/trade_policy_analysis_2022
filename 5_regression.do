* Clear memory and set parameters
	clear all
	set more off
	clear matrix
	set memory 500m
	set matsize 8000
	
* Close and create log	
	capture log close
	log using "regression_dva_gtrade.log", text replace

* Open the data file 
	use Final_dva_gtrade.dta

********************** (i) Benchmark gravity estimation ***********************

* a. Generate exporter-time and importer-time effects

	* Create exporter-time IDs (for fixed effects)
		egen exp_time = group(exporter year)

	* Create importer-time IDs (for fixed effects)
		egen imp_time = group(importer year)

* b. Estimate the following standard gravity specification by considering only 
*    international trade flows (i.e. for i=/j ) and applying the OLS estimator:
*    Xij = pi_it + xsi_jt + b*GRAVITY + b5*bcu + b6*fta + b7*psa + b8*cueia + b9*ftaeia + b10*psaeia

	* create asymmetric pair IDs (for fixed effects and clusterd standar errors)
		egen pair_id = group(exporter importer)
		
	* Create the log of distance
		gen ln_dist = ln(dist)
		
		reghdfe gtrade cu fta psa eia cueia ftaeia psaeia ln_dist contig comlang_off col45 if exporter != importer, absorb(exp_time imp_time) cluster(pair_id)
			estimates store olshdfe_gtrade
		outreg2 using results.doc, replace ctitle(OLS_gtrade) addtext(Exporter-Year FE, YES, Importer-Year FE, YES, Pair FE, NO)
		
	
		reghdfe dva cu fta psa eia cueia ftaeia psaeia ln_dist contig comlang_off col45 if exporter != importer, absorb(exp_time imp_time) cluster(pair_id)
			estimates store olshdfe_dva
		outreg2 using results.doc, append ctitle(OLS_dva) addtext(Exporter-Year FE, YES, Importer-Year FE, YES, Pair FE, NO)
		
		
* c. Re-estimate the same specification expressed in multiplicative form with 
*    the PPML estimator. 

	* Estimate the gravity model with the PPML estimator and store the results
		ppmlhdfe gtrade cu fta psa eia cueia ftaeia psaeia ln_dist contig comlang_off col45 if exporter != importer, absorb(exp_time imp_time) cluster(pair_id)
			estimates store olshdfe_gtrade
		outreg2 using results.doc, append ctitle(PPML_gtrade) addtext(Exporter-Year FE, YES, Importer-Year FE, YES, Pair FE, NO)
		
		ppmlhdfe dva cu fta psa eia cueia ftaeia psaeia ln_dist contig comlang_off col45 if exporter != importer, absorb(exp_time imp_time) cluster(pair_id)
			estimates store olshdfe_dva
		outreg2 using results.doc, append ctitle(PPML_dva) addtext(Exporter-Year FE, YES, Importer-Year FE, YES, Pair FE, NO)
		
			
********* (ii) Gravity estimation accounting for intra-national trade *********

* a. Generate pair fixed effects

	* Create intra-trade pair fixed effects
		generate intrapair_id = 0
			replace intrapair_id = pair_id if exporter == importer
		
* b. Re-estimate the specification with the PPML estimator but this time by 
*    considering international and intra-national trade. 

	* Estimate the gravity model with the PPML estimator and store the results
		ppmlhdfe gtrade cu fta psa eia cueia ftaeia psaeia ln_dist contig comlang_off col45, absorb(intrapair_id exp_time imp_time) cluster(pair_id)
			estimates store intrahdfe_gtrade		
		outreg2 using results.doc, append ctitle(INTRA_gtrade) addtext(Exporter-Year FE, YES, Importer-Year FE, YES, Pair FE, NO)
		
		ppmlhdfe dva cu fta psa eia cueia ftaeia psaeia ln_dist contig comlang_off col45, absorb(intrapair_id exp_time imp_time) cluster(pair_id)
			estimates store intrahdfe_dva	
		outreg2 using results.doc, append ctitle(INTRA_dva) addtext(Exporter-Year FE, YES, Importer-Year FE, YES, Pair FE, NO)
					
* c. In order to correct for potential endogeneity of the RTAs variable, 
*    estimate the following gravity specification with the PPML estimator			
*    Xij = pi_it + xsi_jt + mu_ij + b*GRAVITY + b5*bcu + b6*fta + b7*psa + b8*cueia + b9*ftaeia + b10*psaeia

	* Estimate the gravity model with the PPML estimator and store the results
		ppml_panel_sg gtrade cu fta psa eia cueia ftaeia psaeia, ex(exporter) im(importer) y(year) sym cluster(pair_id) 	
			estimates store ppml_fes_gtrade
		outreg2 using results.doc, append ctitle(PAIR_FEs_gtrade) addtext(Exporter-Year FE, YES, Importer-Year FE, YES, Pair FE, YES)
		
		ppml_panel_sg dva cu fta psa eia cueia ftaeia psaeia, ex(exporter) im(importer) y(year) sym cluster(pair_id) 	
			estimates store ppml_fes_dva
		outreg2 using results.doc, append ctitle(PAIR_FEs_dva) addtext(Exporter-Year FE, YES, Importer-Year FE, YES, Pair FE, YES)
		
		
log close
