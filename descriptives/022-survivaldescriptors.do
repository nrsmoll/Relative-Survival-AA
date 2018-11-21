*survival figures

$analysisfolder
*Main analysis
use $tumor, clear
$globalstset
stsum
stsum, by($agecat)
stdescribe
sts list, at(0.25 0.5 1 2 5 10)
sts list, at(0.25 0.5 1 2 5 10) by($agecat)
$descriptivesfolder

sts test $agecat
sts test sex 
sts test yrdx
sts test rad 
sts test surg

