* Define the location of the main folder on your computer *
cd "."

* In the "data-preparation-main-tables-figures" folder, we have used the dofile "data-preperation-main-tables-figures.do" to create the three data sets we use to run the main regressions for Kenya *
* - One data set (kenya_roads_exp) with road development expenditure as the dependent variable
* - One data set (kenya_roads_pav) with paved road construction as the dependent variable
* - One data set (kenya_roads_cabinet) with the cabinet share as the dependent variable

*******************************************************************************************
* This do-file first creates the main tables for the paper, table 1, 2, 3, 4, and 5 *******
*******************************************************************************************

*******************************************************************************************
*******************************************************************************************
*** Table 1: "Road Expenditure, Ethnicity and Democratic Change in Kenya, 1963-2011" ******
*******************************************************************************************
*******************************************************************************************

* This is the data set with road development expenditure as the dependent variable
use "../../main-tables-figures/data-preparation-main-tables-figures/kenya_roads_exp", clear

* we merge the Kenyan Polity score for each year, and create the democracy variable the authors use in Table 6
merge m:1 year using "../../FIGURES-2-6-7-A5/data-preparation-figures-2-6-7-A5/figures-2-6-7-A5.dta", keep(master match)
gen auto = (polity_kenya <= -6)
gen nonauto = 1-auto
rename nonauto democ



* Column (1) Panel B: interaction
xi: areg exp_dens_share president democ multiparty i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_1b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Table 1 - Panel B) nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (2) Panel B: interaction, + (Controls: Population, Area, Urbanization Rate)*trend
xi: areg exp_dens_share president democ multiparty pop1962_t area_t urbrate1962_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_1b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (3) Panel B : interaction, + (Additional Controls: Earnings, Employment, Cash Crops)*trend
xi: areg exp_dens_share president democ multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_1b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (4) Panel B: interaction, + (Main Highway, Border, Dist. Nairobi)*trend
xi: areg exp_dens_share president democ multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_1b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (5) Panel B: interaction, District time trends only
* we use xtreg to run this regression
* and use tsset to create the district and year fixed effects
tsset distnum year
xi: xtreg exp_dens_share president democ multiparty i.distnum*year, robust cluster(distnum) fe
outreg2 president democ using "table_1b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

***************************************************************************************
***************************************************************************************
*** Table 2: "Road Building, Ethnicity and Democratic Change in Kenya, 1964-2002" *****
***************************************************************************************
***************************************************************************************

* We use the data set with paved road construction as the dependent variable *
use "../../main-tables-figures/data-preparation-main-tables-figures/kenya_roads_pav", clear

* we merge the Kenyan Polity score for each year, and create the democracy variable the authors use in Table 6
merge m:1 year using "../../FIGURES-2-6-7-A5/data-preparation-figures-2-6-7-A5/figures-2-6-7-A5.dta", keep(master match)
gen auto = (polity_kenya <= -6)
gen nonauto = 1-auto
rename nonauto democ



* Column (1) Panel B: interaction
xi: areg change_paved_share president democ  multiparty i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_2b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Table 2 - Panel B) nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (2) Panel B: interaction, + (Population, Area, Urbanization Rate)*trend
xi: areg change_paved_share president democ multiparty pop1962_t area_t urbrate1962_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_2b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (3) Panel B : interaction, + (Earnings, Employment, Cash Crops)*trend
xi: areg change_paved_share president democ multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_2b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (4) Panel B: interaction, + (Main Highway, Border, Dist. Nairobi)*trend
xi: areg change_paved_share president democ multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_2b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (5) Panel B: interaction, District time trends only
* we use xtreg to run this regression
* and use tsset to create the district and year fixed effects
tsset distnum year
xi: xtreg change_paved_share president democ multiparty i.distnum*year, robust cluster(distnum) fe
outreg2 president democ using "table_2b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

****************************************************************************************************
****************************************************************************************************
*** Table 3: "Counterfactual Road Building, Ethnicity and Democratic Changes in Kenya, 1964-2002 ***
****************************************************************************************************
****************************************************************************************************

* We use the data set with road development expenditure as the dependent variable
use "../../main-tables-figures/data-preparation-main-tables-figures/kenya_roads_pav", clear

