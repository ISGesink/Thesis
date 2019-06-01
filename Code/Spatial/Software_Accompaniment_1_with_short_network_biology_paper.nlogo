;; The Info tab is from the original program. I might write something here or there myself on this program in the future.
;; - Indra Gesink, indragesink@gmail.com

globals [
  ;;PayoffMatrix values:
  P11
  P12
  P21
  P22
  ;;PayoffMatrix B's values, i.e. the non-spatial equivalence:
  P'11
  P'12
  P'21
  P'22
  ;;Interface A and interface B:
  CP11
  CP12
  CP21
  CP22
  CP'11
  CP'12
  CP'21
  CP'22
  ;;The interior NE, which function as basin of attraction, if there is one.
  BoA
  BoA'
  CABoA'
  CBBoA'
  ;;Interaction variables:
  IB11
  IB22
  IB12
  ICA11
  ICA12
  ICA22
  ICB11
  ICB12
  ICB22
  ;;Summary measurements:
  asymmetry
  correlationB
  skewnessB
  correlationCB
  skewnessCB
  clumpy?
  clumpy?C
]

patches-own [
  R?                 ;; 1=yes=R, 0=no=S
  ;; Possible in the future: to change all if requests w.r.t. color to requests on R?
  c                  ;; c=1 in the interface, plays along! c=0; outside of the interface!
  nRNs               ;; number of Resistant Neighbors.
  S-fitness
  R-fitness
  R-weight
]

to payoff  ;; Setting the payoff matrix values. Minimum element set to 1.
  if(Fitness-matrix = "Base2")[set P11 1 set P12 1 set P21 1  set P22 1]
  if(Fitness-matrix = "Divide the Cake (H/D)")[set P11 1 set P12 4 set P21 2 set P22 3]
  if(Fitness-matrix = "Competition-S")[set P11 2 set P12 1 set P21 1  set P22 2]
  if(Fitness-matrix = "Competition-A")[set P11 2 set P12 1 set P21 1  set P22 3]
  if(Fitness-matrix = "Competition-A'")[set P11 1.3 set P12 1.2 set P21 1  set P22 1.1]
  if(Fitness-matrix = "Predator-Prey-S")[set P11 2 set P12 3 set P21 1  set P22 2]
  if(Fitness-matrix = "Predator-Prey-A")[set P11 2 set P12 3 set P21 2  set P22 2]
  if(Fitness-matrix = "Mutualism-S")[set P11 1 set P12 2 set P21 2  set P22 1]
  if(Fitness-matrix = "Mutualism-A")[set P11 1 set P12 2 set P21 3  set P22 1]
  if(Fitness-matrix = "Manual")[
    set P11 3
    set P12 1
    set P21 1
    set P22 2
  ]
end

to setup
  clear-all
  payoff
  resize-world 0 (World-Size - 1) (World-Size * -1 + 1) 0
  ask patches [ initialize ]
  calculate_InC
  calculate_SMnBnC
  ;;;;
  EGT
  ;ask patches [ EGT ]
  ask patches [ find-lottery-weights ]
  reset-ticks
end

to switchcolor
  ifelse(pcolor = red)[ ;;w/o the else operation 1 was overwritten by operation 2 ! ;)
    set pcolor green
    set R? 0
    ]
  [if(pcolor = green)[
    set pcolor red
    set R? 1
    ]
  ]
end

