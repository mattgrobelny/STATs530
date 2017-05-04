intruderexperiment# Stat530  
# 1.25.17  
GWAS
- DNA, Genes, SNPs...
- MAF = minor allele freq
- Common Variant = MAF 35%

## When reading papers pay attention to:
- Sampling method
- Seq method
- Cells used
- Data structure

## Steps for Processing GWAS Data
1. Preprocessing and QC
Genotype calling - Test Control Data for HWE
Filter Subject ( missingness, admixed) [Delete Row]
Filter SNPs (MAF, genotyping quality) [Delete Column]

2. Imputation
3. Adj for pop substructure and cryptic relatedness
4. Association testing and effect size estimation

## Results
- Sig Snp Ids
- Locations of SNPs
- Stage (Discovery, Rep, Comb)
- EAF
- P val
- CI

## Integrate outside Data
- Encode
- USCB genome browser
___   
# 1.30.17

### HWE and GWAS QC

- SNP and health data/records for case and control patients
- Use high quality data
- HWE expected genotype distribution can only happen with random interbreeding of
a infinite population
- If A = 160 and a= 40 then:
```
p = 0.8  
q = 0.2  
AA = 0.8^2  
Aa = 2 * 0.8 * 0.2  
aa = 0.2^2  
```
- QC for HWE distribution we can only check in the control
 --> deviation from HWE is what we are looking for in the cases

### Biological Question  
Given a SNP we want to test whether it is in HWE in our data.

- Model as cat random var.
- AA Aa aa
- X^2 test

### X^2 and HWE Example:
50 controls  
A = 80
a = 20

p = 0.8  
q = 0.2  
AA = 0.64
Aa = 0.32
aa = 0.04


|| AA    | Aa     |aa     |
| :------------- | :------------- | :------------- |:------------- |
|Expected |     32  | 16       | 2      |
|Observed | 38       | 4       | 8       |

```
X^2 = Summation{ (O-E)^2/ E }  
X^2 = 28.125  
p < 0.005
```
___  
# 2.1.17  
degrees of freedom for X^2 =  (Rows - 1 ) \* (Column - 1)

### Biological Question  
Given a SNP we want to test whether it is in HWE in our data.

- Indep (four ways)
Dominate: DD or Dd vs dd
Recessive: DD vs Dd or dd
Genotypic: DD vs Dd vs dd
Allelic: D vs d

- Dep vars.  
Yi = 1 if case
Yi = 0 if control  

- Null Hypothesis (Also four ways)
Dominate: P(DD or Dd) when Yi = 1 == P(dd) when Yi = 0
Recessive: P(DD) when Yi = 1 vs P(DD) when Yi = 0
Genotypic: DD vs Dd vs dd ( give an genotype same probability to have disease)
Allelic: D vs d
___  
# 2.6.17
- Effect size should be reported in addition to the p - val  
- Even with low p val P(null True) is high...  
- Effect size answers how much different is the difference if p val is low

|| Yi =1     | Yi = 0     | Total|
| :------------- | :------------- | :------------- | :------------- |
|Xi =1 |     A  | B       | A + B|
|Xi = 0  | C       | D       | C + D|
|Total| A + C| C + D| N Popsize|
```
p1 = prob of disease is Xi = 1
= P(yi=1 | xi = 1)
= A/(A+B)

p2 = prob of diease if Xi = 0
= P(Yi = 1 | xi =0)
= C/(C+D)
```

1. *Risk difference:*
Ho P1 = P2   
P1-P2    
Suppose P1 = 0.0026 P2 = 0.0007  
P1- P2 = 0.0019  

2. *Risk Ratio:*
P1/P2   
0.0026/0.0007 = 3.71  

3. *Odds ratio:*    
odds for Xi = 1 --> P1/(1-P1)  
*or*     
odds for Xi = 0 --> P2/(1-P2)  

Estimation of effect size based on exp design
- Prospective
- Cross sectional
- Retrospective
___  
# 2.8.17

Case-control vs Cross sectional  
Population

|| Yi =1     | Yi = 0     | Total|
| :------------- | :------------- | :------------- | :------------- |
|Xi =1 |     A  | B       | A + B|
|Xi = 0  | C       | D       | C + D|
|Total| A + C| C + D| N Popsize|

*In cross sectional sample:*

a = A/N \*n  
b =B/N \*n  
c = C/N \*n  
d = D/N \*n  

*In case control:*

