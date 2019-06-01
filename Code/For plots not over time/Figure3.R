#Gompertzian and Logistic
T=1
x=seq(0.001,T,0.001)
#yG=x^2*(2*log(1/x)+1) #OLD Gompertzian.
#Gompertzian & Logistic:
dLdt=matrix(0,length(x),1)
dGdt=dLdt
dMdt=dGdt
dA1dt=dMdt
dA2dt=dA1dt
yL=as.matrix(x)
yG=yL
yM=yG
yA1=yM*9*2
yA2=yM*10.75*2
for(i in 2:length(x)){
  dGdt[i,1]=14/length(x)*yG[i-1,1]*log(1/yG[i-1,1])
  yG[i,1]=yG[i-1,1]+dGdt[i,1] #Forward euler.
  dLdt[i,1]=14/length(x)*yL[i-1,1]*(1-yL[i-1,1])
  yL[i,1]=yL[i-1,1]+dLdt[i,1] #Forward euler.
  dMdt[i,1]=7/length(x)*(1-yM[i-1,1])/(1.11-yM[i-1,1]) #TAKEN OUT: *yM[i-1,1]
  yM[i,1]=yM[i-1,1]+dMdt[i,1] #Forward euler.
  dA1dt[i,1]=7/length(x)*yA1[i-1,1]*(yA1[i-1,1]/.02-1)*(1-yA1[i-1,1])
  yA1[i,1]=yA1[i-1,1]+dA1dt[i,1] #Forward euler.
  dA2dt[i,1]=7/length(x)*yA2[i-1,1]*(yA2[i-1,1]/.02-1)*(1-yA2[i-1,1])
  yA2[i,1]=yA2[i-1,1]+dA2dt[i,1] #Forward euler.
}
plot(x,yG,xlim=c(0,1),ylim=c(0,1),ylab="x / K",xlab="t / T",#main="Gompertzian (g) & Logistic (r)",
     "l",col="green")
lines(x,yL,col="red")
#plot(x,yM,xlim=c(0,1),ylim=c(0,1),ylab="x / K",xlab="t / T",#main="Gompertzian (g) & Logistic (r)",
#     "l",col="blue")
lines(x,yM,col="blue")
#lines(x,yA1,col="purple")
lines(x,yA2,col="purple")