to initialize  ;; patch procedure
  if (Initial-State = "Random") [
    let ptype random-float 1.0
    let itype random-float 1.0
    ifelse (ptype < number-of-resistant-cells) [
      set R? 1
      set pcolor red
    ] [
      set R? 0
      set pcolor green
    ]
  ]
  if (Initial-State = "Segregated")[ ;; alt-prob 0.50
    ifelse (pxcor < World-Size * number-of-resistant-cells)[
      set R? 1
      set pcolor red
    ] [
      set R? 0
      set pcolor green
    ]
  ]
  if (Initial-State = "Surrounded")[
    ;; TO DO make layers calleable in the monitor (for consistency between surrounded and surrounding)
    let layers 2 * ceiling (( World-Size * number-of-resistant-cells ) / 2) ;; a rough and dirty conversion of alt-prob to #rings*2: the latter part biases downwards, the first upwards.
    ;; use of (2n)^2 for more precision.
    set R? 0
    set pcolor green
    ;;No loop needed!:
    if(((World-Size - layers) / 2) <= pxcor and pxcor < ((World-Size + layers) / 2) and ((World-Size - layers) / -2) >= pycor and pycor > ((World-Size + layers) / -2))[
    set R? 1
    set pcolor red
    ]
  ]
  if (Initial-State = "Surrounding")[
    let selfish-probability (1 - number-of-resistant-cells)
    let layers 2 * ceiling (( World-Size * selfish-probability) / 2) ;; a rough and dirty conversion of alt-prob to #rings*2: the latter part biases downwards, the first upwards.
    ;; use of (2n)^2 for more precision.
    set R? 1
    set pcolor red
    ;;No loop needed!:
    if(((World-Size - layers) / 2) <= pxcor and pxcor < ((World-Size + layers) / 2) and ((World-Size - layers) / -2) >= pycor and pycor > ((World-Size + layers) / -2))[
    set R? 0
    set pcolor green
    ]
  ]
  if (Initial-State = "Dispersed")[ ;; alt-prob 0.25 / 0.75
    ;;works for both sides (versatile) and depends on alt-prob >0.5 or not.
    ifelse(number-of-resistant-cells <= 0.5)[ ;;initalizing with the majority. Then below: switchcolors to create the minority.
      set pcolor green
      set R? 0
    ] [
       set pcolor red
       set R? 1
    ]
    ;; for divisions close to 50/50
    if(abs(number-of-resistant-cells - 0.5) <= 0.25)[ ;; If alt-prob is in the middle half a checkerboard is made on the odd cors.
      if(((pxcor - 1) mod 2 = 0) and ((pycor - 1) mod 2 = 0))
      [ switchcolor ]
    ]
    ;; under any condition on the even cors:
    let amount' (World-Size * World-Size * ((0.5 - abs(number-of-resistant-cells - 0.5)) mod 0.25))
    if(number-of-resistant-cells = 0.5)[set amount' (World-Size * World-Size * ((0.5 - abs(number-of-resistant-cells - 0.5)) / 2))]
    let xmax ((amount' mod (World-Size / 2)) * 2)
    let ymax ((amount' - (xmax / 2)) / (World-Size / 2) * -2)
    if((pxcor mod 2 = 0) and (pycor mod 2 = 0) and (pycor >= ymax))[
      ifelse(pycor = ymax)[
        if(pxcor < xmax)[ switchcolor ]
        ]
      [ switchcolor ]
    ]
  ]
  if (Initial-State = "Checkerboard")[
    ifelse ((pxcor + pycor) mod 2 = 0)[
      set R? 1
      set pcolor red
    ] [
      set R? 0
      set pcolor green
    ]
  ]
   if (Initial-State = "Lines-h")[
    ifelse (pycor mod 2 = 0)[
      set R? 1
      set pcolor red
    ] [
      set R? 0
      set pcolor green
    ]
  ]
  if (Initial-State = "Lines-v")[
    ifelse (pxcor mod 2 = 0)[
      set R? 1
      set pcolor red
    ] [
      set R? 0
      set pcolor green
    ]
  ]
  if (Initial-State = "Fixation")[
    ifelse(number-of-resistant-cells > 0.5)[
      set pcolor red
      set R? 1
    ] [
      set R? 0
      set pcolor green
    ]
  ]
end

to invade
  if(Stochastic-Mutant-Invaders)[
    let one-in-hundred random-float 1.0
    if(one-in-hundred <= prob-one-mutant)[
      ask patch floor(random-float World-Size) floor(random-float World-Size)
      [ switchcolor ]
    ]
  ]
end

to calculate_InC
 ;; Initialize / reset
 set IB11 0
 set IB12 0
 set IB22 0
 ;;counting # neighbours (on either of 4 sides) per type per cell / 2:
 foreach (reverse (n-values (1 + max-pycor - min-pycor) [ min-pycor + ? ])) [
    let y ?
    foreach (n-values (1 + max-pxcor - min-pxcor) [ min-pxcor + ? ]) [
      let x ?
      ask patch x y [
        if(pcolor = green)[
          set IB11 IB11 + sum [(1 - R?)] of neighbors4 ;;#sensitive.
          set IB12 IB12 + sum [R?] of neighbors4 ;;#R.
          ifelse(sum [1 - R?] of neighbors4 = 4)[set c 0][set c 1]
        ]
        if(pcolor = red)[
           set IB22 IB22 + sum [R?] of neighbors4
           ifelse(sum [R?] of neighbors4 = 4)[set c 0][set c 1]
        ]
      ]
    ]
  ]
 set IB11 IB11 / (4 * World-Size * World-Size) ;;4 for number of neighbors!
 set IB22 IB22 / (4 * World-Size * World-Size)
 set IB12 IB12 / (4 * World-Size * World-Size)
 ;;Now IC:
 set ICA11 0
 set ICA12 0
 set ICA22 0
 if(count patches with [c = 1] > 0)[
 set ICA11 (count patches with [pcolor = green and c = 1] / (count patches with [c = 1])) ^ 2
 set ICA12 (count patches with [pcolor = green and c = 1] / count patches with [c = 1]) * (count patches with [pcolor = red and c = 1] / count patches with [c = 1])
 set ICA22 (count patches with [pcolor = red and c = 1] / (count patches with [c = 1])) ^ 2
 ]
 set ICB11 0
 set ICB12 0
 set ICB22 0
 foreach (reverse (n-values (1 + max-pycor - min-pycor) [ min-pycor + ? ])) [
    let y ?
    foreach (n-values (1 + max-pxcor - min-pxcor) [ min-pxcor + ? ]) [
      let x ?
      ask patch x y [
        if(pcolor = green and c = 1)[
          set ICB11 ICB11 + c * (sum [(1 - R?)] of neighbors4) ;;#sensitive.
          set ICB12 ICB12 + c * (sum [R?] of neighbors4) ;;#R.
        ]
        if(pcolor = red and c = 1)[
          set ICB22 ICB22 + c * (sum [R?] of neighbors4)
        ]
      ]
    ]
  ]
 if(count patches with [c = 1] > 0)[
 ;; gaurd against division by zero:
 let temp ((ICB11 + ICB12 + ICB12 + ICB22) / 4)
 set ICB11 ICB11 / (4 * temp)
 set ICB12 ICB12 / (4 * temp)
 set ICB22 ICB22 / (4 * temp)
 ]
end

to calculate_SMnBnC  ;; (For now ignores blue.)
  set asymmetry 0 ; in the design of my program this cannot be different. There is also no practical reason to have it otherwise.
  let fog (count patches with [pcolor = green] / World-Size ^ 2) ;; fraction of..
  let for (count patches with [pcolor = red] / World-Size ^ 2)
  ;;I here fix off-diagonal elements first, as opposed to lowest on-diagonal element!.
  if(fog * for != 0)[
    ifelse((2 * IB12) < (2 * fog * for))[
      set correlationB (1 - (IB12) / (fog * for)) ; +
    ] [
      set correlationB -1 * (1 - (IB11 + IB22) / (fog ^ 2 + for ^ 2)) ; -
    ] ;; so far so simple.
  ]
  ;;; and payofmatrix B (with control to prevent division by zero). If there would be division by zero, the predicted (theoretical) interaction frequencies is zero and then the observed is as well. Both are then thus equal and the factor in between the two 1 with which the conversion is made.
  ;; B = A * IB / IA
 ifelse(fog != 0)[
   set P'11 P11 * IB11 / (fog ^ 2)] [set P'11 P11]
 ifelse(fog != 0 and for != 0)[
    set P'12 P12 * IB12 / (fog * for)] [set P'12 P12]
 ifelse(for != 0 and fog != 0)[
    set P'21 P21 * IB12 / (for * fog)] [set P'21 P21]
 ifelse(for != 0)[
    set P'22 P22 * IB22 / (for ^ 2)] [set P'22 P22]
    ;;nC: (silly ^^)
      ;; CA = A * ICA / IA !!
 ifelse(fog != 0)[
   set CP11 P11 * ICA11 / (fog ^ 2)] [set CP11 0] ;;?
 ifelse(fog != 0 and for != 0)[
    set CP12 P12 * ICA12 / (fog * for)] [set CP12 0]
 ifelse(for != 0 and fog != 0)[
    set CP21 P21 * ICA12 / (for * fog)] [set CP21 0]
 ifelse(for != 0)[
    set CP22 P22 * ICA22 / (for ^ 2)] [set CP22 0]
      ;; CB = CA * ICB / ICA !!
 ifelse(ICA11 != 0)[
   set CP'11 CP11 * ICB11 / ICA11] [set CP'11 0]
 ifelse(ICA12 != 0)[
    set CP'12 CP12 * ICB12 / ICA12] [set CP'12 0]
 ifelse(ICA12 != 0)[
    set CP'21 CP21 * ICB12 / ICA12] [set CP'21 0]
 ifelse(ICA22 != 0)[
    set CP'22 CP22 * ICB22 / ICA22] [set CP'22 0]
 ;;
 let temppp (count patches with [pcolor = green] / World-Size ^ 2) * (count patches with [pcolor = red] / World-Size ^ 2)
 ifelse(temppp != 0)[
 if(IB22 != 0)[
  ifelse(IB11 / IB22 >= fog ^ 2 / for ^ 2)[ ;+  ;IB's not squared!.
    ifelse(correlationB > 0)[
      let temp for ^ 2 + (fog * for * 2 * correlationB) * for ^ 2 / (fog ^ 2 + for ^ 2)
      set skewnessB 1 - IB22 / temp][
      set skewnessB 1 - IB22 / (for ^ 2 * (1 + correlationB))]][ ;-
   ifelse(correlationB > 0)[
      let temp fog ^ 2 + (for * fog * 2 * correlationB) * fog ^ 2 / (fog ^ 2 + for ^ 2)
      set skewnessB -1 + IB11 / temp][
      set skewnessB -1 + IB11 / (fog ^ 2 * (1 + correlationB))]]
  ]
  ][
    set skewnessB 0
    set correlationB 0
    set skewnessCB 0
    set correlationCB 0
    ] ; In this connected world fog * for = 0 implies one of them equals zero and thus fixation!.

      ; Now how to reverse calculate stuff!?
      ; Or how to write it into simpler form!?

    ifelse((fog - for) * skewnessB < 0)[ ;; favoring the weakest.
    set clumpy? "YES"
  ] [ ifelse((fog - for) * skewnessB > 0) [
    set clumpy? "NO"
  ] [
    set clumpy? "-"
  ]]

  ;;;;set correlationCB 0
  ;;;;set skewnessCB 0
   if(ICA12 != 0)[
    ifelse((2 * ICB12) < (2 * ICA12))[
      set correlationCB 1 - ICB12 / ICA12 ; +
    ] [
      set correlationCB -1 * (1 - (ICB11 + ICB22) / (ICA11 + ICA22)) ; -
    ] ;; so far so simple.
  ]
   if(fog * for != 0)[
 if(ICB22 != 0)[
  ifelse(ICB11 / ICB22 >= ICA11 / ICA22)[ ; +
    ifelse(correlationCB > 0)[
      let temp ICA22 + (ICA12 * 2 * correlationCB) * ICA22 / (ICA11 + ICA22)
      set skewnessCB 1 - ICB22 / temp][
      set skewnessCB 1 - ICB22 / (ICA22 * (1 + correlationCB))]][ ; -
   ifelse(correlationB > 0)[
      let temp ICA11 + (ICA12 * 2 * correlationCB) * ICA11 / (ICA11 + ICA22)
      set skewnessCB -1 + ICB11 / temp][
      set skewnessCB -1 + ICB11 / (ICA11 * (1 + correlationCB))]]
  ]
  ]

  ifelse((count patches with [c = 1]) > 0)[
  ifelse((count patches with [pcolor = green and c = 1] / (count patches with [c = 1]) - count patches with [pcolor = red and c = 1] / (count patches with [c = 1])) * skewnessCB < 0)[
    set clumpy?C "YES"
  ] [ ifelse((count patches with [pcolor = green and c = 1] / (count patches with [c = 1]) - count patches with [pcolor = red and c = 1] / (count patches with [c = 1])) * skewnessCB > 0) [
    set clumpy?C "NO"
  ] [
    set clumpy?C "-"
  ]]
  ][set clumpy?C "-"]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to go
  EGT
  lottery
  invade
  calculate_InC
  calculate_SMnBnC
  ;;Calculation of BoA and BoA'
  if(P12 - P22 + P21 - P11 != 0)[
  set BoA World-Size * World-Size * (P12 - P22) / (P12 - P22 + P21 - P11) ;unefficient ^^. ; case of drift causes an error.
  set BoA max (list 0 BoA)
  set BoA min (list 1600 BoA)
  set BoA' World-Size * World-Size * (P'12 - P'22) / (P'12 - P'22 + P'21 - P'11)
  set BoA' max (list 0 BoA')
  set BoA' min (list 1600 BoA')
  ]
  if(CP12 - CP22 + CP21 - CP11 != 0)[
  set CABoA' World-Size * World-Size * (CP12 - CP22) / (CP12 - CP22 + CP21 - CP11) ;unefficient ^^. ; case of drift causes an error.
  set CABoA' max (list 0 CABoA')
  set CABoA' min (list 1600 CABoA')
  set CBBoA' World-Size * World-Size * (CP'12 - CP'22) / (CP'12 - CP'22 + CP'21 - CP'11)
  set CBBoA' max (list 0 CBBoA')
  set CBBoA' min (list 1600 CBBoA')
  ]
  tick
