################
# Stats 530
# Hw 3
# Mateusz Grobelny
#
#######

## Part 1

library("TeachingDemos")
library("ggplot2")

######################################################################################################
# Pval simulation function and differnce test 
sim_FDR_comparison <- function(sim_num, total_mins_to_capture, max_m, sim_method){
  sim_keep <- sim_num
  # make empty df
  df_1 <- data.frame(matrix(ncol = sim_num, nrow = total_mins_to_capture))
  for( i in 1:total_mins_to_capture){
    df_1[i,1] = i
  }
  
  # randomize number of tests 
  m <- sample(5000:max_m, 1)
  
  while (sim_num != 0){
    # sim pvalues from 0 to 1 
    if (sim_method ==1){
    sim_pvals <- runif(m,min=0, max=1 )
    }else{sim_pvals<-Pvalue.norm.sim(n = 6000, mu = 0, mu0 = 0.1, sigma = 10, sigma0 = 0.1,
                          test= "t", alternative ="two.sided", alpha = 0.05, B =m)}
    # sort p values
    sim_pvals <- sort(sim_pvals)
    
    # collect min p values 
    x<- head(sim_pvals,n=total_mins_to_capture)
    percent_of_data_used <- total_mins_to_capture/m
    
    #
    # Get FDR adj for Star and dagger
    Pj_star<- p.adjust(sim_pvals, method = 'fdr')
    Pj_dagger<- p.adjust(x, method = 'fdr',n = m )
    
# take difference between each Pj value between the two FDR adjustment schemes 
col_it <-2+sim_keep-sim_num
for (i in 1:total_mins_to_capture){
  df_1[i,col_it ] <- Pj_star[i] - Pj_dagger[i]
  
}


print(sim_num)
sim_num = sim_num -1 

  }
# Output dataframe of delta pvals 
  return(df_1)
  
}

######################################################################################################
# Plotting Function
plot_Delta <- function(sim_num,data){
# Plot the Delta (Pj_star - Pj_dagger) to visulize the relationship between the two FDR adjustment schemes
  
  data_raw <- data[,2:sim_num]
  data_1 = stack(data_raw)
  seq_out = c()
  for (i in 1:(sim_num-1)){
    seq_it <- seq(1,length(data_raw[,1]),1)
    seq_out <- append(seq_out,seq_it)
  }
  data_1<- cbind(data_1,seq_out)
  ggplot(data=data_1, aes(x=data_1[,3],y=data_1[,1], color=data_1[,2])) + geom_line()+
    theme_bw()+
    theme(legend.position="none")+
    xlab("Pj")+
    ylab("Delta (Pj_star - Pj_dagger)")
    
    
    
}

######################################################################################################
####
sim = 20
tests = 100
# Random Sim Pvals (20 sims)
Delta_output<- sim_FDR_comparison(sim,200,tests,1)
plot_Delta(sim,Delta_output)

####
sim = 50
tests = 1000
# Random Sim Pvals (20 sims)
Delta_output<- sim_FDR_comparison(sim,200,tests,1)
plot_Delta(sim,Delta_output)

####
sim = 50
tests = 10000
# Random Sim Pvals (20 sims)
Delta_output<- sim_FDR_comparison(sim,200,tests,1)
plot_Delta(sim,Delta_output)

####
sim = 100
tests = 100000
# Random Sim Pvals (20 sims)
Delta_output<- sim_FDR_comparison(sim,200,tests,1)
plot_Delta(sim,Delta_output)

######################################################################################################

# Since Delta (Pj_star - Pj_dagger) is generally negative,from P_1 to P_200, this means that FDJ adjustment of pvalues using the complete set of pvals is baised twoards a higher FDR threshold then when just using a subset of minimum pvals. 

######################################################################################################

## Part 2

# When calculating the BH FDR, the threshold is identified by multipling t by m and dividing by the number of significant pvals while keeping the FDR below alpha. This means that when data is pooled together, the number of significant pvals will increases resulting in a larger denominator and larger m. However, if the effective size is relativity small between the two groups then the threshold for false positives should be similar which together lowers number of false positives more effectivily which inturn may result in more siginifcant pvals.   

