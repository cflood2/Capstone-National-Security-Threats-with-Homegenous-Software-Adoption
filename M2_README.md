# Environment Setup 

For our modeling we used a program called NetLogo. NetLogo is a programmable modeling environment used for simulating natural and social phenomena. NetLogo is agent-based, meaning it allows users to create and simulate the actions of individual "agents" (like animals, people, or vehicles) in a system to observe how complex behaviors emerge from simple rules.

NetLogo is free and supported by Northwestern University. It is available for Windows, Mac, and Linux and is as simple as requesting to download the installer, then running it. After that, an existing model can be imported and modifications made, or users can start from scratch. NetLogo models are written in a language called Scala.

## Network Model
### Network Model variables and parameters
**User-Nodes:** The number of nodes that represent the number of users within a network.     
**CrowdStrike-connections:** The number of node connections to the CrowdStrike node. For the outage a large number of connections is used.      
**Average-node-connection:** The average number of times each node is connected to another node.     
**bad-update-spread:** This represents the chance that the update was pushed to a connected node.     
**update-fix-chance:** Represents the chance the node is fixed.     
**recovery-delay:** This mimics the amount of time it takes for the fix to be implemented.      

## Supply Chain Model
### Below is a detailed explanation of each parameter in the Supply Chain Model  
**Initial Conditions:** ​Each firm starts at full production capacity, 14 days of meat supply in the system, and has a food security index of 100 (best case).  
**Shock Scenarios:** Mild – A small-scale attack with 10% production loss and a 5 tick recovery.​     
   **Recovery** – A moderate attack with 30% production loss, 20 tick recovery, but has industry support for recovery. ​    
   **Severe** – A major cyberattack with 50% production loss and a 30 tick recovery time.     
**Key Parameters:** Shock duration: Number of ticks that the initial "shock" lasts. (0-30)The greater the duration, the greater the disruption (0-30)​    
**Shock percentage:** Production reduction during shock (10-70%).  It represents the total immediate production reduction.​    
**Recovery rate:** Speed at which the affected firms recover (1-50%) per tick. ​    
**Cascading effects:** The rate at which disruptions spread to other firms (0 – 100%) The higher values mean the supply chain is affected more. ​    
**Price elasticity:** How prices respond to changes in supply. (.5-3.0) The higher values create more dramatic price hikes. ​    
**Shock-start time:** This is the tick number when disruption begins. It allows for observing baseline values before a shock happens. ​    
**National security threshold:** The risk level that simulates national security concerns (0-100). The higher the value, the more sensitive the model will report national security risks. The lower threshold means that the model will only report national security risks only in severe situations.     

# Project Realization  
## >>> [Project Realization Report](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/main/prototype-progress-report.md) <<<  

# Research Paper Outline  
## >>> [Research Paper Outline](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/main/M2Docs/PaperOutline.md) <<<   

   
# Visuals and Diagrams  
## Survey Results  
> ![MarketShare](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/main/M2Docs/Diagrams/Chart1.png?raw=true)
> ![MarketShare2](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/main/M2Docs/Diagrams/Chart2.png)  
> ![MarketShare3](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/main/M2Docs/Diagrams/Chart3.png)
## Defcon Problem Visualization
> ![Defcon1](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/5ad9e0de00104a7072778d3277cd49d48a51c6aa/M2Docs/Diagrams/IntraIndustryDiagram.png)
> ![Defcon2](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/5ad9e0de00104a7072778d3277cd49d48a51c6aa/M2Docs/Diagrams/DistributionDiagram.png)
## Network Model and Results
> ![Interface](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/main/M2Docs/Diagrams/Network%20Full%20model.png)
> ![Results-Crowdstrike](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/main/M2Docs/Diagrams/Network%20model-%20Crowdstrike.png)
> ![Results-Fixes implemented](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/main/M2Docs/Diagrams/Network%20model-%20faster.png)
## Supply Chain Interface and Results
> ![Interface](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/9d59eaa2a185c4a55f64270e1663c9b533c66a05/M2Docs/Diagrams/JBS%20Model%20UI%20Interface.png)
> ![Results](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/9d59eaa2a185c4a55f64270e1663c9b533c66a05/M2Docs/Diagrams/JBS%20Model%20Graphs.png)

# Issue Tracking and Planning (Submission captured by GitHub activity)  

# Presentation

## >>> ![M2 Presentation](https://github.com/cflood2/Capstone-National-Security-Threats-with-Homegenous-Software-Adoption/blob/07d0c3a2ec6b075399a3ad4001ab361235c895d0/M2Docs/M2%20Presentation.pptx) <<<