end

to EGT
  ask patches [
    set nRNs sum [R?] of neighbors4
    if(pcolor = green)[
      set S-fitness P11 * (4 - nRNs)
      set R-fitness P21 * nRNs
      if(Inert-EGT)[
        set S-fitness S-fitness + P11
        ]
    ]
    if(pcolor = red)[
      set R-fitness P22 * nRNs ; it is the neighbor interact with this cell!! (a "reversal of perspective" - breaking with the original program!!)
      set S-fitness P12 * (4 - nRNs)
      if(Inert-EGT)[
        set R-fitness R-fitness + P22
        ]
    ]
  ]
end

to lottery
  ask patches [ find-lottery-weights ]
  ask patches [ next-generation ]
end

to find-lottery-weights ;; patch procedure
  if (R-fitness + S-fitness != 0)[
    set R-weight (R-fitness / (R-fitness + S-fitness)) ;; for this the split was made.
  ]
end

to next-generation ;; patch procedure
  let breed-chance random-float 1.0
  ifelse (breed-chance = R-weight) [][  ;;IMPORTANT LINE!. (else bias towards red was observed in the situation of drift.)
    ifelse (breed-chance < R-weight) [
      set pcolor red
      set R? 1
    ] [
      set pcolor green
      set R? 0
    ]
  ]
