;; Meatpacking Industry Concentration Model
;; This model simulates the U.S. meatpacking industry with its high concentration
;; and demonstrates vulnerability to production shocks when major producers reduce output
;; includes food security metrics and national security implications

globals [
  total-production       ;; Total meat production across all processors
  pre-shock-production   ;; Production level before shock for comparison
  price                  ;; Current market price
  baseline-price         ;; Price before any shock
  shock-occurred?        ;; Boolean to track if a shock has occurred
  shock-timer            ;; Countdown for shock duration
  shock-magnitude        ;; Percentage reduction in production for affected firm
  affected-firm          ;; Which firm is affected by the shock

  ;; Metrics for food security
  days-of-supply                 ;; estimated days of meat supply in the system
  food-security-index            ;; Index from 0-100 indicating food security level
  consumer-panic-level           ;; level of consumer panic/hoarding (0-5)
  supply-chain-disruption        ;; level of disruption in the broader supply chain
  regional-impact                ;; regional distribution of impact (list for regions)

  ;; Supply Chain Metrics
  retail-inventory               ;; Current retail inventory levels
  baseline-inventory            ;; Normal retail inventory levels
  farmer-impact                  ;; Impact on upstream farmers/ranchers

]

breed [firms firm]       ;; Meatpacking companies
breed [regions region]   ;; Geographic regions

firms-own [
  market-share           ;; Percentage of total market held by this firm
  production-capacity    ;; Maximum production capacity
  current-production     ;; Current production level
  efficiency             ;; Production efficiency (cost per unit)
  is-major?              ;; Whether this is one of the "Big 4" firms
  affected-by-shock?     ;; Whether this firm is currently affected by a shock
  recovery-progress      ;; progress toward full recovery (0-5)
  region-id              ;; Which geogrpahic region this firm operates in
]

regions-own [
  region-name            ;; Name of the region
  regional-production    ;; total production in this region
  regional-impact-level  ;; how severely this region is impacted
  transport-links        ;; Number of transport links to other regions
]


