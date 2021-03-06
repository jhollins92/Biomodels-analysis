functionnames = c("AverageNumberOfConnections", "ConvertDateStringsToYears", "CummulativeNumberOfModelsInEachYear", "CummulativeNumberOfSpeciesInEachYear", "DataFrameOfsboTermsinAllModels", "DataFrameOfsboTermsInaModel", "FindAllYears", "FrequencyOfsboTermsInaModel", "GetAllConnections", "GetAllConnectionsInAModel", "GetAllSpeciesFromAYear", "GetModelsboTerms", "GetSpeciesIDsForaModel", "GetStartDateStrings", "GetUniqueSpecies", "IdentifyAllModelsInAnyGivenYear", "OrderSpeciesIDs", "ReactionConnections", "SortOutAllConnections")
source("functions3.R")
allconnections = SortOutAllConnections(GetAllConnections(Models))
round(AverageNumberOfConnections(allconnections), digits=2)
rm(list=functionnames)
rm(functionnames)