end

to clear-patch ;; patch procedure
  set nRNs 0
  set R-fitness 0
  set S-fitness 0
  set R-weight 0
end
; Copyright see info tab.
@#$#@#$#@
GRAPHICS-WINDOW
340
10
709
400
-1
-1
8.98
1
10
1
1
1
0
1
1
1
0
39
-39
0
1
1
1
ticks
30.0

BUTTON
53
15
122
48
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
53
58
273
91
number-of-resistant-cells
number-of-resistant-cells
0.0
1.0
0.84
0.01
1
NIL
HORIZONTAL

BUTTON
130
15
199
48
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

PLOT
5
249
337
399
Trajectories
time
frequency
0.0
50.0
0.0
16.0
true
true
"" ""
PENS
"S" 1.0 0 -10899396 true "" "plot count patches with [pcolor = green]"
"R" 1.0 0 -2674135 true "" "plot count patches with [pcolor = red]"
"BBoA'" 1.0 0 -7500403 true "" "plot BoA'"
"ABoA" 1.0 0 -955883 true "" "plot BoA"
"BBoA'2" 1.0 0 -11053225 true "" "plot World-Size * World-Size - BoA'"
"CABoA'" 1.0 0 -6459832 true "" "plot CABoA'"
"CBBoA'" 1.0 0 -1184463 true "" "plot CBBoA'"

