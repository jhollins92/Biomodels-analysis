library(rsbml)
library(RCurl)
library(httr)

dest = "sbml_download"
dest_tar = paste(dest, "tar", sep=".")
dest_tar_bz2 = paste(dest_tar, "bz2", sep=".")
base_url = "ftp://ftp.ebi.ac.uk/pub/databases/biomodels/weekly_archives/2012/"
arc = "BioModels-Database-weekly-2012-07-16-sbmls"
arc_tar_bz2 = paste(arc, ".tar.bz2", sep="")
download.file(paste(base_url, arc_tar_bz2, sep=""), dest_tar_bz2)
system(paste("bunzip2 ", dest_tar_bz2))
system(paste("tar xvf ", dest_tar))
file.rename(arc, "sbml_models")

GetTheFilesThatWork <- function(direc){
  l <- list.files(direc)
  n <- length(l)
  lst <- list()
  for(i in 1:n){
    fl <- paste("sbml_models/curated", "/" ,l[i], sep="")
    lst[[i]] <- try(rsbml_read(fl, dom=FALSE), silent=TRUE)
    if(class(lst[[i]]) == "SBMLDocument"){
     dom <- try(rsbml_dom(lst[[i]]), silent=TRUE)
      if(class(dom) != "SBML"){
        lst[[i]] <- "Model Doesn't Work"
      }
    } else {
      lst[[i]] <- "Model Doesn't Work"
    }
  }
  return(lst[lst != "Model Doesn't Work"])
}

GetModels <- function(lst){
  n <- length(lst)
  for(i in 1:n){
    lst[[i]] <- rsbml_dom(lst[[i]])
    lst[[i]] <- model(lst[[i]])
  }
  return(lst)
}

