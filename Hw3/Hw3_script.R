library("TeachingDemos")
library("qvalue")
library('fdrtool')
#
# Simulate and plot p-values from a normal or binomial based test under various conditions.
# When all the assumptions are true, the p-values should follow an approximate uniform distribution. 
# These functions show that along with how violating the assumptions changes the distribution of the p-values.

sim_FDR_comparison <- function(sim_num, max_m){

Grt_Pj_star <- 0
Grt_Pj_dagger <- 0

# Set up empty df for parameter storage
Pj_store <- data.frame(total_mins_to_capture =integer(),
                      m =integer(), 
                      r=double(),
                      Pj_star =integer(),
                      Pj_dagger=integer(),
                      Grt_Pj_star_binary= integer(),
                      Grt_Pj_dagger_binary = integer(),
                      percent_of_data_used = double())

colnames(Pj_store) <- c('Pj_star','Pj_dagger')
while (sim_num !=0){
m = sample(501:max_m, 1)
sim_pvals <- runif(m,min=0, max=1 )

total_mins_to_capture = sample(10:500, 1)
sim_pvals <- sort(sim_pvals)
x<- head(sim_pvals,n=total_mins_to_capture)
percent_of_data_used <- total_mins_to_capture/m
r <- tail(x, n=1)

#
# Get FDR cutt offs for 
Pj_star<- fdrtool(sim_pvals,verbose=FALSE,cutoff.method = 'locfdr',statistic = 'pvalue',plot=FALSE)$param[1]

Pj_star<- fdrtool(sim_pvals,verbose=FALSE,statistic = 'pvalue',plot=FALSE)

Pj_dagger<- fdrtool(sim_pvals,statistic = 'pvalue',verbose=FALSE,plot=FALSE, cutoff.method = 'pct0', pct0=percent_of_data_used)$param[1]

# Compare FDR cut offs between Pj_star and Pj_dagger
if (Pj_star >= Pj_dagger){
  Grt_Pj_star <- Grt_Pj_star+ 1
  Grt_Pj_star_binary =1
  Grt_Pj_dagger_binary =0
  df =data.frame(total_mins_to_capture,m,r, Pj_star,Pj_dagger,Grt_Pj_star_binary,Grt_Pj_dagger_binary,percent_of_data_used)
  
}else {
  Grt_Pj_dagger <-Grt_Pj_dagger+1
  Grt_Pj_star_binary =0
  Grt_Pj_dagger_binary =1
  df =data.frame(total_mins_to_capture,m,r, Pj_star,Pj_dagger,Grt_Pj_star_binary,Grt_Pj_dagger_binary,percent_of_data_used)}
print(sim_num)

#Save FDR cutoffs for Pj_star and Pj_dagger
Pj_store <- rbind(Pj_store,df)

# decrease sim num by one
sim_num =sim_num -1
}
list_return <-list("Pj_store" = Pj_store,'Grt_Pj_star'=Grt_Pj_star,'Grt_Pj_dagger'= Grt_Pj_dagger)
return(list_return)
}

FDR_comp_out<- sim_FDR_comparison(10, 10000)
View(FDR_comp_out$Pj_store)
