#install.packages("rcompanion", dependencies = T)
#install.packages("TH.data")
#install.packages("mvtnorm")
library(mvtnorm)
library(TH.data)
library(rcompanion)

Data <- read.csv2("~path_to/data.csv", header=T)

Matrix_Test <- matrix(0,ncol = 29, nrow = 6)
Matrix_Test <- as.data.frame(Matrix_Test)
Matrix_Test[,1] <- Pairwise_Exact_Test$Comparison
colnames(Matrix_Test) <- colnames(Data)
colnames(Matrix_Test)[1] <- "Comparison"


for (i in 2:29){
  pairwise_table_temp <- table(Data[,i], Data[,1])
  Pairwise_Exact_Test_temp <- pairwiseNominalIndependence(pairwise_table_temp, comare="column", fisher=T, chisq = F, gtest = F, method="bonferroni")
  Matrix_Test[,i] <- Pairwise_Exact_Test_temp$p.adj.Fisher
}
write.csv(Matrix_Test, "~path_to/FinalResult.csv")
