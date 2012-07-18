GetSpeciesIDsForaModel <- function(mdl){
  specs <- mdl@species
  n <- length(specs)
  Spec_IDs <- character(n)
  if(n != 0){
    for(i in 1:n){
      Spec_IDs[i] <- specs[[i]]@id
    }
  }
  return(Spec_IDs)
}

OrderSpeciesIDs <- function(mdl, vec_1){
  vec_2 <- character()
  vec_3 <- character()
  lst <- mdl@reactions
  lst_3 <- list()
  n <- length(lst)
  k <- 1
  k_1 <- 1
  if(n != 0){
    for(i in 1:n){
      lst_1 <- lst[[i]]@reactants
      lst_2 <- lst[[i]]@products
      m <- length(lst_1)
      if(m != 0){
        for(j in 1:m){
          vec_2[k] <- lst_1[[j]]@species
          k <- k + 1
        }
      }
      l <- length(lst_2)
      if(l != 0){
        for(j in 1:l){
          vec_3[k_1] <- lst_2[[j]]@species
          k_1 <- k_1 + 1
        }
      }
    }
    lst_3[[1]] <- vec_2
    lst_3[[2]] <- vec_3
    vec_4 <- unique(unlist(lst_3))
  } else {
    vec_4 <- character(0)
  }
  return(vec_4)
}

GetUniqueSpecies <- function(filenames){
  mdls <- GetModels(filenames)
  n <- length(mdls)
  lst <- list()
  for(i in 1:n){
    mdl <- mdls[[i]]
    specs <- GetModelSpecies(mdl)
    spec_IDs <- GetSpeciesIDs(specs)
    ordered_IDs <- OrderSpeciesIDs(mdl, spec_IDs)
    lst[[i]] <- ordered_IDs
  }
  x <- unlist(lst)
  x_1 <- unique(x)
  return(x_1)
}

ReactionConnections <- function(react, spec){
  is.reverse <- react@reversible
  rctnts <- react@reactants
  prdcts <- react@products
  m <- length(rctnts)
  n <- length(prdcts)
  rctnt_IDs <- character(m)
  prdct_IDs <- character(n)
  if(m != 0){
    for(i in 1:m){
      rctnt_IDs[i] <- rctnts[[i]]@species
    }
  } else {
    rctnt_IDs <- "No_Reactants"
  }
  if(n != 0){
    for(j in 1:n){
      prdct_IDs[j] <- prdcts[[j]]@species
    }
  } else {
    prdct_IDs <- "No_Reactants"
  }
  vec <- numeric(2)
  if(sum(spec == rctnt_IDs) != 0){
    if(is.reverse == TRUE){
      vec[1] <- sum(spec == rctnt_IDs)
      vec[2] <- sum(spec == rctnt_IDs)
    } else {
      vec[1] <- sum(spec == rctnt_IDs)
    }
  }
  if(sum(spec == prdct_IDs) != 0){
    if(is.reverse == TRUE){
      vec[1] <- sum(spec == prdct_IDs)
      vec[2] <- sum(spec == prdct_IDs)
    } else {
      vec[2] <- sum(spec == prdct_IDs)
    }
  }
  return(vec)
}

GetAllConnectionsInAModel <- function(mdl){
  spec_IDs <- GetSpeciesIDsForaModel(mdl)
  ordered_spec_IDs <- OrderSpeciesIDs(mdl, spec_IDs)
  reacts <- mdl@reactions
  m <- length(reacts)
  n <- length(ordered_spec_IDs)
  vec_1 <- numeric(n)
  vec_2 <- numeric(n)
  if(n != 0){
    if(m != 0){
      for(i in 1:n){
        spec <- ordered_spec_IDs[i]
        for(j in 1:m){
          react <- reacts[[j]]
          connects <- ReactionConnections(react, spec)
          vec_1[i] <- vec_1[i] + connects[1]
          vec_2[i] <- vec_2[i] + connects[2]
        }
      }
    }
  }
  vec <- ordered_spec_IDs
  df <- data.frame(vec, vec_1, vec_2, stringsAsFactors = FALSE)
  return(df)
}

GetAllConnections <- function(mdls){
  n <- length(mdls)
  for(i in 1:n){
    mdl <- mdls[[i]]
    if(i == 1){
      df <- GetAllConnectionsInAModel(mdl)
    } else {
      df_1 <- GetAllConnectionsInAModel(mdl)
      df <- rbind(df, df_1)
    }
  }
  return(df)
}