to setup
  clear-all

  ;; Set default values based on chosen scenario
  if shock-scenario = "Mild Disruption" [
    set shock-percentage 10
    set shock-duration 5
    set price-elasticity 1.2
    set recovery-rate 0.2
    set cascading-effects 0.1
    set national-security-threshold 30
  ]

  if shock-scenario = "Severe Crisis" [
    set shock-percentage 50
    set shock-duration 30
    set price-elasticity 2.0
    set recovery-rate 0.05
    set cascading-effects 0.4
    set national-security-threshold 20
  ]

  if shock-scenario = "Recovery Boost" [
    set shock-percentage 30
    set shock-duration 20
    set price-elasticity 1.5
    set recovery-rate 0.1
    set cascading-effects 0.2
    set national-security-threshold 25
  ]
  ;; Initialize global variables
  set total-production 0
  set shock-occurred? false
  set shock-duration 20
  set shock-timer 0
  set shock-magnitude 0
  set consumer-panic-level 0
  set days-of-supply 14    ;; start with 14 days of supply
  set food-security-index 100      ;; start at full food security



  ;; Initialize regional impact tracking
  set regional-impact [0 0 0 0]  ;; Midwest, South, West, Northeast

  ;; Set up retail inventory
  set baseline-inventory 10  ;; 10 days of normal inventory
  set retail-inventory baseline-inventory
  set farmer-impact 0

  ;; Create geographic regions
  create-regions 4 [
    set shape "square"
    set size 3
    set color white
    set transport-links 3
  ]

  ask region 0 [
    set region-name "Midwest"
    setxy -15 10
    set regional-production 0
    set regional-impact-level 0
  ]

  ask region 1 [
    set region-name "South"
    setxy -15 -10
    set regional-production 0
    set regional-impact-level 0
  ]

  ask region 2 [
    set region-name "West"
    setxy 15 10
    set regional-production 0
    set regional-impact-level 0
  ]

  ask region 3 [
    set region-name "Northeast"
    setxy 15 -10
    set regional-production 0
    set regional-impact-level 0
  ]


  ;; Create the "Big 4" meat processing firms
  create-firms 1 [
    set market-share 0.24  ;; JBS
    set is-major? true
    set color red
    set shape "truck"
    set size 3 + market-share * 10
    setxy -10 10
    set region-id 0  ;; Midwest
    set recovery-progress 1
  ]

  create-firms 1 [
    set market-share 0.22  ;; Tyson Foods
    set is-major? true
    set color blue
    set shape "truck"
    set size 3 + market-share * 10
    setxy 10 10
    set region-id 2 ;; West
    set recovery-progress 1
  ]

  create-firms 1 [
    set market-share 0.19  ;; Cargill
    set is-major? true
    set color green
    set shape "truck"
    set size 3 + market-share * 10
    setxy -10 -10
    set region-id 1 ;;; South
    set recovery-progress 1
  ]

  create-firms 1 [
    set market-share 0.12  ;; National Beef
    set is-major? true
    set color yellow
    set shape "truck"
    set size 3 + market-share * 10
    setxy 10 -10
    set region-id 3  ;; Northeast
    set recovery-progress 1
  ]

  ;; Create smaller firms to represent the rest of the market
  let remaining-share 1 - (0.24 + 0.22 + 0.19 + 0.12)
  let num-small-firms 20
  let small-firm-share remaining-share / num-small-firms

  create-firms num-small-firms [
    set market-share small-firm-share
    set is-major? false
    set color gray
    set shape "house"
    set size 1 + market-share * 10
    set region-id random 4 ;; Randomly assign to regions
    setxy random-xcor random-ycor
    set recovery-progress 1
  ]

  ;; Initialize firm properties
  ask firms [
    set production-capacity market-share * 100
    set current-production production-capacity
    set efficiency 0.7 + random-float 0.3
    set affected-by-shock? false
  ]

  calculate-total-production
  set pre-shock-production total-production

  ;; Initialize price based on supply-demand balance
  set price 100
  set baseline-price price

  ;; Calculate intial regional production
  update-regional-production

  ;; Update the display
  update-display
  reset-ticks
end

to go
  if is-number? shock-occurred? [ set shock-occurred? false ]

  if not shock-occurred? and ticks >= shock-start-time and apply-shock? [
    trigger-shock
  ]

  ;; If shock is active, count down
  if shock-occurred? [
    if shock-timer = 5 [output-print "Shock Ending in 5 Ticks!" ]
    if shock-timer = 1 [output-print "Shock has ended. Market stabilizing..." ]
    set shock-timer shock-timer - 1

;; Handle gradual recovery for affected firms
ask firms with [affected-by-shock?] [
  ;; Gradual recovery based on recovery rate
  set recovery-progress recovery-progress + recovery-rate

  ;; Explicitly update production based on recovery progress
  set current-production production-capacity * recovery-progress

  if recovery-progress >= 1 [
    set recovery-progress 1
    set affected-by-shock? false

    ;; Explicitly set production back to full capacity
    set current-production production-capacity

    ;; Restore visual appearance
    ifelse is-major? [
      if market-share = 0.24 [set color red]
      if market-share = 0.22 [set color blue]
      if market-share = 0.19 [set color green]
      if market-share = 0.12 [set color yellow]
    ] [
      set color gray
    ]
  ]
]

    ;; End the shock when timer expires, but recovery may still be in progress
    if shock-timer <= 0 [
      set shock-occurred? false
      if count firms with [affected-by-shock?] > 0 [
        output-print "Shock has ended but firms still recovering"
      ]
    ]

    ;; Update supply chain effects
    update-supply-chain-effects
  ]

  ;; Firms adjust production based on market conditions and recovery status
  ask firms [
    ifelse affected-by-shock? [
    ; Make affected firms lose more production
    set current-production production-capacity * (recovery-progress * 0.5)  ; More severe impact
  ] [
    ; Other firms might gain some production during shock
    ifelse shock-occurred? [
      ; Mild boost for unaffected firms as they try to fill the gap
      let boost 1 + (shock-magnitude * 0.5)  ; Can increase production by up to 50% of shock magnitude
      set current-production min list (production-capacity * boost) (production-capacity * 1.3)
    ] [
      ; Normal production when no shock
      set current-production production-capacity
    ]
  ]
]

  calculate-total-production
  update-market-shares
  update-regional-production

  ;; Update price based on supply-demand dynamics with panic buying effect
  let effective-demand 1 + consumer-panic-level
  ifelse total-production > 0 [
  set price baseline-price * (pre-shock-production / total-production * effective-demand) ^ price-elasticity
] [
  set price baseline-price * 10  ;; If production drops to zero, price spikes dramatically
]
  ;; Update food security metrics
  update-food-security-metrics

  ;; Update consumer panic level based on price increases and supply shortages
  update-consumer-behavior

  update-display
  do-plots ;
  tick