MONITOR
54
407
132
464
# S
count patches with [pcolor = green]
1
1
14

MONITOR
139
407
218
464
# R
count patches with [pcolor = red]
1
1
14

CHOOSER
53
93
160
138
Initial-State
Initial-State
"Random" "Segregated" "Surrounded" "Surrounding" "Dispersed" "Checkerboard" "Lines-h" "Lines-v" "Fixation"
4

SLIDER
162
93
273
126
World-Size
World-Size
4
40
40
2
1
NIL
HORIZONTAL

SWITCH
53
176
259
209
Stochastic-mutant-invaders
Stochastic-mutant-invaders
0
1
-1000

BUTTON
207
15
270
48
step
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
794
44
902
89
layers of R if surr.
;layers\nceiling (( World-Size * number-of-resistant-cells ) / 2)
0
1
11

MONITOR
725
242
782
287
S
count patches with [pcolor = green] / World-Size ^ 2
4
1
11

MONITOR
784
242
841
287
R
count patches with [pcolor = red] / World-Size ^ 2
4
1
11

MONITOR
725
292
782
337
SS
(count patches with [pcolor = green] / World-Size ^ 2) ^ 2
4
1
11

MONITOR
784
339
841
384
RR
(count patches with [pcolor = red] / World-Size ^ 2) ^ 2
4
1
11

MONITOR
784
292
841
337
SR
(count patches with [pcolor = green] / World-Size ^ 2) * (count patches with [pcolor = red] / World-Size ^ 2)
4
1
11

MONITOR
725
339
782
384
RS
(count patches with [pcolor = red] / World-Size ^ 2) * (count patches with [pcolor = green] / World-Size ^ 2)
4
1
11

MONITOR
848
242
905
287
S
count patches with [pcolor = green] / World-Size ^ 2
4
1
11

MONITOR
907
242
964
287
R
count patches with [pcolor = red] / World-Size ^ 2
4
1
11

MONITOR
848
292
905
337
SS
IB11
4
1
11

MONITOR
907
292
964
337
SR
IB12
4
1
11

MONITOR
848
339
905
384
RS
IB12
4
1
11

MONITOR
907
339
964
384
RR
IB22
4
1
11

TEXTBOX
900
217
915
235
IB
14
0.0
1

TEXTBOX
776
217
791
236
IA
14
0.0
1

TEXTBOX
767
167
1055
195
Model's purpose: analysis of interaction structure.
11
0.0
1

MONITOR
794
91
902
136
Division extremity
abs(number-of-resistant-cells - 0.5)
3
1
11

MONITOR
904
44
1009
89
Division extreme?
abs(number-of-resistant-cells - 0.5) >= 0.25
1
1
11

MONITOR
904
91
1009
136
#R if dispersed
World-Size * World-Size * number-of-resistant-cells
1
1
11

MONITOR
978
437
1061
482
Correlation
correlationB
4
1
11

MONITOR
903
437
975
482
Skewness
skewnessB
4
1
11

MONITOR
1064
437
1145
482
(a)Symmetry
asymmetry
2
1
11

TEXTBOX
307
418
322
436
A
14
0.0
1

TEXTBOX
422
419
437
437
B
14
0.0
1

MONITOR
260
450
310
495
P(SS)
P11
2
1
11

MONITOR
374
450
424
495
P(SS)
P'11
2
1
11

TEXTBOX
786
15
1026
33
Some info with some initial states
14
0.0
1

