*** THIS DO-FILE TO CREATES FIGURES FOR MAIN PAPER (2, 6 AND 7) AND APPENDIX FIGURE A.5 ***
*** PLEASE REFER TO "data-preperation-figures-2-6-7-A5.do" FOR ALL THE STEPS TO RE-CREATE THE DATASET ***
cd "."
use "data-preparation-figures-2-6-7-A5/figures-2-6-7-A5.dta", clear

** MAIN PAPER FIGURES: 2, 6 AND 7 **
* Figure 2: "Evolution of Political Regimes in Sub-Saharan Africa, 1963-2011"
twoway (line polity_ssa year, lwidth(medthick)) (line polity_kenya year, lwidth(medthick) lpattern(dash)), ytitle(Combined Polity Score) ytitle(, margin(small)) xtitle(., size(zero)) xmtick(1960(1)2011) xline(1969.916667) xline(1992.916667) legend(order(1 "Sub-Saharan Africa" 2 "Kenya") col(2) position(0.8 0.2)) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))
graph export "figure_2.png", replace width(2620) height(1908)

* Figure 6: "Ethnic Favoritism and Political Regimes in Kenya, 1963-2011"
twoway (line theta_hat year, lcolor(navy) lwidth(medthick)) (line polity_kenya year, yaxis(2) lwidth(medthick) lpattern(dash)), ytitle("Ethnic Favoritism, Theta")  ytitle("Combined Polity Score", axis(2)) yscale(reverse) xtitle(., size(zero)) xmtick(1960(1)2011) xline(1969.916667) xline(1992.916667) yline(1) ylabel(0(1)3) legend(order(1 "Theta" 2 "Polity IV") col(2) position(0.8 0.2)) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))
graph export "figure_6.png", replace width(2620) height(1908)

* Figure 7: "Evolution of GDP Per Capita Growth in Sub-Saharan Africa, 1963-2011"
twoway (line gr_ssa year, lwidth(medthick)) (line gr_kenya year, lwidth(medthick) lpattern(dash)), ytitle(GDP Per Capita Growth (%) 5-y. Moving Avg.) ytitle(, margin(small)) xtitle(., size(zero)) xmtick(1960(1)2011) xline(1969.916667) xline(1992.916667) legend(order(1 "Sub-Saharan Africa" 2 "Kenya") col(2) position(0.8 0.2)) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))
graph export "figure_7.png", replace width(2620) height(1908)

** APPENDIX PAPER FIGURE: 5 **
* Appendix Figure A.5: "Democratic Change in the World and Sub-Saharan Africa, 1960-2011"
twoway (line democ_ssa year, lwidth(medthick)) (line democ_world year, lwidth(medthick) lpattern(dash)), ytitle(Share of Democracies (%, Pop.-Weighted Av.)) ytitle(, margin(small)) xtitle(., size(zero)) xmtick(1960(1)2011) ymtick(0.2(0.2)1) legend(order(1 "Sub-Saharan Africa" 2 "World") col(2) position(0.8 0.2)) graphregion(fcolor(white) lcolor(white) ifcolor(white) ilcolor(white))
graph export "figure_A5.png", replace width(2620) height(1908)

