use data,clear

sum2docx tfp_lp grdi size lev growth roa firmage board indep dual top1 rd1 fin1 fin2 fin3 her herc rdrer rdrerc overedu overedu2 ovaeq hepr  aepi kz sloan lloan tfp_op grdi2 grdi3 grdi4 egrdi grdig gdiv cashflow ifv medat D using tab1.docx, replace stats(N mean sd min max)

global control "size lev growth roa firmage board indep dual top1 rd1"

reg tfp_lp grdi $control
vif

//Baseline regression
reghdfe tfp_lp grdi $control, absorb(ind_id year) vce(cluster stkcd) //0.000 - +++
est sto m1_1

reghdfe tfp_lp grdi $control, absorb(ct_id year) vce(cluster stkcd) //0.000 -
est sto m1_2

reghdfe tfp_lp grdi $control, absorb(prov_id year) vce(cluster stkcd) //0.000 -
est sto m1_3
 
reghdfe tfp_lp grdi $control, absorb(ind_id ct_id prov_id year) vce(cluster stkcd) //0.000 -
est sto m1_4

reghdfe tfp_lp grdi $control if grdi>0, absorb(ind_id ct_id prov_id year) vce(cluster stkcd) 
est sto m1_5

reg2docx m1_1 m1_2 m1_3 m1_4 m1_5 using tab3.docx, replace b(%9.3f) se(%7.2f) addfe("Year FE=Yes" "Industry FE=Yes" "City FE=Yes" "Province FE=Yes") scalars (N r2_a(%9.2f)) title ("x") star(* 0.1 ** 0.05 *** 0.01)

//---Endogeneity concerns---///
ivreghdfe tfp_lp $control (grdi=gdiv), abs(ind_id year) vce(cluster stkcd) first 
est sto m10_2

reghdfe grdi gdiv $control, abs(ind_id year) cluster(stkcd)
est sto m10_1

reg2docx m10_1 m10_2 using tab4.docx, replace b(%9.3f) se(%7.2f) order(grdi) addfe("Year FE=Yes" "Industry FE=Yes") scalars (N r2_a(%9.2f) idstat(%9.3f) cdf(%9.3f) rkf(%9.3f)) title ("x") star(* 0.1 ** 0.05 *** 0.01)

//-----Robustness------//
reghdfe tfp_op grdi $control, absorb(ind_id year) vce(cluster stkcd) 
est sto m9_1

reghdfe tfp_lp grdi2 $control, absorb(ind_id year) vce(cluster stkcd) 
est sto m9_2

reghdfe tfp_lp grdi3 $control, absorb(ind_id year) vce(cluster stkcd) 
est sto m9_3

reghdfe tfp_lp grdi4 $control, absorb(ind_id year) vce(cluster stkcd) 
est sto m9_4

reghdfe tfp_lp egrdi $control, absorb(ind_id year) vce(cluster stkcd) 
est sto m9_5

reghdfe tfp_lp grdig $control, absorb(ind_id year) vce(cluster stkcd) 
est sto m9_6

reg2docx m9_1 m9_2 m9_3 m9_4 m9_5 m9_6 using tab5.docx, replace b(%9.3f) se(%7.2f) order(grdi grdi2 grdi3 grdi4 egrdi grdig) addfe("Year FE=Yes" "Industry FE=Yes") scalars (N r2_a(%9.2f)) title ("x") star(* 0.1 ** 0.05 *** 0.01)


///----Further analysis----///
//------Mechanism-----//
reghdfe fin1 grdi $control, absorb(ind_id year) vce(cluster stkcd) //0.003
est sto m2_1

reghdfe fin2 grdi $control, absorb(ind_id year) vce(cluster stkcd) //0.179
est sto m2_2

reghdfe fin3 grdi $control, absorb(ind_id year) vce(cluster stkcd) //0.044
est sto m2_3
reg2docx m2_1 m2_2 m2_3 using tab6.docx, replace b(%9.3f) se(%7.2f) addfe("Year FE=Yes" "Industry FE=Yes") scalars (N r2_a(%9.2f)) title ("x") star(* 0.1 ** 0.05 *** 0.01)

reghdfe her grdi size lev growth roa firmage board indep dual top1 aepi, absorb(ind_id year) vce(cluster stkcd) 
est sto m3_1

reghdfe herc grdi size lev growth roa firmage board indep dual top1 aepi, absorb(ind_id year) vce(cluster stkcd)
est sto m3_2

reghdfe rdrer grdi size lev growth roa firmage board indep dual top1 aepi, absorb(ind_id year) vce(cluster stkcd)
est sto m3_3

reghdfe rdrerc grdi size lev growth roa firmage board indep dual top1 aepi, absorb(ind_id year) vce(cluster stkcd)
est sto m3_4

reg2docx m3_1 m3_2 m3_3 m3_4 using tab7.docx, replace b(%9.3f) se(%7.2f) addfe("Year FE=Yes" "Industry FE=Yes") scalars (N r2_a(%9.2f)) title ("x") star(* 0.1 ** 0.05 *** 0.01)

reghdfe overedu grdi size lev growth roa firmage board indep dual top1, absorb(ind_id year) vce(cluster stkcd)
est sto m4_1

logit overedu grdi size lev growth roa firmage board indep dual top1 i.year i.ind_id, vce(cluster stkcd)
est sto m4_2

reghdfe overedu2 grdi size lev growth roa firmage board indep dual top1, absorb(ind_id year) vce(cluster stkcd) 
est sto m4_3

reghdfe ovaeq grdi size lev growth roa firmage board indep dual top1, absorb(ind_id year) vce(cluster stkcd) 
est sto m4_4

reghdfe hepr grdi size lev growth roa firmage board indep dual top1 aepi, absorb(ind_id year) vce(cluster stkcd) 
est sto m4_5

reg2docx m4_1 m4_2 m4_3 m4_4 m4_5 using tab8.docx, replace b(%9.3f) se(%7.2f) addfe("Year FE=Yes" "Industry FE=Yes") drop(*year *ind_id) scalars (N r2_a(%9.2f) r2_p(%9.2f)) title ("x") star(* 0.1 ** 0.05 *** 0.01)

reghdfe kz grdi size lev growth roa firmage board indep dual top1, absorb(ind_id year) vce(cluster stkcd) 
est sto m5_1

reghdfe sloan grdi size lev growth roa firmage board indep dual top1, absorb(ind_id year) vce(cluster stkcd) 
est sto m5_2

reghdfe lloan grdi size lev growth roa firmage board indep dual top1, absorb(ind_id year) vce(cluster stkcd) 
est sto m5_3

reg2docx m5_1 m5_2 m5_3 using tab9.docx, replace b(%9.3f) se(%7.2f) addfe("Year FE=Yes" "Industry FE=Yes") scalars (N r2_a(%9.2f)) title ("x") star(* 0.1 ** 0.05 *** 0.01)

//-----Heterogeneity-----//
reghdfe tfp_lp grdi $control if lfcyc=="成长期", absorb(ind_id year) vce(cluster stkcd) 
est sto m8_1

reghdfe tfp_lp grdi $control if lfcyc=="成熟期", absorb(ind_id year) vce(cluster stkcd) 
est sto m8_2

reghdfe tfp_lp grdi $control if lfcyc=="衰退期", absorb(ind_id year) vce(cluster stkcd) 
est sto m8_3

reg2docx m8_1 m8_2 m8_3 using tab10.docx, replace b(%9.3f) se(%7.2f) addfe("Year FE=Yes" "Industry FE=Yes") scalars (N r2_a(%9.2f)) title ("x") star(* 0.1 ** 0.05 *** 0.01)




