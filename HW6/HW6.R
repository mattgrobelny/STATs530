library("edgeR")

setwd("~/github/STAT530/HW6")


## set working directory

## read targets file into R
targets <- readTargets(file="targets_HW6.txt", sep=",");

raw_counts <- readDGE(targets$file,comment.char="_",header=F);
names(raw_counts)
head(raw_counts$counts)
dim(raw_counts$counts)

## filter out genes with low expression
keep <- rowSums(cpm(raw_counts)>3)>=6;
counts <- raw_counts[keep,keep.lib.sizes=F];

## Total lib size after filtering 
names(counts);
dim(counts$counts);

## calculate TMM normalization factors
counts <- calcNormFactors(counts);
dim(counts$counts);
## fit a one-way ANOVA
design <- model.matrix(~sex,mating,data=targets);

counts <- estimateGLMCommonDisp(counts,design);
counts <- estimateGLMTrendedDisp(counts,design);
counts <- estimateGLMTagwiseDisp(counts,design);

fit <- glmFit(counts,design,dispersion=counts$tagwise.dispersion);

names(fit);
head(fit$coefficients);

## find genes that are differentially expressed between males and females
de <- glmLRT(fit,coef=2);

## find genes with FDR p < 0.05
topgenes <- decideTestsDGE(de,p.value=0.05);
table(topgenes);
topTags(de,n=10,p.value=0.05);

## make contrast to test \beta_0=\beta_1
contrast <- makeContrasts(X.Intercept.-sexmale,
                          levels=make.names(colnames(design)));

## test contrast
test <- glmLRT(fit,contrast=contrast);
table(decideTestsDGE(test,p.value=0.05));

## **************************************************************
## simulations in R
## **************************************************************
n <- c(10,50,100,500,1000);
sims <- 200;
results <- matrix(NA,nrow=sims,ncol=length(n));
set.seed(1);
for(i in 1:length(n)){
  for(j in 1:sims){
    X <- rnorm(n[i],mean=0,sd=1);
    err <- (mean(X)-0)^2;
    results[j,i] <- err;
  }
}

pdf(file="sim.pdf",width=6,height=6);
plot(n,colMeans(results),type="l");
dev.off();

plot(n,colMeans(results),type="l");
lines(n,1/n,col="red");
