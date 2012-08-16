### Analysis of the Biomodels database

The files functions.R, functions2.R and functions3.R contain all the functions used to download and extract information from the biomodels. They are sourced by the other R scripts and do not need to be opened.

 * functions.R contains the functions used to download the sbml files and then extract the models from the sbml that can be read in R, using the package rsbml.
 * functions2.R contains the functions used to extract basic model information, for example number of speices, and the functions used to extract model dates and find the cummulative number of models and species for each year.
 * functions3.R contains the functions used to find the number of connections per species and to extract sboTerms from the models.

With the exception of graphics.R, the remaining files source the relevent function file in order to extract infomation from the models or to get the models from the sbml files.

 * download_models.R contains the code to download a weekly archive from the biomodels database (currently the archive uploaded on 13/08/2012), find which files can be read into R and converted to an S4 class object, before obtaining the models from those files.
 * extract_basic_model_information.R contains the code to source functions from functions2.R and then use those functions to extract basic information from the models, for exmaple number of species or model ID. 
 * models_and_species_over_time.R contains the code to source functions from functions3.R, then uses the functions to work out the cummulative number of biomodels and species for each year since 2005, the year the first biomodels were uploaded to the database.
 * average_number_of_connections.R contains the code find the average number of connections per species. In this case, a connection is defined as being if a species is present in a reaction, if yes, this counts as a connection. If a species appears in a reversible reaction, this is counted as two connections. The code also produces a data frame showing the number of connections for each individual species.
 * summary_of_models.R takes the basic information extracted from the biomodels, along with information about the proportion of parameters and species that do not have initial values, and stores the information in a data frame.
 * extracting_sboTerms.R contains the code to extract the sboTerms from each model, along with how many times each sboTerm appears in a particualr model and summarises the inforamtion in a data frame.
 * The file grpahics.R contains all the plot commands. This should be run after the files listed above The graphs are stored in the directory Graphs, which is generated when the code in graphics.R is run.

The file poster.tex contains the LaTeX code to generate the poster summarising the project. The completed poster can be viewed in the file poster.tex. The images required for the poster in the directory Poster-images.