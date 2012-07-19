functionnames <- c("GetAllModelIDs", "NumberofCompartmentsInEachModel", "NumberofSpeciesInEachModel", "NumberofReactionsInEachModel", "NumberofGlobalParametersInEachModel", "NumberofLocalParametersInEachModel", "GetParameters", "ProportionOfUnknownParameters", "ProportionOfUnknownParametersForallModels", "ProportionOfUnknownSpecies", "ProportionOfUnknownSpeciesForallModels")
source("functions2.R")
##Getting The Required Information
IDs <- GetAllModelIDs(Models)
comparts <- NumberofCompartmentsInEachModel(Models)
n <- max(comparts)
vec <- numeric(n)
names <- numeric(n)
for(i in 1:n){
  vec[i] <- sum(comparts == i)
  names[i] <- i
}
specs <- NumberofSpeciesInEachModel(Models)
reacts <- NumberofReactionsInEachModel(Models)
globalparams <- NumberofGlobalParametersInEachModel(Models)
localparams <- NumberofLocalParametersInEachModel(Models)
##Plots
rm(list=functionnames)
rm(list=c("functionnames", "i", "n"))