MONITOR
312
450
362
495
P(SR)
P12
2
1
11

MONITOR
260
497
310
542
P(RS)
P21
2
1
11

MONITOR
312
497
362
542
P(RR)
P22
2
1
11

MONITOR
426
450
476
495
P(SR)
P'12
2
1
11

MONITOR
374
497
424
542
P(RS)
P'21
2
1
11

MONITOR
426
497
476
542
P(RR)
P'22
2
1
11

SLIDER
54
211
203
244
prob-one-mutant
prob-one-mutant
0.01
1
0.01
0.01
1
NIL
HORIZONTAL

MONITOR
847
437
900
482
Clumpy
clumpy?
0
1
11

CHOOSER
162
128
273
173
Fitness-matrix
Fitness-matrix
"Manual" "Divide the Cake (H/D)" "Competition-S" "Predator-Prey-S" "Mutualism-S" "Competition-A" "Competition-A'" "Predator-Prey-A" "Mutualism-A" "Base2"
0

SWITCH
53
140
160
173
Inert-EGT
Inert-EGT
0
1
-1000

MONITOR
972
242
1029
287
S
count patches with [pcolor = green and c = 1] / (count patches with [c = 1])
4
1
11

MONITOR
1031
242
1088
287
R
count patches with [pcolor = red and c = 1] / (count patches with [c = 1])
4
1
11

TEXTBOX
1020
218
1047
236
ICA
14
0.0
1

MONITOR
972
292
1029
337
SS
ICA11
4
1
11

MONITOR
972
339
1029
384
RS
ICA12
4
1
11

MONITOR
1031
292
1088
337
SR
ICA12
4
1
11

MONITOR
1031
339
1088
384
RR
ICA22
4
1
11

TEXTBOX
1134
217
1159
235
ICB
14
0.0
1

MONITOR
1096
242
1153
287
S
count patches with [pcolor = green and c = 1] / (count patches with [c = 1])
4
1
11

MONITOR
1156
242
1214
287
R
count patches with [pcolor = red and c = 1] / (count patches with [c = 1])
4
1
11

MONITOR
1096
292
1153
337
SS
ICB11
4
1
11

MONITOR
1156
292
1213
337
SR
ICB12
4
1
11

MONITOR
1096
339
1153
384
RS
ICB12
4
1
11

MONITOR
1156
339
1213
384
RR
ICB22
4
1
11

TEXTBOX
529
420
555
438
CA
14
0.0
1

TEXTBOX
643
419
668
438
CB
14
0.0
1

TEXTBOX
804
495
841
520
CB:
20
0.0
1

MONITOR
847
485
900
530
Clumpy
Clumpy?C
17
1
11

MONITOR
903
485
975
530
Skewness
skewnessCB
4
1
11

MONITOR
978
485
1061
530
Correlation
correlationCB
4
1
11

MONITOR
1064
485
1145
530
(a)Symmetry
asymmetry
2
1
11

MONITOR
488
450
538
495
P(SS)
CP11
2
1
11

MONITOR
540
450
590
495
P(SR)
CP12
2
1
11

MONITOR
488
497
538
542
P(RS)
CP21
2
1
11

MONITOR
540
497
590
542
P(RR)
CP22
2
1
11

MONITOR
602
450
652
495
P(SS)
CP'11
2
1
11

MONITOR
654
450
704
495
P(SR)
CP'12
2
1
11

MONITOR
602
497
652
542
P(RS)
CP'21
2
1
11

MONITOR
654
497
704
542
P(RR)
CP'22
2
1
11

TEXTBOX
846
409
1110
443
Summarizing measurements:
14
0.0
1

MONITOR
1109
36
1176
81
Interface
count patches with [c = 1] / World-Size ^ 2
4
1
11

MONITOR
1083
86
1140
131
# SS
count patches with [pcolor = green and c = 1]
0
1
11

MONITOR
1145
86
1202
131
# SR
count patches with [pcolor = red and c = 1]
0
1
11

MONITOR
1083
136
1140
181
# RS
count patches with [pcolor = green and c = 0]
0
1
11

MONITOR
1145
136
1202
181
# RR
count patches with [pcolor = red and c = 0]
0
1
11

TEXTBOX
813
448
832
473
B:
20
0.0
1

TEXTBOX
218
220
303
241
4 neighbors
14
0.0
1

MONITOR
49
498
106
543
BBoA'
BoA'
1
1
11

MONITOR
110
498
167
543
NIL
CBBoA'
1
1
11

MONITOR
169
498
228
543
NIL
CABoA'
1
1
11

