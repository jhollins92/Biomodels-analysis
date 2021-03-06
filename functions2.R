GetAllModelIDs = function(lst){
  n = length(lst)
  u = character(n)
  for(i in 1:n){
    mdl = lst[[i]]
    if(length(id(mdl)) == 0){
      u[i] = name(mdl)
    } else {
      u[i] = id(mdl)
    }
  }
  return(u)
}

NumberofCompartmentsInEachModel = function(lst){
  n = length(lst)
  v = numeric(n)
  for(i in 1:n){
    mdl = lst[[i]]
    v[i] = length(sapply(compartments(mdl), id))
  }
  return(v)
}

SummariseCompartmentData = function(vec){
  ls = list()
  n = max(vec)
  vec1 = numeric(n)
  for(i in 1:n){
    vec1[i] = sum(vec == i)
  }
  vec2 = seq(1:7)
  ls[[1]] = vec1
  ls[[2]] = vec2
  return(ls)
}

NumberofSpeciesInEachModel = function(lst){
  n = length(lst)
  w = numeric(n)
  for(i in 1:n){
    mdl = lst[[i]]
    w[i] = length(sapply(species(mdl), id))
  }
  return(w)
}

NumberofReactionsInEachModel = function(lst){
  n = length(lst)
  x = numeric(n)
  for(i in 1:n){
    mdl = lst[[i]]
    x[i] = length(sapply(reactions(mdl), id))
  }
  return(x)
}

NumberofGlobalParametersInEachModel = function(lst){
  n = length(lst)
  y = numeric(n)
  for(i in 1:n){
    mdl = lst[[i]]
    y[i] = length(sapply(parameters(mdl), id))
  }
  return(y)
}

NumberofLocalParametersInEachModel = function(lst){
  n = length(lst)
  z = numeric(n)
  for(i in 1:n){
    mdl = lst[[i]]
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

RatioOfSpeciesToReactions = function(vec, vec1){
  df = data.frame(vec, vec1, stringsAsFactors=FALSE)
  df = df[df[ ,2] != 0, ]
  return(df[,1]/df[,2])
}

GetParameters = function(mdl){
  lst = list()
  lst_1 = list()
  lst[[1]] = (parameters(mdl))
  reacts = reactions(mdl)
  n = length(reacts)
  if(n != 0){
    for(i in 1:n){
      react = reacts[[i]]
      paras = react@kineticLaw@parameters
      if(length(paras) != 0){
        lst_1[[i]] = paras
      }
    }
  }
  lst[[2]] = unlist(lst_1) 
  return(unlist(lst))
}

ProportionOfUnknownParameters = function(paras){
  n = length(paras)
  unknown_initial_value = 0
  known_initial_value = 0
  for(i in 1:n){
    para = paras[[i]]
    if(length(para) != 0){
      if(length(para@value) != 0){
        known_initial_value = known_initial_value + 1
      } else {
        unknown_initial_value = unknown_initial_value + 1
      }
    }
  }
  total = known_initial_value + unknown_initial_value
  proportion = unknown_initial_value/total
  return(proportion)
}

ProportionOfUnknownParametersForallModels = function(lst){
  n = length(lst)
  vec = numeric(n)
  for(i in 1:n){
    mdl = lst[[i]]
    params = GetParameters(mdl)
    unknown_params = ProportionOfUnknownParameters(params)
    vec[i] = unknown_params  
  }
  return(vec)
}

ProportionOfUnknownSpecies = function(mdl){
  specs = species(mdl)
  n = length(specs)
  unknown_initial_value = 0
  known_initial_value = 0
  if(n != 0){
    for(i in 1:n){
      spec = specs[[i]]
      if(length(spec) != 0){
        if(length(spec@initialAmount) == 0 & length(spec@initialConcentration) == 0){
          unknown_initial_value = unknown_initial_value + 1
        } else {
          known_initial_value = known_initial_value + 1
        }
      }
    }
    total = known_initial_value + unknown_initial_value
    proportion = unknown_initial_value/total
  } else {
    proportion = -1
  }
  return(proportion)
}

ProportionOfUnknownSpeciesForallModels = function(lst){
  n = length(lst)
  vec = numeric(n)
  for(i in 1:n){
    mdl = lst[[i]]
    unknown_specs = ProportionOfUnknownSpecies(mdl)
    vec[i] = unknown_specs  
  }
  return(vec)
}