SortOutAllConnections <- function(dtfm){
  specs <- dtfm[, 1]
  uniq_specs <- unique(specs)
  n <- length(uniq_specs)
  vec_1 <- numeric(n)
  vec_2 <- numeric(n)
  for(i in 1:n){
    spec <- uniq_specs[i]
    df_1 <- dtfm[dtfm[, 1] == spec, ]
    vec_1[i] <- sum(df_1[, 2])
    vec_2[i] <- sum(df_1[, 3])
  }
  df <- data.frame(uniq_specs, vec_1, vec_2, stringsAsFactors = FALSE)
  colnames(df) <- c("Species", "Number Of Reactant Connections", "Number Of Product Connections")
  return(df)
}

AverageNumberOfConnections <- function(dtfm){
  Average <- (sum(dtfm[, 2]) + sum(dtfm[, 3]))/length(dtfm[, 1])
  return(Average)
}

GetParameters <- function(mdl){
  lst <- list()
  lst_1 <- list()
  lst[[1]] <- (parameters(mdl))
  reacts <- reactions(mdl)
  n <- length(reacts)
  if(n != 0){
    for(i in 1:n){
      react <- reacts[[i]]
      paras <- react@kineticLaw@parameters
      if(length(paras) != 0){
        lst_1[[i]] <- paras
      }
    }
  }
  lst[[2]] <- unlist(lst_1) 
  return(unlist(lst))
}

ProportionOfUnknownParameters <- function(paras){
  n <- length(paras)
  unknown_initial_value <- 0
  known_initial_value <- 0
  for(i in 1:n){
    para <- paras[[i]]
    if(length(para) != 0){
      if(length(para@value) != 0){
        known_initial_value <- known_initial_value + 1
      } else {
        unknown_initial_value <- unknown_initial_value + 1
      }
    }
  }
  total <- known_initial_value + unknown_initial_value
  proportion <- unknown_initial_value/total
  return(proportion)
}

ProportionOfUnknownParametersForallModels <- function(lst){
  n <- length(lst)
  vec <- numeric(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    params <- GetParameters(mdl)
    unknown_params <- ProportionOfUnknownParameters(params)
    vec[i] <- unknown_params  
  }
  return(vec)
}

ProportionOfUnknownSpecies <- function(mdl){
  specs <- species(mdl)
  n <- length(specs)
  unknown_initial_value <- 0
  known_initial_value <- 0
  if(n != 0){
    for(i in 1:n){
      spec <- specs[[i]]
      if(length(spec) != 0){
        if(length(spec@initialAmount) == 0 & length(spec@initialConcentration) == 0){
          unknown_initial_value <- unknown_initial_value + 1
        } else {
          known_initial_value <- known_initial_value + 1
        }
      }
    }
    total <- known_initial_value + unknown_initial_value
    proportion <- unknown_initial_value/total
  } else {
    proportion <- -1
  }
  return(proportion)
}

ProportionOfUnknownSpeciesForallModels <- function(lst){
  n <- length(lst)
  vec <- numeric(n)
  for(i in 1:n){
    mdl <- lst[[i]]
    unknown_specs <- ProportionOfUnknownSpecies(mdl)
    vec[i] <- unknown_specs  
  }
  return(vec)
}

GetModelsboTerms <- function(direc, fl){
  pattern <- " sboTerm=\"SBO:[[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]\""
  xml <- rsbml_xml(fl)
  m <- gregexpr(pattern, xml)
  mtchs <- regmatches(xml, m)
  sboTermVec <- unlist(mtchs)
  return(sboTermVec)
}

FrequencyOfsboTermsInaModel <- function(vec){
  unqTerms <- unique(vec)
  n <- length(unqTerms)
  freqvec <- numeric(n)
  for(i in 1:n){
    freqvec[i] <- sum(vec == unqTerms[i])
  }
  return(freqvec)
}

DataFrameOfsboTermsInaModel <- function(direc, fl, mdl){
  Terms <- GetModelsboTerms(direc, fl)
  if(length(Terms) != 0){
    unqTerms <- unique(Terms)
    freq <- FrequencyOfsboTermsInaModel(Terms)
    n <- length(unqTerms)
    ModID <- character(n)
    if(length(id(mdl)) == 0){
      ID <- name(mdl)
    } else {
      ID <- id(mdl)
    }
    for(i in 1:n){
      ModID[i] <- ID
    }
    df <- data.frame(unqTerms, ModID, freq, stringsAsFactors = FALSE)
  } else {
    df <- data.frame()
  }
  return(df)
}

DataFrameOfsboTermsinAllModels <- function(direc, fls, mdls){
  n <- length(fls)
  for(i in 1:n){
    fl <- fls[[i]]
    mdl <- mdls[[i]]
    df1 <- DataFrameOfsboTermsInaModel(direc, fl, mdl)
    if(i == 1){
      df <- df1 
    } else {
      df <- rbind(df, df1)
    }
  }
  return(df)
}

##Tests
f <- DataFrameOfsboTermsinAllModels("sbml_models/curated", a, b)
GetModelsboTerms("sbml_models/curated", a[[1]])
rsbml_doc(a[[1]])
?rsbml_dom