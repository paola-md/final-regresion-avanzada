
datos <- read.csv("C:/Users/anabc/Documents/MCD/Otoño2019/Regresión Avanzada/Rotacion git/final-regresion-avanzada/data/clean_rotacion.csv", header=TRUE, stringsAsFactors = FALSE)

#-Definiendo datos-
n<-dim(datos)[1]
data<-list("n"=n,"y"=datos$rotacion, 
           "num_ventas"=datos$num_ventas-mean(datos$num_ventas), 
           "mes"=datos$mes, "region"=datos$div, 
           "genero"=datos$genero, "J"=2)

#-Definiendo inits- 
inits<-function(){list(beta1=0, beta2=0, beta3=0, yf1=rep(1,n), alpha=matrix(rep(0,2)))}

parameters <- c("alpha", "beta1", "beta2", "beta3", "yf1", "eta")                   

mod1.sim<- bugs(data,inits,parameters,model.file="modelo_jerarquico.txt",
                n.iter=500,n.chains=2,n.burnin=30,n.thin=1, debug=TRUE)


out.sum<-mod1.sim$summary

#Tabla resumen
out.sum.t<-out.sum[grep("beta",rownames(out.sum)),c(1,3,7)] #logistico

