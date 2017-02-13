# Start importing allele data
AA = 10
Aa = 25
aa = 81
Total_ind = sum(AA,Aa,aa)

# Find total allels 
total_A = AA*2 + Aa
total_a = aa*2 + Aa
total_allels = total_a +total_A

# Find p and q 
p = total_A/total_allels
q = 1-p

print(p)
print(q)

# Find expected frequencies 
expected_AA = p**2*Total_ind
expected_Aa = 2*p*q*Total_ind
expected_aa = q**2*Total_ind

expected_aa
expected_Aa
expected_AA

# Make a table of observed vs expected 
observed = c(AA,Aa,aa)
expected = c(expected_AA,expected_Aa,expected_aa)
ob_ex_table = cbind(observed,expected)
ob_ex_table

##
# Where r is the number of populations, and c is the number of levels for the categorical variable.
# DF = (r - 1) * (c - 1)
DF = (2 - 1) * (2 - 1)

# perform test 
test_stat = 0
for (i in 1:3){
  test_val = (ob_ex_table[i,1] - ob_ex_table[i,2])**2 /(ob_ex_table[i,2]) 
  test_stat = test_stat + as.numeric(test_val)
}
test_stat

# Get p value
pchisq(test_stat,df=DF,lower.tail = FALSE)
