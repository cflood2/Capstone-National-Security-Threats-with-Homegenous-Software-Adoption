# Supply Chain Model Setup Instructions

## Abstract

This model is designed to simulate the conditions of the 2021 JBS Cyberattack and the effects that it had on the highly consolidated meat production industry. In May/June of 2021, a significant ransomware attack caused a temporary shut down of all US beef plants, which affected JBS's operations globally. The downtime of critical systems disrupted food supply chains, put severe pressure on other firms to pick up production (to account for shortages), and highlighted vulnerabilities in critical food infrastructure.

## Instructions

The following instructions are fine tuned to replicate conditions during the 2021 JBS ransomware attack.

### Step 1: Initial Setup

1. Open up the NetLogo model and click the "**setup**" button to initialize the simulation.
2. You should see the visualization effects appear in the environment window, food security index should be 100, National Security Risk at 0, Supply Chain Health at 100, Days of Food Supply at 14, Price Increase % at 0, Tick Count at 0, and all graphs should be blank.

### Step 2: Note Visual Elements

#### Agents:

- **Trucks**: The four major meatpacking firms in the US.
  - **Red Truck**: JBS
  - **Blue Truck**: Tyson Foods
  - **Green Truck**: Cargill
  - **Yellow Truck**: National Beef
 
- **Houses**: The small houses scattered randomly represent smaller firms that make up the rest of the 23% of market share.
 
- **Circles**: Geographic Regions that are labeled. The colors will change depending on severity of impact after an attack. White is normal, green is minor impact, yellow is moderate impact, and red is severe impact.
 
#### Key Visual Indicators

1. Trucks will turn orange when the firm is actively under attack. The truck size will change to reflect the current market share (smaller truck means production has shrunk due to outage and other firm's trucks will become slightly larger to make up for production decreases).
2. The region circles will change color depending on the intensity of the impact to that region (green is minor impact, yellow is moderate, and red is severe).

### Step 3: Set Shock Parameters

Use the slider UI functions on the left-side of the NetLogo dashboard to configure the following settings.

| **Parameter** | **Setting** | **Notes** |
|---------------|-------------|-----------|
| shock-scenario | Medium Crisis | Was significant but not catastrophic |
| shock-percentage | 40% | Restored operations within a week |
| shock-duration | 30 | Scaled to represent 7 days |
| price-elasticity | 1.3 | Meat prices were moderately affected |
| recovery-rate | .15 | JBS recovered relatively quickly |
| cascading-effects | .2 | The attack moderately affected other firms |
| apply-shock | On | Let shock (attack) happen |
| shock-start-time | 35 | Lets model stabilize before attack |
| shock-firm | JBS (24%) | Let JBS be the target of attack |
| simulation-speed | 4-5 | This slows down simulation |

**Note**: If using the shock-scenario chooser, the parameters will automatically populate all sliders to reflect the severity of the crisis (Mild, Medium, Severe) and no additional setup is required.

### Step 4: Run the Simulation

1. Click the "Go" button to start the simulation.
2. Observe the graphs to see how the "shock" (attack) affects:
   - Price increases
   - Food security metrics in Food Security Dashboard
   - National security risk levels
   - Supply-price relationships
