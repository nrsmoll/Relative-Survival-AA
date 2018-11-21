*Dataset creation
$analysisfolder
use $tumor, clear
stset survdatemo, origin(time modx) enter(time $early) exit(time $late) id(patientid) failure(lifestatus==2) scale(12)
	strs using expectedsurvival, breaks($initial($span)$finish) mergeby(_year sex _age _race) by($agecat) savind(individ$agecat, replace) savgroup(grouped$agecat, replace) notables

$modelfolder


