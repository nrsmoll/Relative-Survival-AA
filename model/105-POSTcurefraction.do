

$figuresfolder
sts graph if $agecat==2, by($agecat) tmax(10) hazard addplot((line h _t if $agecat==2, by($agecat) sort ylabel(0 .25 .50 .75 1.00) ytitle("Hazard Function") xtitle("Time")) )
graph export "POSTplottedhazards.eps", replace as(eps)

weibullfit h_uncured if $agecat==2, cluster(patientid)
qweibull h_uncured if $agecat==2, title(Q-Q Plot) subtitle(Data vs Fitted Weibull Distribution) grid 
graph export "POSTqqplot.eps", replace as(eps)

$modelfolder
