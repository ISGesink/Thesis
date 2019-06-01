Blue=c(3,-1)
Brown=c(1,1)
Fitnessthreshold=c(0,0)
y=c(0,1)
plot(Blue,y,"l",ylab="Height",xlab="Fitness",ylim=c(0,1),col="Blue",lwd=2,yaxt='n',main='Barnacles competing at different heights')
axis(side=2, at=c(0,.25,.5,.75,1))
lines(Brown,y,"l",col="Brown4",lwd=2)
lines(Fitnessthreshold,y,"l",lty=3,lwd=2)

#Isoclines generic:
#

#Isoclines:
#Competition one:
Blue=c(2,0)
y1=c(0,1)
Red=c(1,0)
Orange=Red
y2=c(0,1/2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,1),xlim=c(0,2),col="Blue",lwd=2,main='1. Competition - 1a')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
lines(c(1,0),c(0,1),col="Black",lwd=.5)
lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
lines(c(1.1,0),c(0,.55),"l",col="Orange",lwd=1.2,lty="dashed")
lines(c(1,0),c(0,.5),"l",col="Orange",lwd=1.2,lty="dashed")
lines(c(.9,0),c(0,.45),"l",col="Orange",lwd=1.2,lty="dashed")
lines(c(.8,0),c(0,.4),"l",col="Orange",lwd=1.2,lty="dashed")
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
arrows(.2, .2, .2, .15, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .1, .2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))

#Competition one B:
Red=c(1,0)
y1=c(0,1)
Blue=c(1/2,0)
#Orange=Blue
y2=c(0,2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,2),xlim=c(0,1),col="Blue",lwd=2,main='1. Competition - 1b')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
lines(c(1,0),c(0,1),col="Black",lwd=.5)
lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
#lines(c(1.1,0),c(0,.55),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(1,0),c(0,.5),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(.9,0),c(0,.45),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(.8,0),c(0,.4),"l",col="Orange",lwd=1.2,lty="dashed")
legend(x=1.2,y=1,legend=c("Blue = S ","Red = R "))
#red=resistant, blue=sensitive.
#Arrows:
arrows(.2, .2, .2, .3, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .25, .2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.7, 1.5, .7, 1.4, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.7, 1.5, .65, 1.5, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.45, .8, .45, .7, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.45, .8, .5, .8, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
#arrows(.2, .2, .2, .15, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.2, .2, .1, .2, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))

#Competition one B - Allee:
Red=c(1,0)
y1=c(0,1)
Blue=c(1/2,0)
Orange=Blue
y2=c(0,2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,2),xlim=c(0,1),col="Blue",lwd=2,main='1. Competition - 1b')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
lines(c(1,0),c(0,1),col="Black",lwd=.5)
lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
lines(c(.55,0),c(0,1.1),"l",col="Orange",lwd=1.2,lty="dashed")
lines(c(.5,0),c(0,1),"l",col="Orange",lwd=1.2,lty="dashed")
lines(c(.45,0),c(0,.9),"l",col="Orange",lwd=1.2,lty="dashed")
lines(c(.4,0),c(0,.8),"l",col="Orange",lwd=1.2,lty="dashed")
legend(x=1.2,y=1,legend=c("Blue = S ","Red = R "))
#red=resistant, blue=sensitive.
#Arrows:
#arrows(.2, .2, .2, .3, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.2, .2, .25, .2, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
arrows(.7, 1.5, .7, 1.4, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.7, 1.5, .65, 1.5, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.45, .8, .45, .7, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.45, .8, .5, .8, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .2, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .15, .2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))


