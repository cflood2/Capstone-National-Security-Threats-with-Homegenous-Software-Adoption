extensions [nw]

turtles-own [
  bad-update-received?  ;; if turtle got the bad update
  already-sent?         ;; if turtle already sent bad update to its neighbors
  update-fixed?         ;; if turtle received the update fix
  ready-to-spread-fix?  ;; helper to control spreading fix after delay
]

globals [
  fix-started?
  original-red-count
]

;;;;;;;;;;;;;;;;;;;;;;;
;;; Setup Procedures ;;;
;;;;;;;;;;;;;;;;;;;;;;;

to setup
  clear-all
  set-default-shape turtles "circle"
  ;; make the initial network of two turtles and an edge
  make-node nobody        ;; first node, unattached
  make-node turtle 0      ;; second node, attached to first node
  reset-ticks
end

;;;;;;;;;;;;;;;;;;;;;;;
;;; Main Procedures ;;;
;;;;;;;;;;;;;;;;;;;;;;;

to go
  ;; new edge is green, old edges are gray
  ask links [ set color gray ]
  make-node find-partner         ;; find partner & use it as attachment
                                 ;; point for new node
  tick
end

;; used for creating a new node

to make-node [old-node]
  create-turtles 1
  [
    if who = 0 [
      set color red  ;; First turtle is red
    ]
    if who != 0 [
      set color blue ;; All other turtles are blue
    ]

    set bad-update-received? false
    set already-sent? false
    set update-fixed? false
    set ready-to-spread-fix? false

    if old-node != nobody
    [
      create-link-with old-node [ set color green ]
      move-to old-node
      fd 8
    ]
  ]
end

;; This code is the heart of the "preferential attachment" mechanism
;; We pick a random link, and then pick one end of that link

to-report find-partner
  report [one-of both-ends] of one-of links
end

;;;;;;;;;;;;;;
;;; Layout ;;;
;;;;;;;;;;;;;;

to layout
  repeat 3 [
    let factor sqrt count turtles
    layout-spring turtles links (1 / factor) (7 / factor) (1 / factor)
    display
  ]

  let x-offset max [xcor] of turtles + min [xcor] of turtles
  let y-offset max [ycor] of turtles + min [ycor] of turtles

  set x-offset limit-magnitude x-offset 0.1
  set y-offset limit-magnitude y-offset 0.1

  ask turtles [ setxy (xcor - x-offset / 2) (ycor - y-offset / 2) ]
end

to-report limit-magnitude [number limit]
  if number > limit [ report limit ]
  if number < (- limit) [ report (- limit) ]
  report number
end

;; resize-nodes to adjust node size based on degree

to resize-nodes
  ifelse all? turtles [size <= 1]
  [
    ask turtles [ set size sqrt count link-neighbors ]
  ]
  [
    ask turtles [ set size 1 ]
  ]
end

;;;;;;;;;;;;;;;;;;;;;;;
;;; Second Model ;;;
;;;;;;;;;;;;;;;;;;;;;;;

to update-push
  ask turtles [
    set bad-update-received? false
    set already-sent? false
    set shape "circle" ;; reset all turtles to circle
  ]

  ;; Reshape the pusher
  ask turtle 0 [
    set shape "triangle"
  ]

  ;; Initial red turtle sends to a subset of neighbors
  ask turtle 0 [
    let my-neighbors link-neighbors
    let infected-neighbors n-of (round (bad-update-percent / 100 * count my-neighbors)) my-neighbors
    ask infected-neighbors [
      set bad-update-received? true
      set color red
    ]
    set already-sent? true
  ]
end

to spread-bad-update
  ask turtles with [bad-update-received? and (not already-sent?)] [
    ask link-neighbors with [not bad-update-received?] [
      set bad-update-received? true
      set color red
    ]
    set already-sent? true
  ]
  tick
end

;;;;;;;;;;;;;;;;;;;;;;;
;;; Third Model ;;;
;;;;;;;;;;;;;;;;;;;;;;;

to update-fix-setup
  set fix-started? false

  ;; Record original number of red turtles at start of fix
  set original-red-count count turtles with [color = red]

  ask turtles [
    set update-fixed? false
    set ready-to-spread-fix? false
  ]

  ;; Start fix from triangle pusher
  ask turtle 0 [
    set update-fixed? true
    set color green
    set ready-to-spread-fix? true
  ]
end


to update-fix-go
  if not fix-started? [
    clear-plot
    reset-ticks
    set fix-started? true
  ]

  if ticks >= update-delay [
    ask turtles with [update-fixed? and ready-to-spread-fix?] [
      let targets link-neighbors with [color = red and not update-fixed?]
      ask targets [
        if random-float 100 < update-fix-chance [
          set update-fixed? true
          set color green
          set ready-to-spread-fix? true
        ]
      ]
      if all? link-neighbors with [color = red] [update-fixed?] [
        set ready-to-spread-fix? false
      ]
    ]
  ]
  tick
end
@#$#@#$#@
GRAPHICS-WINDOW
345
10
808
474
-1
-1
5.0
1
10
1
1
1
0
0
0
1
-45
45
-45
45
1
1
1
ticks
60.0

BUTTON
6
47
72
80
NIL
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

BUTTON
6
87
83
120
NIL
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

