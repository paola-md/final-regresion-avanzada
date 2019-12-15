
#--- Funciones utiles ---
prob<-function(x){
  out<-min(length(x[x>0])/length(x),length(x[x<0])/length(x))
  out
}
library(R2OpenBUGS)
library(R2jags)

radon<-read.csv("radon.csv",header=TRUE)
radon$county <- as.numeric(factor(radon$cntyfips))
y <- log(ifelse (radon$activity == 0, 0.1, radon$activity))
n <- nrow(radon)
x <- radon$floor
J <- length(unique(radon$county))
county <- radon$county


#-Defining data-
radon_2_data <- list(n = n, J = J, y = y, county = county)

#-Defining inits-
radon_2_inits <- function(){
  list(a = rnorm(J), b = rnorm(1), sigma.y = runif(1))}

#-Selecting parameters to monitor-
radon_2_parameters <- c("a", "b", "sigma.y")

#Modelo
radon_2_bugs <- bugs(data = radon_2_data, inits= radon_2_inits, 
                     parameters.to.save = radon_2_parameters, model.file = "modelo_radon.txt", 
                     n.iter = 1000, debug=TRUE)

radon_2_jags <- jags(data = radon_2_data, inits= radon_2_inits, 
                     parameters.to.save = radon_2_parameters, model.file = "modelo_radon.txt", 
                     n.iter = 1000)


#-Monitoring chain-
ej.sim<-radon_2_jags

#JAGS
out<-ej.sim$BUGSoutput$sims.list

#JAGS
out.sum<-ej.sim$BUGSoutput$summary

#Tabla resumen
out.sum.t<-out.sum[grep("beta",rownames(out.sum)),c(1,3,7)]
out.sum.t<-cbind(out.sum.t,apply(out$beta,2,prob))
dimnames(out.sum.t)[[2]][4]<-"prob"
print(out.sum.t)
