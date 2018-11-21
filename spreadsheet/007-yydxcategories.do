*Year of Diagnosis Categories


gen yrdx2006=.
replace yrdx2006=1 if yearofdiagnosis<1984
replace yrdx2006=2 if (yearofdiagnosis>=1984 & yearofdiagnosis<=1995)
replace yrdx2006=3 if (yearofdiagnosis>=1996 & yearofdiagnosis<=2006)
replace yrdx2006=99 if yearofdiagnosis>2006
label define dxyr2006 1 "1973-1984" 2 "1985-1995" 3 "1996-2006" 99 "Outside of 2006"
label value yrdx2006 dxyr2006
la var yrdx2006 "Year grouping with top year of 2006"

gen yrdx2007=.
replace yrdx2007=1 if yearofdiagnosis<1984
replace yrdx2007=2 if (yearofdiagnosis>=1984 & yearofdiagnosis<=1995)
replace yrdx2007=3 if (yearofdiagnosis>=1996 & yearofdiagnosis<=2007)
replace yrdx2007=99 if yearofdiagnosis>2007
label define dxyr2007 1 "1973-1984" 2 "1985-1995" 3 "1996-2007" 99 "Outside of 2007"
label value yrdx2007 dxyr2007
la var yrdx2006 "Year grouping with top year of 2007"

gen yrdx=.
replace yrdx=1 if yearofdiagnosis<1985
replace yrdx=2 if (yearofdiagnosis>=1985 & yearofdiagnosis<=1996)
replace yrdx=3 if (yearofdiagnosis>=1997 & yearofdiagnosis<=2008)
replace yrdx=99 if yearofdiagnosis>2008
label define dxyr 1 "1973-1984" 2 "1985-1996" 3 "1997-2008" 99 "Outside of 2008"
label value yrdx dxyr
la var yrdx "Year grouping with top year of 2008"