end

to update-regional-production
  ;; Calculate production by region
  ask regions [
    set regional-production sum [current-production] of firms with [region-id = [who] of myself]
  ]

  ;; Calculate impact by region (percentage reduction from normal)
  let region-indices (list 0 1 2 3)
  set regional-impact []

  foreach region-indices [region-idx ->
    let normal-production sum [production-capacity] of firms with [region-id = region-idx]
    let current-regional-production sum [current-production] of firms with [region-id = region-idx]

    let impact-percentage 0
    ;; Prevent division by zero
    ifelse normal-production > 0 [
      set impact-percentage (normal-production - current-regional-production) / normal-production * 100
    ] [
      set impact-percentage 0
    ]

    set regional-impact lput impact-percentage regional-impact

    ;; Only ask the region if it exists
    if any? regions with [who = region-idx] [
      ask regions with [who = region-idx] [
        set regional-impact-level impact-percentage / 100
        set color scale-color red regional-impact-level 0 1
      ]
    ]
  ]
end

to update-market-shares
  ; Calculate the total current production across all firms
  let total-current-production sum [current-production] of firms

  ; Only update if total production is positive to avoid division by zero
  if total-current-production > 0 [
    ask firms [
      ; Directly update market share based on current production
      set market-share current-production / total-current-production

      ; Update size to visually reflect market share changes
      set size 1 + market-share * 15
    ]
  ]


end

to update-supply-chain-effects
  ;; Retail inventory decreases more rapidly during shock due to:
  ;; 1. Reduced supply from processors
  ;; 2. Increased consumer buying/hoarding
  let inventory-reduction-rate 1 + consumer-panic-level
  set retail-inventory max list 0 (retail-inventory - (inventory-reduction-rate / 10))

  ;; Upstream farmer impact increases with duration of shock
  ;; Farmers can't sell livestock when processors aren't operating
  ifelse shock-occurred? [
    set farmer-impact min list 1 (farmer-impact + 0.05)
  ] [
    set farmer-impact max list 0 (farmer-impact - 0.02)
  ]

  ;; Supply chain disruption level based on multiple factors
  set supply-chain-disruption (
    (ifelse-value (pre-shock-production > 0) [production-loss-percentage / 100] [0]) * 0.6 +
    (ifelse-value (baseline-inventory > 0) [1 - (retail-inventory / baseline-inventory)] [0]) * 0.2 +
    farmer-impact * 0.2
)

end

to update-food-security-metrics
  ;; Days of supply calculation based on inventory and current production
  ifelse pre-shock-production > 0 [
    set days-of-supply retail-inventory * (total-production / pre-shock-production)
  ] [
    set days-of-supply retail-inventory
  ]
