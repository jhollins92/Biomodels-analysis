functionnames <- c("AverageNumberOfConnections", "ConvertDateStringsToYears", "CummulativeNumberOfModelsInEachYear", "CummulativeNumberOfSpeciesInEachYear", "DataFrameOfsboTermsinAllModels", "DataFrameOfsboTermsInaModel", "FindAllYears", "FrequencyOfsboTermsInaModel", "GetAllConnections", "GetAllConnectionsInAModel", "GetAllSpeciesFromAYear", "GetModelsboTerms", "GetSpeciesIDsForaModel", "GetStartDateStrings", "GetUniqueSpecies", "IdentifyAllModelsInAnyGivenYear", "OrderSpeciesIDs", "ReactionConnections", "SortOutAllConnections")
source("functions3.R")
allconnections <- GetAllConnections(Models)
ordereddataframe <- SortOutAllConnections(allconnections)
rm(allconnections)
averagenumberofconnectionsperspecies <- AverageNumberOfConnections(ordereddataframe)
averagenumberofconnectionsperspecies
rm(list=functionnames)
rm(functionnames)