* we merge the Kenyan Polity score for each year, and create the democracy variable the authors use in Table 6
merge m:1 year using "../../FIGURES-2-6-7-A5/data-preparation-figures-2-6-7-A5/figures-2-6-7-A5.dta", keep(master match)
gen auto = (polity_kenya <= -6)
gen nonauto = 1-auto
rename nonauto democ


* Column (1) Panel B: counterfactual based on population only
xi: areg change_paved_sh_pop president democ multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_3b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Table 3 - Panel B) nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (2) Panel B: counterfactual based on distance only
xi: areg change_paved_sh_dist president democ multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_3b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (3) Panel B: counterfactual based on population and distance
xi: areg change_paved_sh_mp president democ multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_3b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

****************************************************************************************************
****************************************************************************************************
*** Table 5: "Role of the Vice-President, Cabinet Composition and Coalition Politics, 1963-2011" ***
****************************************************************************************************
****************************************************************************************************

* We use the data set with road development expenditure as the dependent variable
use "../../main-tables-figures/data-preparation-main-tables-figures/kenya_roads_exp", clear

* we merge the Kenyan Polity score for each year, and create the democracy variable the authors use in Table 6
merge m:1 year using "../../FIGURES-2-6-7-A5/data-preparation-figures-2-6-7-A5/figures-2-6-7-A5.dta", keep(master match)
gen auto = (polity_kenya <= -6)
gen nonauto = 1-auto
rename nonauto democ

* Column (1) Panel B: interaction, development expenditure
xi: areg exp_dens_share president democ multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ using "table_5b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Table 5 - Panel B) nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (2) Panel B: interaction, development expenditure, + VP
xi: areg exp_dens_share president democ vp vpMP multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ vp vpMP using "table_5b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ vp vpMP) ctitle(" ")
test president + democ = 0
test vp + vpMP = 0

* We use the data set with the cabinet share as the dependent variable
use "../../main-tables-figures/data-preparation-main-tables-figures/kenya_roads_cabinet", clear

* we merge the Kenyan Polity score for each year, and create the democracy variable the authors use in Table 6
merge m:1 year using "../../FIGURES-2-6-7-A5/data-preparation-figures-2-6-7-A5/figures-2-6-7-A5.dta", keep(master match)
gen auto = (polity_kenya <= -6)
gen nonauto = 1-auto
rename nonauto democ

* Column (3) Panel B: interaction, cabinet share
xi: areg cabinet_index president democ i.year i.ethnic_group*year, absorb(ethnic_group) robust cluster(ethnic_group)
outreg2 president democ using "table_5b.tex", se nocons coefastr bdec(2) noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ) ctitle(" ")
test president + democ = 0

* Column (4) Panel B: interaction, cabinet share, + VP
xi: areg cabinet_index president democ vp vpMP i.year i.ethnic_group*year, absorb(ethnic_group) robust cluster(ethnic_group)
outreg2 president democ vp vpMP using "table_5b.tex", se nocons coefastr bdec(2) noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ vp vpMP) ctitle(" ")
test president + democ = 0
test vp + vpMP == 0

* We use the data set with road development expenditure as the dependent variable
use "../../main-tables-figures/data-preparation-main-tables-figures/kenya_roads_exp", clear

* we merge the Kenyan Polity score for each year, and create the democracy variable the authors use in Table 6
merge m:1 year using "../../FIGURES-2-6-7-A5/data-preparation-figures-2-6-7-A5/figures-2-6-7-A5.dta", keep(master match)
gen auto = (polity_kenya <= -6)
gen nonauto = 1-auto
rename nonauto democ

* Column (5) Panel B: no interaction, development expenditure, + Kamba-Luhya-Luo
xi: areg exp_dens_share president democ kllMP multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ kllMP using "table_5b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ kllMP) ctitle(" ")
test president + democ = 0

* Column (6) Panel B: no interaction, development expenditure, + swing district
xi: areg exp_dens_share president democ swing swingMP multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president democ swing swingMP using "table_5b.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president democ swing swingMP) ctitle(" ")
test president + democ = 0


************************************************************************************************************************
************************************************************************************************************************
************************************************END OF DO FILE *********************************************************
************************************************************************************************************************
************************************************************************************************************************