PLOT
-2
547
1221
1119
Trajectories (in a larger plot) and summarizing measurements (*50+900) and counts within the interface scaled for comparison
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"S" 1.0 0 -10899396 true "" "plot count patches with [pcolor = green]"
"R" 1.0 0 -2674135 true "" "plot count patches with [pcolor = red]"
"BBoA" 1.0 0 -7500403 true "" "plot BoA'"
"ABoA" 1.0 0 -955883 true "" "plot BoA"
"BBoA'2" 1.0 0 -12895429 true "" "plot World-Size * World-Size - BoA'"
"CABoA'" 1.0 0 -6459832 true "" "plot CABoA'"
"CBBoA'" 1.0 0 -1184463 true "" "plot CBBoA'"
"corr*50" 1.0 0 -13840069 true "" "plot correlationB * 50 + 900"
"skew*50" 1.0 0 -14835848 true "" "plot skewnessB * 50 + 900"
"corrC*50" 1.0 0 -11221820 true "" "plot correlationCB * 50 + 900"
"skewC*50" 1.0 0 -13791810 true "" "plot skewnessCB * 50 + 900"
"SS" 1.0 0 -5207188 true "" "plot World-Size * World-Size * count patches with [pcolor = green and c = 1] / (0.01 + count patches with [pcolor = green and c = 1] + count patches with [pcolor = red and c = 1])"
"SR" 1.0 0 -723837 true "" "plot World-Size * World-Size * count patches with [pcolor = red and c = 1] / (0.01 + count patches with [pcolor = green and c = 1] + count patches with [pcolor = red and c = 1])"

@#$#@#$#@
## WHAT IS IT?

This model (and Cooperation and Divide the Cake) are part of the EACH unit ("Evolution of Altruistic and Cooperative Habits: Learning About Complexity in Evolution").  See http://ccl.northwestern.edu/rp/each/index.shtml for more information on the EACH unit. The EACH unit is embedded within the BEAGLE (Biological Experiments in Adaptation, Genetics, Learning and Evolution) evolution curriculum. See http://ccl.northwestern.edu/rp/beagle/index.shtml.

This is an evolutionary biology model.  It models population genetics with respect to the fitness of traits that are affected by social and environmental conditions.  The model has two types of patch agents: altruistic agents and selfish agents.

The basic premise of the model is that the selfish agents and the altruistic agents are competing for each spot in the world by entering into a genetic lottery.  You can imagine these agents as plants who "seed" for a spot, and the dominant seed generally wins.  The details of the lottery are explained below in HOW IT WORKS.

Under normal (non-interfering) environmental conditions, the selfish agents win, and the altruistic population is driven to extinction.  However, as outlined in HOW TO USE IT, when the environmental conditions are made more harsh, the altruistic population is able to survive, and even dominate the selfish population.

## HOW IT WORKS

1. Patches live in five-cell, plus-sign-shaped neighborhoods.  Whenever a patch is calculating something about its fitness, it is the center of the neighborhood.  For another patch, when that patch is calculating, it becomes merely one of the neighbors.

2. Each patch is an agent that has a fitness.  Each patch is also the location of a lottery for its space.  The patch and the four surrounding patches put in "seeds" to try to get the patch turned to their type of patch, altruist or selfish. Being successful in the lottery is getting patches to turn to your type.  We're assuming here that the type (altruistic or selfish) is the important genetic trait.

3.  Each patch calculates its own fitness using equation:
if it is A (altruist): 1 - cost + (Number Altruists in Neighborhood / 5 * benefit from Altruists)
if it is S (selfish):  1 + (Number Altruists in Neighborhood / 5 * benefit from Altruists)
Thus, the fitness of the S patch will be higher than the fitness of the A's.  If the cost is 0.2 and benefit is 0.5, for an A surrounded by two S's and two A's, then the fitness of this spot is 1 - 0.2 + (3/5 * 0.5) = 1.1.

