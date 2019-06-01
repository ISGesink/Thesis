Blue=c(3,-1)
Brown=c(1,1)
Fitnessthreshold=c(0,0)
y=c(0,1)
plot(Blue,y,"l",ylab="Height",xlab="Fitness",ylim=c(0,1),col="Blue",lwd=2,yaxt='n',main='Barnacles competing at different heights')
axis(side=2, at=c(0,.25,.5,.75,1))
lines(Brown,y,"l",col="Brown4",lwd=2)
lines(Fitnessthreshold,y,"l",lty=3,lwd=2)

#Isoclines:
#Competition one:
Blue=c(2,0)
y1=c(0,1)
Red=c(1,0)
Orange=c(1,0)
y2=c(0,1/2)
plot(Blue,y1,"l",ylab=expression("x"[S]),xlab=expression("x"[R]),ylim=c(0,1),xlim=c(0,2),col="Blue",lwd=2,main='Competition - 1a')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
lines(Orange,y2,"l",col="Red",lwd=2)
legend(x=1.2,y=1,legend=c("Blue = S ","Red = R "))
#red=resistant, blue=sensitive.
#Arrows:
arrows(1.1, .7, 1.1, .65, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(1.1, .7, 1, .7, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.8, .4, .8, .45, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.8, .4, .7, .4, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .2, .25, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .3, .2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))

#Competition two:
Blue=c(1/2,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,1/2)
plot(Blue,y1,"l",ylab=expression("x"[S]),xlab=expression("x"[R]),ylim=c(0,1),xlim=c(0,1),col="Blue",lwd=2,main='Competition - 2')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
Dotted=c(0,1)
y3=c(0,1)
lines(Dotted,y3,"l",lty=3,lwd=2)
legend(x=0.58,y=1,legend=c("Blue = S","Red = R","Dotted","Separatrix"))
#red=resistant, blue=sensitive.
#Arrows:
arrows(.2, .2, .2, .25, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .25, .2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.5, .5, .5, .45, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.5, .5, .45, .5, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.15, .55, .15, .6, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.15, .55, .1, .55, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.6, .1, .65, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.6, .1, .6, .05, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))

#Cooperation:
Blue=c(2,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,2)
plot(Blue,y1,"l",ylab=expression("x"[S]),xlab=expression("x"[R]),ylim=c(0,2),xlim=c(0,2),col="Blue",lwd=2,main='Cooperation')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
legend(x=1.2,y=2,legend=c("Blue = S ","Red = R "))
#red=resistant, blue=sensitive.
#Arrows:
arrows(.3, .3, .4, .3, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.3, .3, .3, .4, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(1.15, 1.2, 1.05, 1.2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(1.15, 1.2, 1.15, 1.1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, 1.2, .3, 1.2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, 1.2, .2, 1.1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(1.3, .1, 1.3, .2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(1.3, .1, 1.2, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))

#Drift:
Blue=c(1,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,1)
plot(Blue,y1,"l",ylab=expression("x"[S]),xlab=expression("x"[R]),ylim=c(0,1),xlim=c(0,1),col="Blue",lwd=2,main='Drift') #Introduce transparancy.
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
legend(x=0.55,y=1,legend=c("Both lines ","overlayed. "))
#red=resistant, blue=sensitive.
#Arrows:
arrows(.25, .25, .25, .3, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.25, .25, .3, .25, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.8, .6, .8, .55, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.8, .6, .75, .6, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))

#Now I have to insert arrow pairs per region and K_s/alpha_xy on the axes!.