source("functions.R")
DownloadSBMLFiles()
sbml_docs = GetTheFilesThatWork("sbml_models/curated")
Models = GetModels(sbml_docs)