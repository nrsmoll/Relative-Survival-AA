*---------------------------Duplicates and Dropped Variables------------------------------------
$analysisfolder

describe age sex race loc tumorloc surg rad seervitalstatus lifestatus yearofdiagnosis ///
	age6cat age7cat pedages yrdx2006 yrdx2007 ///
	radiation2 radreason radseq99 survmo yydx modx survdatemo survdate v2

tab sex
assert sex==1 | sex==2

sum age

tab race
assert race==1 | race==2 | race==3 | race==4

sum yydx
assert yydx>=1973 & yydx<=2010

duplicates report patientid
duplicates list patientid
duplicates drop patientid, force

$spreadsheetfolder
