# Cybersecurity and Consolidation: 
## 1. Abstract - Summary of Claims and Findings  
 
> &nbsp; Over recent years, ransomware attacks have increased across large corporations, many of which operate within the United States’ sixteen federally designated critical infrastructure sectors. These sectors include Energy, Food and Agriculture, and Healthcare and Public Health, among others. For example, JBS, one of the world’s largest food and agriculture companies, fell victim to a ransomware attack. JBS’s dominant market share—achieved through consolidation—creates a serious national risk by forming a single point of failure on an industrial scale. If a cyberattack disrupts even 25% of the critical infrastructure, the resulting downstream effects could destabilize essential systems. In the case of food production, such an attack might lead to food scarcity or even famine.  
	&nbsp; In addition to the risks from consolidation, widespread market share itself presents another vulnerability. The CrowdStrike update on July 19, 2024, demonstrated how a single company with extensive market penetration could unintentionally cause massive disruption. While broad adoption often indicates a product’s effectiveness, in today’s hyper-connected world, voluntary market consolidation may increase systemic risk. Decision makers must evaluate whether they truly understand the hazards associated with these dependencies. Centralizing critical services within a few dominant companies amplifies the risk and accelerates the spread of negative consequences during cyber incidents.  
	&nbsp; Our research team designed a survey to determine whether organizations consider market share when selecting new software, along with other essential decision-making factors. The survey did not assess the direct pros or cons of market share but instead gauged whether professionals view it as relevant. Results showed that both security and non-security professionals influence software decisions, with the latter playing an increasing role.  
	&nbsp; To explore these risks further, we developed two agent-based models using NetLogo. The first model simulates a network attack and calculates the resulting outage duration based on security conditions. The second model maps that outage onto a food production supply chain, revealing how disruptions propagate. For example, a three-day network outage in the first model drives a three-day interruption in food production in the second. Companies with lower cybersecurity resilience or higher market share experienced longer or more severe disruptions, while smaller or more secure firms produced less downstream impact.  
	&nbsp; Our survey results support these findings. When asked whether market share influences software adoption, 50% of respondents answered yes, while 50% answered no. When evaluating widespread adoption, 17% viewed it as extremely positive, 35% somewhat positive, and 48% neutral. None saw it as negative. Regarding perceived risk, 4% saw high risk, 43% medium, 43% low, and 9% near zero. Most respondents did not associate widespread adoption with higher risk, reinforcing the belief that market dominance suggests reliability.  
	&nbsp; This perspective overlooks a critical insight: consolidation may serve attackers more than it aids defenders. In critical infrastructure, concentrated market share increases the payout for cybercriminals. To mitigate this risk, the U.S. government should apply anti-trust policies more aggressively, as it does in military contracting. Additionally, IT professionals must push for better vendor protections and enforce change control standards to prevent disruptions caused by vulnerabilities in widely adopted software.  

## 2. Introduction  
  - Background information on the topic – JBS and CrowdStrike cyberattacks
  - Research problem or question
    > 1. What cybersecurity risks arise from consolidation in critical infrastructure?  
    > 2. How have past cyber attacks on large companies affected national security and societal stability?  
    > 3. What lessons can be drawn from analogous examples, to understand the vulnerabilities of critical industry monopolization? 
  - Significance of the study: A lack of awareness left unaddressed has the potential to disrupt the social contract.  
  - Create a model to simulate a single point of failure. Calculate how many days food production would need to stop before starvation conditions become a risk. 
  - **THESIS:** Consolidation in critical infrastructure sectors significantly increases negative downstream effects and creates single points of failure on an industrial scale. 
## 3. Literature Review  
  - Overview of existing research  
  - Key theories, models, or frameworks  
  - Gaps in the literature. Are industrial level single points of failure ever addressed or mentioned? **Not really.**  
  - How your research addresses these gaps.
  	- **ANS: Our research uses a model to simulate this gap and hypothesize/demonstrate downstream effects.**


## 4. Methodology  
  - Research design:
    - Detail survey questions and goals, as well as target respondents  
    - Summarize Case Study Findings (Below)
    - Detail NetLogo model
      - Model 1. – Network attack, what we are trying to show and expect (Simulates CrowdStrike)
      	- What are the agents in the model?
      	- List of agents in each model  
      	- Explain what sliders represent  
      	- Explain What outcomes mean  
      	- Explain what a tick represents  
      - Model 2. – Supply Chain effects of network attack i.e. take length of network attack, input disruption time frame into supply chain model. Analyze results (Simulates JBS).
      	- What are the agents in the model?
      	- List of agents in each model  
      	- Explain what sliders represent  
      	- Explain What outcomes mean  
      	- Explain what a tick represents
       
    
  - Data collection methods:
    - Qualtrics survey
    	- Sampling techniques
      	- Sent survey to colleagues and colleagues of colleagues in security field both public and private
    - Analysis of case Study of JBS
    - Analysis of case study CrowdStrike  
    
## 5. Results
  - Presentation of data
	- When assessing new software, do you take market share (How many other companies have adopted) into consideration? (50% Yes, 50% No)
	- Would you consider widespread market adoption a positive or negative factor? (17% Extremely Positive, 35% Somewhat Positive, 48%  Neutral, 0% Somewhat Negative, 0% Extremely Negative)
	- Would you consider widespread market adoption a high risk or low risk? (4% High Risk, 43% Medium Risk, 43% Low Risk, 9% Near Zero Risk)  
  	- Visual aids (tables, graphs, charts) --> Diagram directory of GitHub  
		- Charts of results of survey  
		- Charts of results of models  
		- **NOTE:** Need to discuss Activity/Process Diagrams with Team  
  - Key findings  
## 6. Discussion
  - Interpretation of results
  	- Most respondents viewed large market share as low-risk, and a positive trait when vetting software.  
   		- **NOTE:** The idea of this as a single point of failure was only presented to the group after the survey was taken.  
   	- Consider how opinion may have changed (More research) and also use this as evidence of a lack of awareness regarding this potential issue.
  - Comparison with existing literature --> This specific issue is never addressed in the private sector but alluded to in military reports
  - Implications of findings
  	- Respondents mostly view large market share as a low-risk positive attribute.
   	- This suggests homogenous software adoption will continue to grow.
	- If another CrowdStrike incident occurred, it may result is an even larger outage, which means an even greater single point of failure, nationally.
	- Case studies show there is currently an inherent time-bomb, so to speak, especially if consolidation continues.
	- Also include what happens to social contracts when food scarcity increases.
  - Limitations of the study --> While results varied, ultimately brought up more questions. For example, responses to market-share question positive/negative, should be followed up with more research on *why* positive or negative. This project does not have time to address this gap.
  - Recommendations for future research --> Refine modeling, wider survey focused on the *why* of positive/negative views on market share
## 7. Conclusion
  - Summary of findings
  	- The survey indicated a lack of awareness or concern regarding market share.
   	- It is our opinion that this is a greater risk than is considered by professional practitioners
  - Contribution to the field --> Model and research serves as evidence for future legislation 
  - Final thoughts > # Consolidation is bad!

## 7. References
  #### APA Style
