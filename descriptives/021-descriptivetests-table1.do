*descriptive tests 
$analysisfolder
use $tumor, clear
*bootstrap median=r(p50), reps(200): sum age `if', detail
*bootstrap LIQR=r(p25), reps(200): sum age `if', detail
*bootstrap UIQR=r(p75), reps(200): sum age `if', detail
*bootstrap diff=(r(p75)-r(p25)), reps(200): sum age `if', detail

tab sex $agecat, col chi2
tab race $agecat, col chi2
tab yrdx $agecat, col chi2
tab rad $agecat, col chi2
tab surg $agecat, col chi2

tabstat age, statistic(p25 p50 p75 iqr)

$tablesfolder
tabout sex yrdx rad surg agecat using table1.csv, replace c(freq col) lines(none) clab(No. % No. %) f(0 0p 0 0p 0 0p) style(csv) layout(No. % No. %) h3(nil)
$descriptivesfolder