;; Debug prints - add these lines
  if ticks mod 5 = 0 [  ;; Print every 5 ticks
    print (word "DEBUGGING Food Security Metrics at tick " ticks)
    print (word "  total-production: " total-production)
    print (word "  pre-shock-production: " pre-shock-production)
    print (word "  production ratio: " ifelse-value (pre-shock-production > 0) [total-production / pre-shock-production] [1])
    print (word "  price: " price)
    print (word "  baseline-price: " baseline-price)
    print (word "  price ratio: " ifelse-value (price > 0) [baseline-price / price] [1])
    print (word "  retail-inventory: " retail-inventory)
    print (word "  baseline-inventory: " baseline-inventory)
    print (word "  affected major firms: " count firms with [is-major? and affected-by-shock?])
  ]
  ;; Food security index calculation (0-100 scale)
  ;; Based on multiple factors: production, price, inventory, regional disruption
  let production-factor ifelse-value (pre-shock-production > 0)
                      [total-production / pre-shock-production] [1]
  let price-factor ifelse-value (price > 0)
                 [baseline-price / price] [1]
  let inventory-factor ifelse-value (baseline-inventory > 0)
                    [retail-inventory / baseline-inventory] [1]
  let regional-factor 1 - (ifelse-value (length regional-impact > 0)
                        [max regional-impact / 100] [0])

  ;; Make factors more sensitive to changes
  set production-factor production-factor ^ 3  ;; Square production factor to amplify changes
  set price-factor price-factor ^ 3           ;; Square price factor to amplify changes

  ;; Add direct impact from affected major firms
  let major-firm-impact 0
  if any? firms with [is-major? and affected-by-shock?] [
    let affected-share sum [market-share] of firms with [is-major? and affected-by-shock?]
    set major-firm-impact affected-share * 50  ;; Scale impact by market share of affected firms
  ]

  set food-security-index min list 100 (max list 0 ((
    production-factor * 30 +  ;; 30% weight on production
    price-factor * 20 +       ;; 20% weight on price
    inventory-factor * 30 +   ;; 30% weight on inventory
    regional-factor * 20 -    ;; 20% weight on regional disruption
    major-firm-impact         ;; Direct impact from affected major firms
  )))

end

