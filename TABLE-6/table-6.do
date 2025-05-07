*** THIS DO-FILE TO CREATES TABLE 6 IN THE MAIN PAPER ***
*** PLEASE REFER TO "data-preperation-table-6.do" FOR ALL THE STEPS TO RE-CREATE THE DATASET ***
*** PLEASE CHANGE DATA PATH ****
cd "."
use "data-preparation-table-6/table-6.dta", clear

* We update the original Easterly-Levine data set (1960s-1980s) with the subsequent decades 1990s and 2000s
* The readme-file-table-6 describes the sources for each variable *

* Column (1): World, 1960s-1980s
xi: reg gyp i.year i.ssa i.latinca lrgdp lrgdpsq ELF if year <1990, cluster(country)
outreg2 ELF using "table-6.tex", se nocons coefastr bdec(3) adjr2 noni nolabel bracket title(Table 6) nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace tex(fragment) keep(ELF) ctitle(" ")

* Column (2): World, 1960s-2000s
xi: reg gyp i.year i.ssa i.latinca lrgdp lrgdpsq ELF, cluster(country)
outreg2 ELF using "table-6.tex", se nocons coefastr bdec(3) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(ELF) ctitle(" ")

* Column (3): World, 1960s-2000s, interaction with Demcoracy [c,t]
xi: reg gyp i.year i.ssa i.latinca lrgdp lrgdpsq ELF democ i.democ*ELF, cluster(country)
outreg2 ELF _IdemXELF60_1 democ using "table-6.tex", se nocons coefastr bdec(3) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(ELF _IdemXELF60_1 democ) ctitle(" ")
test _IdemXELF60_1 + ELF60 = 0

* Column (4): Africa, 1960s-2000s, interaction with Democracy [c,t]
keep if ssa == 1
xi: reg gyp i.year i.ssa i.latinca lrgdp lrgdpsq ELF democ i.democ*ELF, cluster(country)
outreg2 ELF _IdemXELF60_1 democ using "table-6.tex", se nocons coefastr bdec(3) adjr2 noni nolabel bracket nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append tex(fragment) keep(ELF _IdemXELF60_1 democ) ctitle(" ")
test _IdemXELF60_1 + ELF60 = 0
