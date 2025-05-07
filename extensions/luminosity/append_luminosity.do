set more off

cd "."

use new_bltcfix_light_loc1992.dta, replace
forvalues var = 1993/2017 {
	append using new_bltcfix_light_loc`var'.dta
}

g new_bltcfix_lit=1 if new_bltcfix_light>0
replace new_bltcfix_lit=0 if new_bltcfix_light==0

* define 1/2 minimum value for windsoring
quietly sum new_bltcfix_light if new_bltcfix_light >0,d
local min_value = r(min)/2
di `min_value'

g new_bltcfix_lnlight_c=ln(`min_value'+new_bltcfix_light)

* prepare merge 
rename ADMIN_NAME distname_1979
replace distname_1979 = "Elgeyo Marakwet" if distname_1979 == "Elgeyo Karakwet"
replace distname_1979 = "Machakos" if distname_1979 == "Mackakos"
drop if distname_1979 == "Lake Turkana"
drop if distname_1979 == "Lake Victoria"
drop if year > 2011

save newlight_bltcfix_loc.dta, replace
