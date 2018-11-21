*Location Categories

*All locations
gen loc=.
replace loc=1 if primarysite==300
replace loc=2 if primarysite==310
replace loc=3 if primarysite==311
replace loc=4 if primarysite==312
replace loc=5 if primarysite==313
replace loc=6 if primarysite==318|primarysite==319
replace loc=7 if primarysite==119|primarysite==110
replace loc=8 if primarysite==718|primarysite==725
replace loc=99 if primarysite==749|primarysite==90|primarysite==695|primarysite==410

label define loc 1 "Nasal Cavity" 2 "Maxillary Sinus" 3 "Ethmoid Sinus" 4 "Frontal Sinus" 5 "Sphenoid Sinus" 6 "Accessory Sinus" 7 "Nasopharynx" 8 "CNS" 99 "Atypical" 
la val loc loc
la var loc "Specific Tumor Location"

gen tumorloc=.
replace tumorloc=1 if loc==1|loc==7
replace tumorloc=2 if loc>=2 & loc<=6
replace tumorloc=3 if loc>7
label define tumorloc 1 "Nasal Cavity" 2 "Sinuses" 3 "Other"
la val tumorloc tumorloc
la var tumorloc "General Location"
*NOTE: there are only 3 "other" tumors - exclude in analysis



