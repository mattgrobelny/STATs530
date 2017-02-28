library("qqman", lib.loc="~/R/x86_64-redhat-linux-gnu-library/3.3")

# Import pc1 gwas data
pc1 <- read.table("pc1.assoc.logistic",header=TRUE)

# select only tests of SNP
pc1 <- pc1[pc1$TEST=="ADD",]

# Plot SNPs P values with suggestive line of signficance = -log10(1e-05)
#png(file="plot.png",width=800,height=600)
manhattan(pc1[,c("SNP","CHR","BP","P")])
dev.off()

# Identify the SNP pass the suggestive line of signficance = -log10(1e-05) 
head(pc1[order(pc1$P),])

# SNP: rs2222162 has a pval of 6.407e-06 