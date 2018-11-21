*Saving Final Dataset
$analysisfolder

notes: No delayed entry models are being used in this analysis
notes: 6 Folders are required for this program - 4 for do files (including a dofile folder), one each for analysis, figures and tables.
notes: This is for the 2006 SEER dataset. The limiting factor is the dates of the expected mortality tables, therefore even though
notes: There is a 2008 dataset, because of the 2006 limit of the expected mortality tables your data must be right truncated at 2006
notes: Expected survival file should be named "expectedsurvival.dta", and must be placed in the analysis folder
notes: Period macro used for delayed entry analysis. Period is the number of months the interval is when performing longitudinal relative survival analyses
notes: LCRS = Longitudinal relative survival. LCRStimeunit macro is the interval at which longitudinal relative survival is measured at. Insert two if you want it to measure longitudinal 2 year survival rates.
notes: The period macro denotes the intervals at which you want to test the target survival function. Will define how many dots on the graph
notes: The window macro is the width of the window at which you are collecting data within for the period approach.

save $tumor, replace

