# Meatpacking Industry Market Effects Model
## Complete Control Manual

This document provides a comprehensive guide to all controls and functions available in the Meatpacking Industry Market Effects model.

## Primary Controls

### Setup and Simulation Controls

| Control | Function | Usage Notes |
|---------|----------|-------------|
| **Setup** | Initializes the model with clean settings | Must be clicked before each new simulation run |
| **Go** | Starts/stops the simulation run | Toggle button - click once to start, again to stop |
| **Simulation Speed** | Controls the speed of the simulation | Higher values = faster simulation |

### Shock Configuration Parameters

| Parameter | Function | Range | Default |
|-----------|----------|-------|---------|
| **Shock Scenario** | Preset configurations for different severity levels | Mild Disruption, Medium Crisis, Severe Crisis | Medium Crisis |
| **Shock Percentage** | Production capacity reduction for affected firm | 0-100% | Determined by scenario |
| **Shock Duration** | Number of ticks the direct shock lasts | 1-50 | Determined by scenario |
| **Price Elasticity** | How responsive prices are to supply changes | 0.5-3.0 | Determined by scenario |
| **Recovery Rate** | Speed at which affected firms recover | 0.01-0.5 | Determined by scenario |
| **Cascading Effects** | Degree to which shock spreads to other firms | 0-1.0 | Determined by scenario |
| **Apply Shock?** | Toggle to enable/disable the shock event | ON/OFF | OFF |
| **Shock Start Time** | When the shock occurs (in ticks) | 0-100 | 5 |
| **Shock Firm** | Which company is directly affected | JBS, Tyson, Cargill, National Beef, Random | JBS |
| **National Security Threshold** | Food security level that triggers elevated security concern | 0-100 | Determined by scenario |

## Dashboard Elements

### Main Dashboard Displays

| Display | Function | Interpretation |
|---------|----------|----------------|
| **Market Price** | Shows current and baseline prices | Red line shows current price, blue shows baseline |
| **Supply-Price Relationship** | Compares production and price changes | Shows inverse relationship between supply and prices |
| **Food Security Dashboard** | Composite view of security metrics | Higher values indicate better food security |


### Key Metrics Monitors

| Monitor | Function | Interpretation |
|---------|----------|----------------|
| **Total Production** | Current total meat production | Drops during shock events |
| **Price Increase %** | Percentage increase over baseline | Higher values indicate more severe market impact |
| **Production Loss %** | Percentage reduction from baseline | Higher values indicate more severe supply impact |
| **Food Security Index** | Overall measure of food system resilience | Lower values indicate greater food insecurity |
| **Days of Supply** | Estimated days of meat inventory | Lower values indicate potential shortages |
| **National Security Risk** | Security implications of disruption | Higher values indicate greater national security concern |
| **Supply Chain Health** | Overall supply chain resilience | Lower values indicate more disrupted supply chains |
| **Phase Indicator** | Current phase of incident | Normal, Attack, or Recovery |
| **Current Tick** | Current simulation time step | Used to track progress through simulation |

## Visual Interface Elements

### Agents and Their Representation

| Element | Visual Representation | Meaning |
|---------|----------------------|---------|
| **Large Firms** | Truck shapes (colored) | Major meatpacking companies (Big 4) |
| **Small Firms** | House shapes (gray) | Smaller regional processors |
| **Regions** | Circles | Geographic regions (Midwest, South, West, Northeast) |
| **Affected Firms** | Flashing orange/yellow | Firms currently impacted by cyberattack |
| **Recovering Firms** | Orange/yellow gradient | Firms in recovery phase |
| **Region Colors** | White, green, yellow, red | Severity of regional impact |

### Plot Interpretation

| Plot Element | Color | Interpretation |
|--------------|-------|----------------|
| **Food Security Index** | Green | Overall food security status (0-100) |
| **Days of Supply** | Blue | Scaled days of remaining inventory (0-100) |
| **Supply Chain Health** | Yellow | Overall supply chain functionality (0-100) |
| **National Security Risk** | Red | Security implications of disruption (0-100) |
| **Production % of Baseline** | Green | Current production as % of normal |
| **Price % of Baseline** | Red | Current price as % of normal |

## Output Window Messages

The model provides real-time event notifications in the output window, including:
- Cyberattack detection alerts
- Affected company identification
- Recovery phase announcements
- Market stabilization notices

## Advanced Functions

### Model Analysis Tools

| Function | Purpose | Access Method |
|----------|---------|--------------|
| **HHI Calculation** | Measures market concentration | Monitor display |
| **Recovery Time Estimation** | Projects time to full recovery | Monitor display |
| **Regional Impact Analysis** | Shows geographic distribution of effects | Regional impact plot |
| **Food Security Projection** | Projects food security based on recovery curve | Food security dashboard |

### Simulation Controls

| Function | Purpose | Access Method |
|----------|---------|--------------|
| **Custom Tick Counter** | Maintains consistent timing | Current tick monitor |
| **Phase Indicator** | Shows current incident phase | Phase indicator monitor |


## Debugging Functions

In case of model issues, check:
1. The `tick-is-safe` variable status
2. Whether output window shows error messages
3. If firm recovery progress is advancing properly
4. If price calculations remain within reasonable bounds

## Data Analysis

For post-simulation analysis, key metrics to extract include:
- Maximum price increase percentage
- Duration of significant price elevation
- Recovery time to baseline
- Peak national security risk level
- Minimum food security index
- Maximum regional impact levels
