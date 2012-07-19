source("functions.R")
sbml_docs <- GetTheFilesThatWork("sbml_models/curated")
Models <- GetModels(sbml_docs)
rm(list=c("arc", "arc_tar_bz2", "base_url", "dest", "dest_tar", "dest_tar_bz2"))