#Competition two:
Blue=c(1/2,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,1/2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,1),xlim=c(0,1),col="Blue",lwd=2,main='2. Competition - 2')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
lines(c(1,0),c(0,1),col="Black",lwd=.5)
lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
lines(c(.25,0),c(0,.5),col="Orange",lwd=1.2,lty="dashed")
lines(c(.275,0),c(0,.55),col="Orange",lwd=1.2,lty="dashed")
lines(c(.225,0),c(0,.45),col="Orange",lwd=1.2,lty="dashed")
lines(c(.5,0),c(0,.25),col="Orange",lwd=1.2,lty="dashed")
lines(c(.55,0),c(0,.275),col="Orange",lwd=1.2,lty="dashed")
lines(c(.45,0),c(0,.225),col="Orange",lwd=1.2,lty="dashed")
Dotted=c(0.175,1)
y3=c(0.175,1)
lines(Dotted,y3,"l",lty=3,lwd=2)
Dotted2=c(0,.33)
#y4=c(0.33,0)
#lines(Dotted2,y4,"l",lty=3,lwd=2)
#curve(Dotted2).....
legend(x=0.58,y=1,legend=c("Blue = S","Red = R","Dotted","Separatrix"))
#red=resistant, blue=sensitive.
#Arrows:
arrows(.225, .225, .225, .275, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.225, .225, .275, .225, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.45, .45, .45, .4, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.45, .45, .4, .45, length = 0.05, angle = 30,
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
arrows(.1, .1, .05, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.1, .1, .1, .05, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
#Effect is extra purification!.
arrows(.32, .02, .32, .07, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.32, .02, .27, .02, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.02, .32, .07, .32, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.02, .32, .02, .27, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))


#Cooperation:
Blue=c(2,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,2),xlim=c(0,2),col="Blue",lwd=2,main='3. Cooperation')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
lines(c(1,0),c(0,1),col="Black",lwd=.5)
lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
legend(x=1.2,y=2,legend=c("Blue = S ","Red = R "))
#red=resistant, blue=sensitive.
#Orange dotted:
lines(c(.5,0),c(0,1),col="Orange",lwd=1.2,lty="dashed")
lines(c(.55,0),c(0,1.1),col="Orange",lwd=1.2,lty="dashed")
lines(c(.45,0),c(0,.9),col="Orange",lwd=1.2,lty="dashed")
lines(c(1,0),c(0,.5),col="Orange",lwd=1.2,lty="dashed")
lines(c(1.1,0),c(0,.55),col="Orange",lwd=1.2,lty="dashed")
lines(c(.9,0),c(0,.45),col="Orange",lwd=1.2,lty="dashed")
#Arrows:
arrows(.4, .4, .5, .4, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.4, .4, .4, .5, length = 0.05, angle = 30,
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
##
arrows(.2, .2, .1, .2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .2, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.6, .1, .7, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.6, .1, .6, .0, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.1, .6, .1, .7, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.1, .6, 0, .6, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))

##

#Drift:
Blue=c(1,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,1)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,1),xlim=c(0,1),col="Blue",lwd=2,main='4. Drift') #Introduce transparancy.
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
#lines(c(1,0),c(0,1),col="Black",lwd=.5)
lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
legend(x=0.55,y=1,legend=c("Both lines ","overlayed. "))
#red=resistant, blue=sensitive.
#Arrows:
arrows(.3, .3, .3, .35, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.3, .3, .35, .3, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.8, .6, .8, .55, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.8, .6, .75, .6, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
#
lines(c(.4,0),c(0,.4),col="Orange",lwd=1.2,lty="dashed")
lines(c(.45,0),c(0,.45),col="Orange",lwd=1.2,lty="dashed")
#
arrows(.15, .15, .15, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.15, .15, .1, .15, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))

#Now I have to insert arrow pairs per region and K_s/alpha_xy on the axes!.

##Illustrative examples 1-9
#----#
##IE1:
#Competition one:
Blue=c(2,0)
y1=c(0,1)
Red=c(1,0)
Orange=Red
y2=c(0,1/2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,1),xlim=c(0,2),col="Blue",lwd=2,main='1. Competition - 1a')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
#lines(c(1,0),c(0,1),col="Black",lwd=.5)
#lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
#lines(c(1.1,0),c(0,.55),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(1,0),c(0,.5),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(.9,0),c(0,.45),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(.8,0),c(0,.4),"l",col="Orange",lwd=1.2,lty="dashed")
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
#Insert the dynamics, and lethal parts!

