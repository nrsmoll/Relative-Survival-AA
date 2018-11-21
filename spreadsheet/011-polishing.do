*Polishing Dataset

order patientid age agecat sex yrdx loc tumorloc race racerecodewhiteblackother surg rad radseq seervitalstatus lifestatus
drop survivalmonths radiationsequencewithsurgery ageatdiagnosis ///
	behaviorcodeicdo31973 surgeryofprimarysite19982002 sitespecificsurgery19831997 ///
	radiationsequencewithsurgery reasonnocancerdirectedsurgery ///
	vitalstatusrecodestudycutoffused seercausespecificdeathclassification  ///
	vitalstatusrecodestudycutoffused laterality1973 surg1 typeoffollowupexpected ///
	rxsummsurgprimsite1998 radiationtobrainorcns19881997 cstumorsize2004 ///
	grade primarysite diagnosticconfirmation maritalstatusatdiagnosis racerecodewhiteblackother
drop eod10extent19882003 radiation cssitespecificfactor12004 cssitespecificfactor22004 ///
	cssitespecificfactor32004 cssitespecificfactor42004 cssitespecificfactor52004 ///
	cssitespecificfactor62004 eod10extent19882003 eod10size19882003 eod4extent19831987 eod4size19831987 ///
	csmetsatdx2004 csextension2004
$spreadsheetfolder
