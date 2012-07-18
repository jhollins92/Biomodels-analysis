### Analysis of the Biomodels database

The files functions.R, functions2.R and functions3.R contain all the functions used to download and extract information from the biomodels. They are sourced by the other R scripts and do not need to be opened.

 * functions.R contains the functions used to download the sbml files and then extract the models from the sbml that can be read in R, using the package rsbml.
 * functions2.R contains the functions used to extract basic model information, for example number of speices, and the functions used to extract model dates and find the cummulative number of models and species for each year.
 * Functions3.R contains the functions used to find the number of connections per species and to extract sboTerms from the models.

With the exception of graphics.R, the remaining files source the relevent function file in order to extract infomation from the models or to get the models from the sbml files.



The files grpahics.R contains all the graphs produced by the R code used in the R files listed above.