4.  After each patch has calculated its fitness, it looks to its four neighbors.  Each of the five patches, including itself, puts a weighted seed into a genetic lottery for this center spot.  So, for example, if the neighborhood is ASASA, each of the three A's register their fitness value, and each of the two S's put in their fitness.  The A's are added, and the S's are added.  Let us assume that the A's add up to 3.2 (this includes the A in the center spot), and the S's add up to 2.6.  These two numbers are the altruist weight and selfish weight respectively, in the lottery for the center spot.  Now, the larger number, whichever it is, is called the Major seed; it is divided by the sum of all the fitnesses.
Thus, 3.2/(3.2 + 2.6) = .552.  This number is the Altruism seed in the lottery.  The minor seed is 2.6/(3.2 + 2.6) = .448. (Notice that the Altruism seed of the parent is 3/5 = .600, while the child's is .552.  Even though altruism is dominating, it is losing ground.)

5.  There are a number of ways of doing the lottery itself.  Currently, we choose a random number between 0 and 1.  Now, if the Number is below the Minor seed, the minor weight gets the spot, and if it is above the major seed, the major seed gets the spot.  So, in the example, if the random number is anywhere from .449 to 1, then the Major seed gets it. If it is between 0 and .448, the minor seed gets it.

## HOW TO USE IT

SETUP button --- sets up the model by creating the agents.

GO button --- runs the model

ALTRUISTIC-PROBABILITY slider --- lets you determine the initial proportion of altruists

SELFISH-PROBABILITY slider --- determines the initial proportion of selfish agents.

ALTRUISM-COST slider --- determines the value of cost in the above fitness equations.

BENEFIT-FROM-ALTRUISM slider --- determines the value of benefit in the above fitness equations.

There are two sliders for controlling environmental variables:

HARSHNESS slider --- sets the value for the resistance of empty patch spots to being populated by agents.  The value for this slider determines a corresponding value in the lottery for each empty (black) spot on the grid; the higher this value, the more difficult it is to populate.

DISEASE slider --- sets the value for the possibility that the agents in occupied spots will die.  The value for this slider is factored into the genetic lottery, and determines the percentage chance that each agent will die out from their spot.

## THINGS TO TRY

1.  At first, run the model with Harshness and Disease both at 0.  Notice that the selfish population quickly dominates the world, driving the altruistic population to extinction.  How do respective population sizes affect the outcome?

2.  Play with the values of cost and benefit.  What are realistic values for actual genetic competition?  How does initial population size effect the significance of these values?

3.  Increase the Harshness and Disease values, independently, and with respect to one another.  What are the effects of the Harshness Model?  of Disease?  How are the values dependent on one another?  At what values does the altruistic population begin to have greater success?

4.  Consider why the introduction of Harshness and Disease conditions affects the success of the altruistic population.  How does each population, run alone, respond to the Harshness and Disease conditions?  If you imagine the black spots as Voids (a third type of competing agent), what is the fitness relationship between Altruists and Voids?  Selfish agents and Voids?

5.  Can you find slider values that maximize the advantage of the altruistic agents?

6.  Try running BehaviorSpace on this model to explore the model's behavior under a range of initial conditions.

## EXTENDING THE MODEL

The model can be extended in a number of interesting directions, including adding new environmental variables, adding different types of agents, and changing the altruistic and selfish weighting under different environmental conditions.

This model does not address the behaviors of individuals, only the relative weights of genetic traits.  A next step in considering the evolution of altruism is to model altruistic behaviors.  (See the related model: Cooperation.)

## NETLOGO FEATURES

This model uses patches as its basic agents. Can you design an "equivalent" model using turtles?  How would the model dynamics be affected?

## RELATED MODELS

Cooperation

## CREDITS AND REFERENCES

This model, the Cooperation model and the Divide the Cake model are part of the curriculum unit "Evolution of Altruistic and Cooperative Habits: Learning About Complexity in Evolution".  See http://ccl.northwestern.edu/rp/each/index.shtml for more information. The EACH unit is embedded within the BEAGLE (Biological Experiments in Adaptation, Genetics, Learning and Evolution) evolution curriculum. See http://ccl.northwestern.edu/rp/beagle/index.shtml.

This model is based on a paper by Mitteldorf and Wilson, 2000, "Population Viscosity and the Evolution of Altruism", Journal of Theoretical Biology, v.204, pp.481-496.

Thanks also to Damon Centola and Scott Styles.

## HOW TO CITE

If you mention this model or the NetLogo software in a publication, we ask that you include the citations below.

For the model itself:

* Wilensky, U. (1998).  NetLogo Altruism model.  http://ccl.northwestern.edu/netlogo/models/Altruism.  Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

Please cite the NetLogo software as:

* Wilensky, U. (1999). NetLogo. http://ccl.northwestern.edu/netlogo/. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

## COPYRIGHT AND LICENSE

Copyright 1998 Uri Wilensky.

![CC BY-NC-SA 3.0](http://ccl.northwestern.edu/images/creativecommons/byncsa.png)

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License.  To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

Commercial licenses are also available. To inquire about commercial licenses, please contact Uri Wilensky at uri@northwestern.edu.

This model was created as part of the project: CONNECTED MATHEMATICS: MAKING SENSE OF COMPLEX PHENOMENA THROUGH BUILDING OBJECT-BASED PARALLEL MODELS (OBPML).  The project gratefully acknowledges the support of the National Science Foundation (Applications of Advanced Technologies Program) -- grant numbers RED #9552950 and REC #9632612.

This model was converted to NetLogo as part of the projects: PARTICIPATORY SIMULATIONS: NETWORK-BASED DESIGN FOR SYSTEMS LEARNING IN CLASSROOMS and/or INTEGRATED SIMULATION AND MODELING ENVIRONMENT. The project gratefully acknowledges the support of the National Science Foundation (REPP & ROLE programs) -- grant numbers REC #9814682 and REC-0126227. Converted from StarLogoT to NetLogo, 2001.

<!-- 1998 2001 -->
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