to update-consumer-behavior
  ;; Consumer panic level increases with:
  ;; 1. Price increases beyond thresholds
  ;; 2. Visible supply shortages
  ;; 3. Duration of the disruption

  let price-panic 0
  if price > baseline-price * 1.2 [
    ;; Panic increases with price, starting at 20% increase
    set price-panic (price - baseline-price * 1.2) / baseline-price
  ]

  let inventory-panic 0
  if retail-inventory < baseline-inventory * 0.7 [
    ;; Panic increases as inventory drops below 70% of normal
    set inventory-panic (1 - (retail-inventory / (baseline-inventory * 0.7)))
  ]

  ;; Combined panic level with some persistence (panic doesn't immediately disappear)
  set consumer-panic-level min list 1 (max list 0 (
    consumer-panic-level * 0.8 +  ;; 80% of previous panic persists
    price-panic * 0.1 +           ;; 10% influence from price
    inventory-panic * 0.1         ;; 10% influence from inventory
  ))
end

to calculate-total-production
  set total-production sum [current-production] of firms
end

to-report distance-to-affected-firms
  ;; Calculate the minimum network distance to any affected firm
  ;; Uses region connections as a proxy for supply chain connections
  let my-region region-id
  let affected-regions [region-id] of firms with [affected-by-shock?]

  ifelse member? my-region affected-regions [
    report 0  ;; In the same region as an affected firm
  ] [
    report 1  ;; Simplified: assuming 1-hop distance if in different region
  ]
end

to trigger-shock
  set shock-occurred? true
  set shock-timer shock-duration
  set shock-magnitude shock-percentage / 100

  ;; Display an alert when the shock starts
  output-print (word "ALERT: Cyberattack detected at tick " ticks "!")
  output-print "Critical Infrastructure affected - monitoring impacts..."
  output-print (word "Current shock-firm setting: " shock-firm)

  ;; Determine which firm to affect based on selection
  ifelse shock-firm = "Random" [
    set affected-firm one-of firms with [is-major?]
    output-print "Random major firm selected"
  ] [
    ;; Find the firm with the specified market share
    let target-share 0
    if shock-firm = "JBS (24%)" [ set target-share 0.24 ]
    if shock-firm = "Tyson Foods (22%)" [ set target-share 0.22 ]
    if shock-firm = "Cargill (19%)" [ set target-share 0.19 ]
    if shock-firm = "National Beef (12%)" [ set target-share 0.12 ]

    output-print (word "Looking for firm with market share: " target-share)
    output-print (word "Available market shares: " [market-share] of firms)

    set affected-firm one-of firms with [market-share = target-share]
  ]

  output-print (word "affected-firm: " affected-firm)

  if affected-firm = nobody [
    output-print "No matching firm found, selecting random major firm"
    set affected-firm one-of firms with [is-major?]
    if affected-firm = nobody [
      output-print "CRITICAL ERROR: No major firms found!"
      stop  ;; Stop the procedure to prevent further errors
    ]
  ]

  ;; Apply shock to the selected firm
  ask affected-firm [
    set affected-by-shock? true
    set recovery-progress 0  ;; start at zero recovery
    output-print (word "Firm " who " operations paralyzed by cyberattack!")
    output-print (word "Firm produces " precision (market-share * 100) 1 "% of national meat supply")
    set color orange  ;; Change color to indicate affected status
  ]

  ;; Record production before shock for comparison
  set pre-shock-production total-production
end
to update-display
  ;; Update visual elements
  ask firms [
    ;; Color indicates production level relative to capacity
    ifelse is-major?
      [ set color scale-color red (current-production / production-capacity) 0 1 ]
      [ set color scale-color blue (current-production / production-capacity) 0 1 ]

    ;; Size represents market share
    set size 1 + market-share * 15

    ;; Adjust appearance based on production level
    ifelse affected-by-shock? [
      ;; Pulsing effect for affected firm
      ifelse (ticks mod 4 < 2) [
        set color orange
      ] [
        set color yellow
      ]
    ] [
      ;; Normal appearance
      ifelse is-major? [
        if market-share = 0.24 [set color red]
        if market-share = 0.22 [set color blue]
        if market-share = 0.19 [set color green]
        if market-share = 0.12 [set color yellow]
      ] [
        set color gray
      ]
    ]
  ]
  ;; update regions visualization
  ask regions [
    set color scale-color red regional-impact-level 0 1
  ]
end

to-report hhi
  ; Calculate Herfindahl-Hirschman Index (measure of market concentration)
  update-market-shares
  ; Calculate HHI based on squared market shares (times 10000 per standard formula)
  report sum [market-share ^ 2 * 10000] of firms
end

to-report cr4
  ; Force recalculation of market shares to ensure fresh values
  update-market-shares

  ; Simply use the firms with is-major? flag since you already set this up
  report sum [market-share] of firms with [is-major?] * 100

  ; Or alternatively, find the top 4 by market share without using a list:
  ; let top-4-firms nobody
  ; repeat 4 [
  ;   let next-highest max-one-of (firms with [not member? self top-4-firms]) [market-share]
  ;   if next-highest != nobody [
  ;     set top-4-firms (turtle-set top-4-firms next-highest)
  ;   ]
  ; ]
  ; report sum [market-share] of top-4-firms * 100
end

to-report production-loss-percentage
  ifelse pre-shock-production > 0 [
    report (pre-shock-production - total-production) / pre-shock-production * 100
  ] [
    report 0
  ]
end

to-report price-increase-percentage
  ifelse baseline-price > 0 and shock-occurred? [
    report (price - baseline-price) / baseline-price * 100
  ] [
    report 0
  ]
end

to-report national-security-risk
  ;; Calculate national security risk based on food security index
  ;; returns 0-100 value, where higher numbers indicate greater risk
  let base-risk-value 100 - food-security-index

  ;; Directly boost risk during active shocks
  if shock-occurred? or any? firms with [affected-by-shock?] [
    set base-risk-value base-risk-value + 30  ;; Add 30 points during active shocks
  ]

  ;; Apply additional risk based on supply chain disruption
  set base-risk-value base-risk-value + (supply-chain-disruption * 20)

  ;; Ensure risk stays in 0-100 range
  report max list 0 (min list 100 base-risk-value)
end


to-report regional-risk-index
  ;; Returns a list of regional risk values
  report regional-impact
end

to-report most-affected-region
  ;; Returns the name of the most affected region
  let max-impact max regional-impact
  let max-region position max-impact regional-impact

  ;; Convert region index to name
  let region-names ["Midwest" "South" "West" "Northeast"]
  report item max-region region-names
end

to-report supply-chain-health
  ;; Overall supply chain health metric (0-100)
  report 100 - (supply-chain-disruption * 100)
end

to-report recovery-time-estimate
  ;; Estimate remaining time to full recovery (in ticks)
  let lowest-recovery min [recovery-progress] of firms
  ifelse lowest-recovery < 1 [
    report ceiling ((1 - lowest-recovery) / recovery-rate)
  ] [
    report 0
  ]
end

to do-plots
  ;; Market Concentration Effects
  set-current-plot "Market Concentration Effects"

  ;; Force recalculation of metrics
  let current-cr4 cr4
  let current-hhi hhi

  set-current-plot-pen "CR4"
  plot current-cr4

;; ... rest of your plot code
  ; Food Security Dashboard
  set-current-plot "Food Security Dashboard"

  set-current-plot-pen "Food Security Index"
  plot food-security-index

  set-current-plot-pen "Days of Supply (scaled)"
  plot min list 100 (days-of-supply * 100 / 14)

  set-current-plot-pen "Supply Chain Health"
  plot 100 - (supply-chain-disruption * 100)

  set-current-plot-pen "National Security Risk"
  plot national-security-risk

  ; Supply-Price Relationship
  set-current-plot "Supply-Price Relationship"

  set-current-plot-pen "Production % of Baseline"
  ifelse pre-shock-production > 0
    [ plot (total-production / pre-shock-production) * 100 ]
    [ plot 100 ]

  set-current-plot-pen "Price % of Baseline"
  ifelse baseline-price > 0
    [ plot (price / baseline-price) * 100 ]
    [ plot 100 ]

  ; Regional Impact Comparison
  set-current-plot "Regional Impact Comparison"

  set-current-plot-pen "Midwest"
  plot item 0 regional-impact

  set-current-plot-pen "South"
  plot item 1 regional-impact

  set-current-plot-pen "West"
  plot item 2 regional-impact

  set-current-plot-pen "Northeast"
  plot item 3 regional-impact

  ; Market Concentration Effects
  set-current-plot "Market Concentration Effects"

  set-current-plot-pen "CR4"
  plot cr4

  set-current-plot-pen "Production Loss %"
  plot production-loss-percentage

  set-current-plot-pen "Shock Duration"
  ifelse shock-occurred?
    [ plot shock-duration - shock-timer ]
    [ ifelse any? firms with [affected-by-shock?]
      [ plot shock-duration ]
      [ plot 0 ]
    ]
end
@#$#@#$#@
GRAPHICS-WINDOW
212
10
602
401
-1
-1
11.6
1
10
1
1
1
0
1
1
1
-16
16
-16
16
1
1
1
ticks
30.0

BUTTON
32
10
95
43
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
123
10
186
43
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
1

CHOOSER
25
132
174
177
shock-scenario
shock-scenario
"Mild Disruption" "Severe Crisis" "Recovery Boost"
2

CHOOSER
24
80
179
125
shock-firm
shock-firm
"JBS (24%)" "Tyson Foods (22%)" "Cargill (19%)" "National Beef (12%)" "Random"
0

SLIDER
13
353
185
386
recovery-rate
recovery-rate
0.01
.5
0.1
.01
1
NIL
HORIZONTAL

SLIDER
14
229
186
262
shock-percentage
shock-percentage
0
100
30.0
5
1
NIL
HORIZONTAL

SLIDER
15
187
187
220
shock-duration
shock-duration
1
100
20.0
1
1
NIL
HORIZONTAL

SLIDER
14
309
186
342
cascading-effects
cascading-effects
0
1
0.2
.05
1
NIL
HORIZONTAL

SLIDER
13
396
185
429
price-elasticity
price-elasticity
.5
3
1.5
.1
1
NIL
HORIZONTAL

SLIDER
1
440
190
473
national-security-threshold
national-security-threshold
0
100
25.0
5
1
NIL
HORIZONTAL

MONITOR
614
195
744
240
HHI (Market Concentration)
precision hhi 0
4
1
11

MONITOR
614
256
745
301
CR4 (%)
precision cr4 1
4
1
11

MONITOR
615
486
748
531
Production Loss
precision production-loss-percentage 1
4
1
11

MONITOR
615
550
749
595
Price Increase (%)
precision price-increase-percentage 1
4
1
11

MONITOR
616
17
743
62
Food Security Index
precision food-security-index 1
4
1
11

MONITOR
614
77
744
122
National Security Risk
precision national-security-risk 1
4
1
11

MONITOR
614
369
745
414
Days of Food Supply
precision days-of-supply 1
4
1
11

MONITOR
614
315
746
360
Most Affected Region
most-affected-region
4
1
11

MONITOR
614
136
744
181
Supply Chain Health
precision supply-chain-health 1
4
1
11

MONITOR
615
426
746
471
Est. Recovery Time
recovery-time-estimate
4
1
11

PLOT
1595
625
1795
775
Food Security Metrics
Time
Index Value
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Food Security" 1.0 0 -13840069 true "" "plot food-security-index"
"Security Risk" 1.0 0 -2674135 true "" "plot national-security-risk"
"Supply Chain" 1.0 0 -13345367 true "" "plot supply-chain-health"

PLOT
0
481
200
631
Market Price
Time
Price
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Price" 1.0 0 -16777216 true "" "plot supply-chain-health"

OUTPUT
213
416
603
560
12

SLIDER
15
268
187
301
shock-start-time
shock-start-time
0
100
10.0
1
1
NIL
HORIZONTAL

SWITCH
50
45
156
78
apply-shock?
apply-shock?
1
1
-1000

PLOT
761
10
1167
253
Food Security Dashboard
Time (ticks)
Food Security (0-100)
0.0
60.0
0.0
100.0
false
true
"" ""
PENS
"Food Security Index" 1.0 0 -14070903 true "" ""
"Days of Supply (scaled)" 1.0 0 -15302303 true "" ""
"Supply Chain Health" 1.0 0 -955883 true "" ""
"National Security Risk" 1.0 0 -5298144 true "" ""

PLOT
761
265
1168
506
Supply-Price Relationship
Time (ticks)
% of Baseline
0.0
60.0
0.0
200.0
true
true
"" ""
PENS
"Production % of Baseline" 1.0 0 -14439633 true "" ""
"Price % of Baseline" 1.0 0 -5298144 true "" ""

PLOT
1180
265
1546
511
Regional Impact Comparison
Time (ticks)
Impact Percentage
0.0
60.0
0.0
100.0
false
true
"" ""
PENS
"Midwest" 1.0 0 -5298144 true "" ""
"South" 1.0 0 -13345367 true "" ""
"West" 1.0 0 -15637942 true "" ""
"Northeast" 1.0 0 -1184463 true "" ""

PLOT
1179
10
1545
254
Market Concentration Effects
Time (ticks)
Values
0.0
60.0
0.0
100.0
false
true
"" ""
PENS
"CR4" 1.0 0 -14070903 true "" ""
"Production Loss %" 1.0 0 -5298144 true "" ""
"Shock Duration" 1.0 0 -16777216 true "" ""

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
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

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

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

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
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
