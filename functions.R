library(rsbml)
library(RCurl)
library(httr)

DownloadArchive <- function(){
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
}

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

GetAllModelIDs <- function(lst){
  n <- length(lst)
  u <- character(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    if(length(id(mdl)) == 0){
      u[i] = name(mdl)
    } else {
      u[i] = id(mdl)
    }
  }
  return(u)
}

NumberofCompartmentsInEachModel <- function(lst){
  n <- length(lst)
  v = numeric(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    v[i] = length(sapply(compartments(mdl), id))
  }
  return(v)
}

NumberofSpeciesInEachModel <- function(lst){
  n <- length(lst)
  w = numeric(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    w[i] = length(sapply(species(mdl), id))
  }
  return(w)
}

NumberofReactionsInEachModel <- function(lst){
  n <- length(lst)
  x = numeric(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    x[i] = length(sapply(reactions(mdl), id))
  }
  return(x)
}

NumberofGlobalParametersInEachModel <- function(lst){
  n <- length(lst)
  y = numeric(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    y[i] = length(sapply(parameters(mdl), id))
  }
  return(y)
}

NumberofLocalParametersInEachModel <- function(lst){
  n <- length(lst)
  z = numeric(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    r = reactions(mdl)
    m = length(r)
    if(m == 0){
      z[i] = 0
    } else {
      sm = numeric(m)
      for(j in 1:m){
        s = length(r[[j]]@kineticLaw@parameters)
        sm[j] = s
      }
      z[i] = sum(sm)
    }  
  }
  return(z)
}

GetStartDateStrings <- function(lst){
  n <- length(lst)
  z <- character(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    string_1 <- mdl@annotation
    x <- strsplit(string_1, "<dcterms:W3CDTF>")
    y <- strsplit(x[[1]][2], "T")
    z[i] <- y[[1]][1]
  }
  return(z)
}

ConvertDateStringsToYears <- function(vec){
  date <- as.Date(vec)
  posixlt <- as.POSIXlt(d)
  years <- posixlt$year + 1900
  return(years)
}

CummulativeNumberOfModelsInEachYear <- function(years){
  n <- max(years) - (min(years) - 1)
  s <- numeric(n)
  for(i in 1:n){
    s[1] = sum(years==min(years))
    for(j in 1:(n-1)){
      year = min(years) + j
      s[j+1] = s[j] +sum(years==year)
    }
  }
  return(s)
}

FindAllYears <- function(years){
  n <- max(years) - (min(years) - 1)
  vec <- numeric(n)
  for(i in 1:n){
    vec[i] <- min(years) - 1 + i
  }
  return(vec)
}

IdentifyAllModelsInAnyGivenYear <- function(vector, year){
  n <- length(vector)
  for(i in 1:n){
    if(vector[i] == year){
      vector[i] = i
    } else {
      vector[i] = 0
    }
  }
  z = vector[vector != 0]
  return(z)
}

GetAllSpeciesFromAYear <- function(lst, vector){
  n <- length(vector)
  x <- list()
  for(i in 1:n){
    v <- vector[i]
    mdl <- lst[[v]]
    s <- sapply(species(mdl), id)
    u <- names(s)
    x[[i]] <- u
  }
  return(x)
}

CummulativeNumberOfSpeciesInEachYear <- function(lst, years){
  lst_1 <- list()
  n <- max(years) - min(years) + 1
  s <- numeric(n)
  for(i in 1:n){
    yr <- 2004 + i
    mdls <- IdentifyAllModelsInAnyGivenYear(years, yr)
    lst_1[[i]] <- unlist(GetAllSpeciesFromAYear(lst, mdls))
    u <- unlist(lst_1)
    s[i] <- length(unique(u))
  }
  return(s)
}

##Tests
DownloadArchive()
a <- GetTheFilesThatWork("sbml_models/curated")
b <- GetModels(a)
a[[1]]
##End of Tests
l <- list.files("sbml_models/curated")
n <- length(l)
lst <- list()
for(i in 1:n){
  fl <- paste("sbml_models/curated", "/" ,l[i], sep="")
  lst[[i]] <- try(rsbml_read(fl, dom=FALSE), silent=TRUE)
  if(class(lst[[i]]) == "SBMLDocument"){
    lst[[i]] <- try(rsbml_dom(lst[[i]]), silent=TRUE)
    if(class(lst[[i]]) != "SBML"){
      lst[[i]] <- "Model Doesn't Work"
    }
  } else {
    lst[[i]] <- "Model Doesn't Work"
  }
}