#----#
##IE2:
#Competition two:
Blue=c(.6,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,.4)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,1),xlim=c(0,1),col="Blue",lwd=2,main='2. Competition - 2')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
Dotted=c(0,1)
y3=c(0,.45)
lines(Dotted,y3,"l",lty=3,lwd=2)
legend(x=0.58,y=1,legend=c("Blue = S","Red = R","Dotted","Separatrix"))
#red=resistant, blue=sensitive.
#Arrows:
arrows(.22, .1, .22, .15, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.22, .1, .27, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.92, .42, .92, .37, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.92, .42, .87, .42, length = 0.05, angle = 30,
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
#Insert the dynamics, and lower type R's BoA!

#----#
#IE3:
#Competition one:
Blue=c(2,0)
y1=c(0,1)
Red=c(1,0)
Orange=Red
y2=c(0,1/2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,1),xlim=c(0,2),col="Blue",lwd=2,main='1. Competition - 1a')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
#lines(c(1,0),c(0,1),col="Black",lwd=.5)
#lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
#lines(c(1.1,0),c(0,.55),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(1,0),c(0,.5),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(.9,0),c(0,.45),"l",col="Orange",lwd=1.2,lty="dashed")
lines(c(.8,0),c(0,.4),"l",col="Orange",lwd=1.2,lty="dashed")
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
arrows(.2, .2, .2, .15, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.2, .2, .3, .2, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))

#----#
#IE4:
#Competition two:
Blue=c(.6,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,.4)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,1),xlim=c(0,1),col="Blue",lwd=2,main='2. Competition - 2')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
lines(c(.6,0),c(0,.6),col="Black",lwd=.5)
Dotted=c(0,1)
y3=c(0,.45)
lines(Dotted,y3,"l",lty=3,lwd=2)
legend(x=0.58,y=1,legend=c("Blue = S","Red = R","Dotted","Separatrix"))
#red=resistant, blue=sensitive.
#Arrows:
arrows(.22, .1, .22, .15, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.22, .1, .27, .1, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.92, .42, .92, .37, length = 0.05, angle = 30,
       code = 2, col = par("fg"), lty = par("lty"),
       lwd = par("lwd"))
arrows(.92, .42, .87, .42, length = 0.05, angle = 30,
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
#Insert the dynamics, and lower type R's BoA!

#----#
#IE5:
#Cooperation:
Blue=c(2,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,2),xlim=c(0,2),col="Blue",lwd=2,main='3. Cooperation')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
legend(x=1.2,y=2,legend=c("Blue = S ","Red = R "))
lines(c(1.6,0),c(0,1.6),col="Black",lwd=.5)
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
#Insert the dynamics!

#----#
#IE6:
#Cooperation:
Blue=c(2,0)
y1=c(0,1)
Red=c(1,0)
y2=c(0,2)
plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,2),xlim=c(0,2),col="Blue",lwd=2,main='3. Cooperation')
#axis(side=2, at=c(0,.25,.5,.75,1))
lines(Red,y2,"l",col="Red",lwd=2)
legend(x=1.2,y=2,legend=c("Blue = S ","Red = R "))
lines(c(1.2,0),c(0,1.2),col="Black",lwd=.5)
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
#Insert the dynamics!

##----# ##Not relevant enough !?..
##IE7:
##Drift:
#Blue=c(1,0)
#y1=c(0,1)
#Red=c(1,0)
#y2=c(0,1)
#plot(Blue,y1,"l",ylab=expression("x"[S]),xlab=expression("x"[R]),ylim=c(0,1),xlim=c(0,1),col="Blue",lwd=2,main='Drift') #Introduce transparancy.
##axis(side=2, at=c(0,.25,.5,.75,1))
#lines(Red,y2,"l",col="Red",lwd=2)
#lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
#legend(x=0.55,y=1,legend=c("Both lines ","overlayed. "))
##red=resistant, blue=sensitive.
##Arrows:
#arrows(.25, .25, .25, .3, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.25, .25, .3, .25, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.8, .6, .8, .55, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.8, .6, .75, .6, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))

