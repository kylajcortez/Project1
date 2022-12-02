clear
set more off
use "C:\Users\kyla\Downloads\gss2021.dta"

* dropping NAs *
drop if sei10 == .i
drop if age == .i

drop if sex == .i
drop if sex == .n
drop if sex == .s


drop if born == .i 
drop if born == .d
drop if born == .s


*recode*
gen native = born
recode native 1 = 1 2 = 0
label define foriegn 1 "Native-Born" 0 "Foriegn-Born"
label value native foriegn
tab native, missing

gen sx = sex
recode sx(1=0) (2=1) 
label define gender 1"Female" 0"Male" 
label values sx gender
tab sx


* dependent variable *
su sei10, detail

* independent variables *
su age, detail

tab native
tab sx

* correlation * ///add asdoc to corr & reg///
pwcorr sei10 age native sx, obs sig

* regression *
regress sei10 age 
regress sei10 native 
regress sei10 sx
regress sei10 age native sx
