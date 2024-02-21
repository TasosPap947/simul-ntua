### Exercise 6 - Practice part of analysis of microarray experiment data


### ZITOUMENO 2
 
#getwd()
setwd("C:/Users/anast/Documents/simul/Ex6/") # TODO complete by adding your working directory, with format e.g. C:/Users/.../

# 2-i

x <-read.table(file.path("GSE7117_series_matrix.txt"), skip=68, header=TRUE, sep="\t",row.names=1) # explain in your assignment the arguments used in this function

# TODO 2-v to 2-x



### ZITOUMENO 3

# 3-i 

round(apply(x,2, summary),digits=2)  # explain in your assignment the functionality/arguments in this line of code


# 3-ii 

# Boxplots to check the normalisation of data

# TODO write a function to plot boxplots for every sample of the microarray experiment described in x. Use a different colour for the two experimental conditions. Choose not to plot the outliers. 



### ZITOUMENO 4 

# perform t-test to estimate the statistical significance of genes' differential expression

# 4-i

xsamplelabels<-c() # TODO complete function c() according to the labels of samples (0 for control samples and 1 for diet intervention samples)

# 4-ii

# TODO perform t-test using function t.test() so that the p-value is calculated for every probe, for the two experimental conditions (control/diet intervention)

# 4-iii

# TODO write code to find which probes have p-value less than 0.001
# TODO write code to find the probe with the smallest p-value



