## Basic Model Information Plots
dir.create("Graphs")

ppi = 600
png("Graphs/CompartmentBarplot.png", width=6*ppi, height=6*ppi, res=ppi)
barplot(comparts_summary[[1]], names.arg=comparts_summary[[2]], xlab="Number of Compartments", ylab="Frequency", main="Barplot of the Number of Compartments \n in each Biomodel", ylim=c(0,250)) 
dev.off()

png("Graphs/SpeciesHistogram.png", width=6*ppi, height=6*ppi, res=ppi)
hist(specs[specs < 200], breaks = 40, xlim = c(0,200), ylim = c(0, 120), xlab="Number of Species", ylab="Frequency", main="Histogram of the Number of Species \n in each Biomodel") 
dev.off()

png("Graphs/ReactionsHistogram.png", width=6*ppi, height=6*ppi, res=ppi)
hist(reacts[reacts < 200], breaks = 40, xlim=c(0, 200), ylim = c(0, 120), xlab="Number of Reactions", ylab="Frequency", main="Histogram of the Number of Reactions \n in each Biomodel")
dev.off()

png("Graphs/GlobalParametersHistogram.png", width=6*ppi, height=6*ppi, res=ppi)
hist(globalparams, breaks = 30, xlim = c(0, 300), ylim = c(0, 200), xlab="Number of Global Parameters", ylab="Frequency", main="Histogram of the Number of Global Parameters \n in each Biomodel")
dev.off()

png("Graphs/LocalParametersHistogram.png", width=6*ppi, height=6*ppi, res=ppi)
hist(localparams[localparams < 400], breaks = 40, xlim=c(0, 400), ylim=c(0, 300), xlab="Number of Local Parameters", ylab="Frequency", main="Histogram of the Number of Local Parameters \n in each Biomodel")
dev.off()

png("Graphs/SpeciesOverReactions.png", width=6*ppi, height=6*ppi, res=ppi)
hist(spectoreactratio, ylim=c(0, 150), xlab="Ratio of Species over Reactions", main="Histogram of the Ratio of Species over Reactions\n for Each Biomodel")
dev.off()
## Number of Models and Species against Time Plots

png("Graphs/CummulativeModelsPlot.png", width=6*ppi, height=6*ppi, res=ppi)
plot(allyears, cummulativenumberofmodels, type="l", ylim=c(0, 400), xlab="Years", ylab="Number of Models", main="Plot of Cummulative Number of\n Biomodels against Year")
dev.off()

png("Graphs/CummulativeSpeciesPlot.png", width=6*ppi, height=6*ppi, res=ppi)
plot(allyears, cummulativenumberofspecies, type="l", ylim=c(0, 5000), xlab="Years", ylab="Number of Species", main="Plot of Cummulative Number of\n Species against Year")
dev.off()