##----#
##IE8: ### NOT REALISTIC AND THUS NOT RELEVANT - THE ALEE IS WITH THE WRONG TYPE.
##Competition 1B + 1 Allee:
#Red=c(1,0)
#y1=c(0,1)
#Blue=c(1/2,0)
#Orange=Blue
#y2=c(0,2)
#plot(Blue,y1,"l",ylab=expression(paste("x" ["S"], " / K" ["S"])),xlab=expression(paste("x" ["R"], " / K" ["R"])),ylim=c(0,2),xlim=c(0,1),col="Blue",lwd=2,main='1. Competition - 1b')
##axis(side=2, at=c(0,.25,.5,.75,1))
#lines(Red,y2,"l",col="Red",lwd=2)
#lines(c(1,0),c(0,1),col="Black",lwd=.5)
##lines(c(1.05,0),c(0,1.05),col="Black",lwd=.5)
##lines(c(.95,0),c(0,.95),col="Black",lwd=.5)
##lines(c(.55,0),c(0,1.1),"l",col="Orange",lwd=1.2,lty="dashed")
##lines(c(.5,0),c(0,1),"l",col="Orange",lwd=1.2,lty="dashed")
##lines(c(.45,0),c(0,.9),"l",col="Orange",lwd=1.2,lty="dashed")
#lines(c(.49,0),c(0,.98),"l",col="Orange",lwd=1.2,lty="dashed")
#legend(x=1.2,y=1,legend=c("Blue = S ","Red = R "))
##red=resistant, blue=sensitive.
##Arrows:
##arrows(.2, .2, .2, .3, length = 0.05, angle = 30,
##       code = 2, col = par("fg"), lty = par("lty"),
##       lwd = par("lwd"))
##arrows(.2, .2, .25, .2, length = 0.05, angle = 30,
##       code = 2, col = par("fg"), lty = par("lty"),
##       lwd = par("lwd"))
#arrows(.7, 1.5, .7, 1.4, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.7, 1.5, .65, 1.5, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.45, .8, .45, .7, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.45, .8, .5, .8, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.2, .2, .2, .3, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.2, .2, .15, .2, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
##Insert the dynamics, and lethal parts!

##----#
##IE9: ### MISTAKEN THERE IS NOT SPIRALLING!!!.
##Cooperation + 1 Allee:
##Three phased cure
#Blue=c(2,0)
#y1=c(0,1)
#Red=c(1,0)
#y2=c(0,2)
#plot(Blue,y1,"l",ylab=expression("x"[S]),xlab=expression("x"[R]),ylim=c(0,2),xlim=c(0,2),col="Blue",lwd=2,main='3. Cooperation')
##axis(side=2, at=c(0,.25,.5,.75,1))
#lines(Red,y2,"l",col="Red",lwd=2)
#legend(x=1.2,y=2,legend=c("Blue = S ","Red = R "))
#lines(c(2,0),c(0,2),col="Black",lwd=.5)
##red=resistant, blue=sensitive.
##Orange dotted:
#lines(c(.6,0),c(0,1.2),col="Orange",lwd=1.2,lty="dashed")
##Arrows:
#arrows(.4, .4, .5, .4, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.4, .4, .4, .5, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(1.15, 1.2, 1.05, 1.2, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(1.15, 1.2, 1.15, 1.1, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.2, 1.2, .3, 1.2, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.2, 1.2, .2, 1.1, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(1.3, .1, 1.3, .2, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(1.3, .1, 1.2, .1, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
###
##arrows(.2, .2, .1, .2, length = 0.05, angle = 30,
##       code = 2, col = par("fg"), lty = par("lty"),
##       lwd = par("lwd"))
##arrows(.2, .2, .2, .1, length = 0.05, angle = 30,
##       code = 2, col = par("fg"), lty = par("lty"),
##       lwd = par("lwd"))
##arrows(.6, .1, .7, .1, length = 0.05, angle = 30,
##       code = 2, col = par("fg"), lty = par("lty"),
##       lwd = par("lwd"))
##arrows(.6, .1, .6, .0, length = 0.05, angle = 30,
##       code = 2, col = par("fg"), lty = par("lty"),
##       lwd = par("lwd"))
#arrows(.2, .3, .2, .4, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.2, .3, .1, .3, length = 0.05, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.05, 1.09, .05, 1.05, length = 0.025, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
#arrows(.05, 1.1, .0045, 1.1, length = 0.025, angle = 30,
#       code = 2, col = par("fg"), lty = par("lty"),
#       lwd = par("lwd"))
##Insert the dynamics!