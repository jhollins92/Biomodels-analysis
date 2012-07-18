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
barplot(vec, names.arg=names, xlab="Number of Compartments", ylab="Frequency", main="Barplot of the Number of Compartments \n in each Biomodel", ylim=c(0,200)) 
hist(specs[specs < 600], breaks = 40, xlim = c(0, 200), ylim = c(0, 100), xlab="Number of Species", ylab="Frequency", main="Histogram of the Number of Species \n in each Biomodel") 
hist(reacts[reacts < 400], breaks = 40, xlim = c(0, 400), ylim = c(0, 150), xlab="Number of Reactions", ylab="Frequency", main="Histogram of the Number of Reactions \n in each Biomodel")
hist(globalparams, breaks = 30, xlim = c(0, 300), ylim = c(0, 100), xlab="Number of Global Parameters", ylab="Frequency", main="Histogram of the Number of Global Parameters \n in each Biomodel")
hist(localparams[localparams < 400], breaks = 20, xlim=c(0, 400), ylim=c(0, 250), xlab="Number of Local Parameters", ylab="Frequency", main="Histogram of the Number of Local Parameters \n in each Biomodel")
rm(list=functionnames)
rm(list=c("functionnames", "i", "n", "names", "vec"))