|| Yi =1     | Yi = 0     | Total|
| :------------- | :------------- | :------------- | :------------- |
|Xi =1 |     a  | b       |
|Xi = 0  | c      | d       |
|Total| n1| n0| n Popsize|

a = n1/(A+C) \*A  
b = n0/(B+D) \* B  
c = n1/(A+C) \* C  
d = n0/(B+D) \* D  
___  
# 2.10.17
Multiple testing

Bonferroni adjustment
Conservative adjustment --> false negatives may occur but thats to control for
false postives


Genome wide significance
t = 5*10^-8
___  
# 2.15.17
Population structure
- Population Stratification
- Cryptic relatedness

Three Solutions:
- Genomics control (Solve both)
- PCA adjustment ( solve population Stratification)
- Mixed models (solve Cryptic relatedness)

PCA
- Adds surrogate features to get missing (Popi)

How does PCA work?
- Center and scale genotypes: xi-xBar / (stnd dev)
___   

# 2.24.17
eQTL - Expression quantitate trait locus = genetic locus associated with mRNA lvls

cis - eQTL close to the regulated gene ~1mb  
trans- eQTL far away  

eQTL Paper

### Preprocessing and QC

1. Normalization
2. Expression quantification
3. Batch correction
4. Residual adj for other covariates
5. Filter Genes (annotation, low expression)



GEO - gene expression omibus
___

# 3.1.17
## Association testing

Objects of statistical inference
B1 -
B0 - intercept
B1 -slope
signma sq - Residual variance

Model Development
Gi = B0 + B1Xi + Error

- not reverseable
- can not draw causal relationship

Minimizing the vertical = regression x on y
Minimizing the horizontal = regression y on x
Minimizing the perpendicular = 1st PCA

We can test H0 : B1 = 0 for each SNPs

or

Multiple linear regression
H0: b1 =0, B2 = 0

or
is the relationship inversed?
H0: B1 = -B2

## How to identify true associations after testing?  
Fall Discovery rate (FDR)

Have a p val threshold which minimizes false negative and false positives

FDR : control

E(number of false positives/max{total number of Discoveries, 1}) <= alpha (alpha predetermined)

number of false positives = test relationship is 0 but pj <= t (still significance)

total number = number of test with p <= threshold

minimize false negatives
### Methods for FDR : BH (Benjamini and Hochberg)

# 3.3.17

