# Stat530  
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

# 2.10.17
Multiple testing

Bonferroni adjustment
Conservative adjustment --> false negatives may occur but thats to control for
false postives


Genome wide significance
t = 5*10^-8
