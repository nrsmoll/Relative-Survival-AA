* Treatement Categories

encode reasonnocancerdirectedsurgery, gen(surg1)
encode radiation, gen(radiation2)
encode radiationtobrainorcns19881997, gen(radreason)
encode radiationsequencewithsurgery, gen(radseq99)

gen radseq=.
replace radseq=1 if radseq99<4 | radseq99==7
replace radseq=2 if radseq99==6
replace radseq=3 if radseq99==5
replace radseq=4 if radseq99==4
label define radseq 1 "Other" 2 "Prior to Surgery" 3 "Before and After" 4 "Radiation After Surgery"
label value radseq radseq
la var radseq "Radiation Sequence with Surgery"

gen rad=.
replace rad=1 if radiation2==3 | radiation2==7 | radiation2==0
replace rad=2 if radiation2==1 | radiation2==2 | radiation2==5 | radiation2==4 | radiation2==6
replace rad=3 if radiation2==8|radiation2==9
label define rad 1 "None" 2 "Radiation" 3 "Unknown" 
la val rad rad
la var rad "Radiation Treatment Status"

gen surg=.
replace surg=1 if surg1==6
replace surg=2 if surg1==1 | surg1==2 | surg1==3 | surg1==4 | surg1==5
replace surg=3 if surg1==7
label define surg 1 "Surgery" 2 "No Surgery Performed" 3 "Unknown"
la val surg surg
la var surg "Surgery Status"
