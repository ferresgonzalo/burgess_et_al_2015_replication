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

merge 1:1 distname_1979 year using newlight_bltcfix_loc.dta, nogenerate

* Column (1) Panel A: no interaction
xi: areg new_bltcfix_lnlight_c president i.year, absorb(distnum) robust cluster(distnum)
outreg2 president using "table_1a.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Table 1 - Panel A) nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace tex(fragment) keep(president) ctitle(" ")

* Column (2) Panel A: no interaction, + (Controls: Population, Area, Urbanization Rate)*trend
xi: areg new_bltcfix_lnlight_c president pop1962_t area_t urbrate1962_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "table_1a.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president) ctitle(" ")

* Column (3) Panel A: no interaction, + (Additional Controls: Earnings, Employment, Cash Crops)*trend
xi: areg new_bltcfix_lnlight_c president pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "table_1a.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president) ctitle(" ")

* Column (4) Panel A: no interaction, + (Additional Controls: Main Highway, Border, Dist. Nairobi)*trend
xi: areg new_bltcfix_lnlight_c president pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "table_1a.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president) ctitle(" ")

* Column (5) Panel A: no interaction, District time trends only
* we use xtreg to run this regression
* and use tsset to create the district and year fixed effects
tsset distnum year
xi: xtreg new_bltcfix_lnlight_c president i.distnum*year, robust cluster(distnum) fe
outreg2 president presidentMP using "table_1a.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(president) ctitle(" ")

*******************************************************************************************************************************
*******************************************************************************************************************************
*** Table 4: "Road Expenditure, Ethnicity and Democratic Changes in Kenya: Political and Leadership Transitions, 1963-2011" *** 
*******************************************************************************************************************************
*******************************************************************************************************************************

* We use the data set with road development expenditure as the dependent variable
use "../../main-tables-figures/data-preparation-main-tables-figures/kenya_roads_exp", clear

merge 1:1 distname_1979 year using newlight_bltcfix_loc.dta, nogenerate

* Column (4): Democracy 1993-2002
xi: areg new_bltcfix_lnlight_c i.kikuyu i.kalenjin if year >= 1993 & year <= 2002, absorb(year) robust cluster(distnum)
outreg2 _Ikikuyu_1 _Ikalenjin_1 using "table_4.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace tex(fragment) ctitle(" ")
test _Ikikuyu_1 = _Ikalenjin_1

* Column (5): Democracy 2003-2011
xi: areg new_bltcfix_lnlight_c i.kikuyu i.kalenjin if year >= 2003, absorb(year) robust cluster(distnum)
outreg2 _Ikikuyu_1 _Ikalenjin_1 using "table_4.tex", se nocons coefastr bdec(2) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) ctitle(" ")
test _Ikikuyu_1 = _Ikalenjin_1