expected(mt >= count(# p>0.05))/count(# p<0.05) = FDR

FRD ~> mt /(count(p<= 0.05))

BH (Benjamini and Hochberg)

t* = sup [t: mt/count(p<= 0.05) < alpha]

IF increase number of tests, decreases number of Discoveries

# 3.10.17
### Kmeans Clustering - look up objective function for Kmeans
1. Take euclidan distance between two points for each pair in a cluster
2. sum up for each distance
3. Divide the sum by total number of objects in Cluster
4. Add up for all clusters
5. Minimize cluster   


Scree plot - helps determine number of kmeans cluster
y = Error
x = # number of clusters

Look for elbow of the plot.
As K increase error decreases, find where error starts to slow down with increased K

### Functional

Given a gene list of interest and given a list of biological functions.
how can we determine whether the gene set of interest is involved in the biological function?

Find intersection and complement between cluster and biological function.

1. How many genes are catagorized within bio function.
2. How many over lap for a given cluster.
3. Compare actual overlap vs expected overlap.

Data sets for gene pathways
- Kegg
- Biocarta
- MSigDB
- Gene Ontology

### GeO
Three main roots
- Biological Process
- Molecular Function
- Cellular Component

Multiple ways to determine which genes are important.

## 1 Fishers exact test.
You know which genes in your experiment are important

## 2 Kolmogorov-Smirnow test
You only have p-vals for the genes in your experiment

In each case you do a test for independence.

CDF  - test for independence

To estimate :

Sample size for KS test - two mice with 30k genes --> sample size == 30k not 2.

# 3.27.17

## RNAseq

Sexual dimorphism,  certain genes can be highly expressed in one gender vs the other.
- Male-biased vs Female-biased
- Unbiased

Effects of:
- sexual selection
- intraspecies competition

Goals:
Are gene expression patterns DE between mono and poly flies?
- between males and females?

# April 5th

## RNAseq QC

Expression = Total#Reads * (RNA output of gene g in sample i ) / (total RNA output in sample i)  

*Do not know total RNA output in sample i*

Two Paradigm for analysis
1. Annotate - then - identify : pre-specfied exons/genes, then count reads falling into these regions
2. Assemble - then - identify : Assemble reads then count transcripts

Two Normalization Methods
1. Normalize across samples but not across exons/genes
2. Normalize across samples and transcripts

Differential Expression - RNAseq

Count out comes : Cant use linear or Logistic regression

HW5 - Question
Whats the exp for? force result to be positive

Random var beta distributed only takes between value of 0 to 1 .

### Expected val of counts =  (Egi) (lg) / Si * Ni

### (Ygi | Xi) = exp(logNI + BoX +B1Xi) ~~

## (egi) (lg)/Sr

# 4.7.17

RNA - seq Lab

First command run with 1 or 0 mismatch

# 4.10.17

Estimating dispersion

Sample Size problem -
dispersion = variance of a gene expression

Gaussian sequence problem

HW6- Compare 1000 mus

If MLE errors are not ~1 then something wrong with simulation.

EdgeR
Common dispersion : assumes all genes have same dispersion parameter
Trended dispersion: assume that fi_g = f(p^-1 Summation_g(ugi)  
Tag wise dispersion : When variation is gene specific Empirical Bayes estimators
provide an advantageous compromise between the extremes of assuming common dispersion
or separate

# 4.12.17

Estimating dispersion

Neyman - Scott problem

- Estimate sigma^2 without knowing the mus
- Variance = deviation from average

REML - restricted maximum likelihood estimator
Cox-Reid adjusted profile likelihood

## ANOVA

ANOVA - analysis of variance

Experiment with looks at different factors --> ANOVA

ANOVA as a linear model...?
Ygi = expression of gene g in subject i

group  = 0 control , 1 experiment

regions = 0 if amigdala, 1 if hypothalmus

time = 0 if 30min, 1 if 60min

Step 1
Write the question as a linear model.

Q. How is experimental group related to gene expression?

or

Q. What genes are DE?

DE = dependent

independent var = group ( control vs experimental)

express relationship between: group <---> Ygi

model: Ygi ~ Beta_0 + Beta_1*group1

may not be truth... but just chosen to just understand the question

# 4.14.17

### ANOVA

Basic Analysis

1. Biological question
2. independent & dep variables
3. Write down regression
4. identify parameter of interest
5. Formulate H0
6. Hypothesis test
---
### ANOVA Example 1

Q. What genes in mouse are involved in response to conspecific intruder?

Variables: Mouse treated with intruder (1) w/o intruder (0)

Regression Model: negative binomial Regression
  log E(ygi|group_i) = B_g0 + B_g1*group_i --> One way ANOVA -type

Parameters
log E(ygi|group 1) = B_g0 + B_g1

log E(ygi|group 0) = B_g0

### LogFold Change
Bg1 = log((ygi|group 1) /(ygi|group 0)

### Hypothesis

Null: Hoi * Bgi = 0

Reject --> Differential Expressed Genes

---   

### ANOVA Example 2

Q: What genes respond to intruder differently in different brain regions?

Variance:
- Dep: Ygi
- Ind: group{1,0}
        regions {1: amygdla, 0: hypothalmus}

---
#### WRONG MODEL EXAMPLE  
Regression  
logE(Ygi | group_i, region_i) = B_go + B_g1**group_i + B_g2 ** region_i

Parameters

logE(Ygi | group 1, region 1) = B_go + B_g1 + B_g2  
logE(Ygi | group 0, region 1) = B_go+ B_g2  
logE(Ygi | group 1, region 0) = B_go+ B_g1  
logE(Ygi | group 0, region 0) = B_go  
---

#### Correct Model
Regression - Saturate two way ANOVA (group*region <- interaction term)  

logE(Ygi | group_i, region_i) = B_go + B_g1 ** group_i + B_g2 ** region_i + B_g3*group_i*region_i

Parameters

logE(Ygi | group 1, region 1) = B_go + B_g1 + B_g2 + B_g3  
logE(Ygi | group 0, region 1) = B_go+ B_g2  
logE(Ygi | group 1, region 0) = B_go+ B_g1  
logE(Ygi | group 0, region 0) = B_go  

Null: H0:B_g3 = 0
---

Dummy variable coding

---

### ANOVA Example 3
Q: What genes respond to intrusion only in the amygdala


# 4.26.17

Predictions
- Lasso

Random Forest

Cross Validation

# 4.28.17
