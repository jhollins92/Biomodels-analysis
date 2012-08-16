## Basic Model Information Plots
dir.create("Graphs")

pdf("Graphs/CompartmentBarplot.pdf", width=6, height=6)
barplot(comparts_summary[[1]], names.arg=comparts_summary[[2]], xlab="Number of Compartments", ylab="Frequency", main="Barplot of the Number of Compartments \n in each Biomodel", ylim=c(0,250)) 
dev.off()

pdf("Graphs/SpeciesHistogram.pdf", width=6, height=6)
hist(specs[specs < 200], breaks = 40, xlim = c(0,200), ylim = c(0, 120), xlab="Number of Species", ylab="Frequency", main="Histogram of the Number of Species \n in each Biomodel") 
dev.off()

pdf("Graphs/ReactionsHistogram.pdf", width=6, height=6)
hist(reacts[reacts < 200], breaks = 40, xlim=c(0, 200), ylim = c(0, 120), xlab="Number of Reactions", ylab="Frequency", main="Histogram of the Number of Reactions \n in each Biomodel")
dev.off()

pdf("Graphs/GlobalParametersHistogram.pdf", width=6, height=6)
hist(globalparams, breaks = 30, xlim = c(0, 300), ylim = c(0, 200), xlab="Number of Global Parameters", ylab="Frequency", main="Histogram of the Number of Global Parameters \n in each Biomodel")
dev.off()

pdf("Graphs/LocalParametersHistogram.pdf", width=6, height=6)
hist(localparams[localparams < 400], breaks = 40, xlim=c(0, 400), ylim=c(0, 300), xlab="Number of Local Parameters", ylab="Frequency", main="Histogram of the Number of Local Parameters \n in each Biomodel")
dev.off()

pdf("Graphs/SpeciesOverReactions.pdf", width=6, height=6)
hist(spectoreactratio, ylim=c(0, 150), xlab="Ratio of Species over Reactions", main="Histogram of the Ratio of Species over Reactions\n for Each Biomodel")
dev.off()
## Number of Models and Species against Time Plots

pdf("Graphs/CummulativeModelsPlot.pdf", width=6, height=6)
plot(allyears, cummulativenumberofmodels, type="l", ylim=c(0, 400), xlab="Years", ylab="Number of Models", main="Plot of Cummulative Number of\n Biomodels against Year")
dev.off()

pdf("Graphs/CummulativeSpeciesPlot.pdf", width=6, height=6)
plot(allyears, cummulativenumberofspecies, type="l", ylim=c(0, 5000), xlab="Years", ylab="Number of Species", main="Plot of Cummulative Number of\n Species against Year")
dev.off()