MONITOR
153
113
232
158
# of nodes
count turtles
3
1
11

BUTTON
7
124
109
157
redo layout
layout
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
6
162
116
195
resize nodes
resize-nodes
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

SLIDER
4
254
176
287
bad-update-percent
bad-update-percent
0
100
70.0
1
1
NIL
HORIZONTAL

BUTTON
5
294
144
327
Initial Update Push
update-push
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
5
333
178
366
Subsequent Update spread
spread-bad-update
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
99
52
245
85
layout?
layout?
0
1
-1000

TEXTBOX
12
14
220
52
Step 1: Network Construction
15
0.0
1

TEXTBOX
9
211
239
249
Step 2: Bad Update Propagation
15
0.0
1

TEXTBOX
844
34
1112
72
Step 3: Deployment of the Update Fix
15
0.0
1

BUTTON
839
61
956
94
NIL
update-fix-setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
839
201
941
234
NIL
update-fix-go  
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
838
104
1010
137
update-fix-chance
update-fix-chance
0.1
10
1.7
.1
1
NIL
HORIZONTAL

SLIDER
839
154
1011
187
update-delay
update-delay
0
20
4.0
1
1
NIL
HORIZONTAL

PLOT
846
273
1046
423
Node Status Over Time
Ticks
Nodes
0.0
10.0
0.0
100.0
true
false
"" ""
PENS
"Fix" 1.0 0 -10899396 true "" "plot (100 * count turtles with [color = green] / original-red-count)"
"Bad" 1.0 0 -2674135 true "" "plot (100 * count turtles with [color = red] / original-red-count)"

@#$#@#$#@
## WHAT IS IT?


This model simulates a software update vulnerability and recovery cycle across a growing computer network. This model is inspire by a real world event Crowdstrike.  The model shows how faulty updates/vulnerability can affect an entire network, and how a fix can be deployed over time. The network structure is formed using preferential attachment, where new nodes are more likely to connect to highly connected existing nodes.

## HOW IT WORKS

The model is made in 3 steps.

In Step 1 the network begins with two connected nodes.A new node is added and randomly links to one end of an existing node known as preferential attachment. One node (the first created) is designated as the origin of the "bad update" and is marked red.

In Step 2, the red node pushes a bad update to a chosen percentage of the nodes neighbors. Those affected also turn red and can further spread the bad update to their subsequent neighbors.

In Step 3, the fix for the bad update/vulnerabilty becomes available after a delay (to simulate detection and patch creation). The original node begins spreading the fix (green color) to its red neighbors. Each infected node has a probability of accepting the fix, which then allows it to help spread the update further.

## HOW TO USE IT

GO: Grows the network one node at a time using preferential attachment.

LAYOUT: Arranges the network visually for better clarity.

RESIZE-NODES: Increases the node sizes based on how many connections each node has.

UPDATE-PUSH: Starts the bad update from the original node and spreads it to a percentage of neighbors.

SPREAD-BAD-UPDATE: Continues the infection as affected nodes send the bad update to their subsequent neighbors.

UPDATE-FIX-SETUP: Resets the system to begin spreading a fix for the bad update.

UPDATE-FIX-GO: Spreads the fix to neighboring red nodes with a chance determined by the fix probability and a delay.

Sliders such as bad-update-percent, update-fix-chance, and update-delay control the infection percentage, fix effectiveness, and delay before the fix start



## CREDITS AND REFERENCES

This model is based on:
Albert-László Barabási. Linked: The New Science of Networks, Perseus Publishing, Cambridge, Massachusetts, pages 79-92.

For a more technical treatment, see:
Albert-László Barabási & Reka Albert. Emergence of Scaling in Random Networks, Science, Vol 286, Issue 5439, 15 October 1999, pages 509-512.

The layout algorithm is based on the Fruchterman-Reingold layout algorithm.  More information about this algorithm can be obtained at: http://cs.brown.edu/people/rtamassi/gdhandbook/chapters/force-directed.pdf.

For a model similar to the one described in the first suggested extension, please consult:
W. Brian Arthur, "Urban Systems and Historical Path-Dependence", Chapt. 4 in Urban systems and Infrastructure, J. Ausubel and R. Herman (eds.), National Academy of Sciences, Washington, D.C., 1988.

## Cite

* Stonedahl, F. and Wilensky, U. (2008). NetLogo Virus on a Network model. http://ccl.northwestern.edu/netlogo/models/VirusonaNetwork 

* Wilensky, U. (2005).  NetLogo Preferential Attachment model.  http://ccl.northwestern.edu/netlogo/models/PreferentialAttachment.  

NetLogo software:

* Wilensky, U. (1999). NetLogo. http://ccl.northwestern.edu/netlogo/.

## COPYRIGHT AND LICENSE

Copyright 2005 Uri Wilensky.

![CC BY-NC-SA 3.0](http://ccl.northwestern.edu/images/creativecommons/byncsa.png)

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License.  To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

Commercial licenses are also available. To inquire about commercial licenses, please contact Uri Wilensky at uri@northwestern.edu.

<!-- 2005 -->
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
NetLogo 6.4.0
@#$#@#$#@
set layout? false
set plot? false
setup repeat 300 [ go ]
repeat 100 [ layout ]
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
