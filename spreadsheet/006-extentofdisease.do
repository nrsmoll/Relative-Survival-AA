
destring csextension2004, gen(CSextension) ignore("Blank(s)")
drop csextension2004

gen Tnm=.
replace Tnm=1 if CSextension<=30 & CSextension>=10
replace Tnm=2 if CSextension==40
replace Tnm=3 if CSextension==60|CSextension==65|CSextension==67|CSextension==66
replace Tnm=4 if CSextension==70|CSextension==71
replace Tnm=0 if CSextension==95
replace Tnm=5 if CSextension==99
label define Tnm 0 "T0" 1 "T1" 2 "T2" 3 "T3" 4 "T4" 5 "Unknown"
label value Tnm Tnm
label var Tnm "T part of TNM"

*Code 66 has been removed from the T3 category so that it can be coded into Localized disease in variable "extent"
gen Tnm2=.
replace Tnm2=1 if CSextension<=30 & CSextension>=10
replace Tnm2=2 if CSextension==40
replace Tnm2=3 if CSextension==60|CSextension==65|CSextension==67
replace Tnm2=4 if CSextension==70|CSextension==71
replace Tnm2=0 if CSextension==95
replace Tnm2=5 if CSextension==99
label define Tnm2 0 "T0" 1 "T1" 2 "T2" 3 "T3" 4 "T4" 5 "Unknown"
label value Tnm2 Tnm2
label var Tnm2"T only Staging (without code 66)"

destring eod10extent19882003, gen(EOD10) ignore("Blank(s)")
destring cslymphnodes2004, gen(CSnodes) ignore("Blank(s)")
destring eod10nodes19882003, gen(EOD10nodes) ignore("Blank(s)")

gen nodes=.
replace nodes=0 if EOD10nodes==0|CSnodes==00
replace nodes=1 if EOD10nodes>=1 & EOD10nodes<9|CSnodes>=10 & CSnodes<99
replace nodes=99 if EOD10nodes==9 | CSnodes==99
la define nodes 0 "Lymph Node Negative" 1 "Lymph Node Positive" 99 "Unknown/not stated"
la val nodes nodes
la var nodes "Lymph Node Involvement"

*dropping all tumors without known lymph node status
*drop if nodes==99

destring csmetsatdx2004, gen(CSmets) ignore("Blank(s)")
drop csmetsatdx2004

gen kadish=.
replace kadish=1 if tumorloc==1 & EOD10<=30 | tumorloc==1 & CSextension<=30
replace kadish=2 if tumorloc==1 & EOD10>=60 & EOD10<85 |tumorloc==2 & EOD10<70 | tumorloc==2 & CSextension<=80 |tumorloc==1 & CSextension<68 & CSextension>30
replace kadish=3 if tumorloc==2 & EOD10>=70 & EOD10<85 | tumorloc==2 & CSextension>70 & CSextension<80 |tumorloc==1 & CSextension>=68 & CSextension<80
replace kadish=4 if tumorloc==1 & EOD10==85|tumorloc==2 & EOD10==85 | tumorloc==2 & CSextension>80 |tumorloc==1 & CSextension>80
la define kadish 1 "Kadish A" 2 "Kadish B" 3 "Kadish C" 4 "Kadish D"
la var kadish "Kadish Staging"

*drop if EOD10==99
*drop if EOD10==40
*drop if CSextension>=95

gen tnM=.
replace tnM=0 if CSmets==00
replace tnM=1 if CSmets>=10 & CSmets<=50
replace tnM=2 if CSmets==99
label define tnM 0 "M0" 1 "M1" 2 "Unknown"
label value tnM tnM
la var tnM "Metastastes"

gen extent=.
replace extent=1 if EOD10<=30|Tnm==1|EOD10==66
replace extent=2 if EOD10>=40 & EOD10<=80|Tnm>=2 & Tnm<=4 & tnM==0
replace extent=3 if EOD10==85|tnM==1
replace extent=9 if EOD10==99|Tnm==5|EOD10==.
label define extent 1 "Localized" 2 "Infiltrative" 3 "Metastatic" 9 "Unknown"
label value extent extent
la var extent "Extent of Disease GMS/Hopkins"

encode behaviorcodeicdo31973, gen(malignancy)
