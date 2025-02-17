# **Executive Summary:**
&nbsp; Modern infrastructure enables adversaries to disrupt organizations with cyber attacks. This problem is amplified when a single company dominates specific industries or services, such as banking, healthcare, or food production. This paper attempts to create policy recommendations addressing cybersecurity risks associated with this issue. For example, disruptions to food suppliers would cause widespread food insecurity. If Big Poultry Corporation produces 75% of domestic poultry products, a cyber attack targeting them would cause starvation conditions for large numbers of people. 
<br/>  
&nbsp; The risk to National Security&mdash;and stability, for that matter&mdash;is clear. Addressing this new risk is important when the Federal Trade Commission examines mergers and acquisitions (M&A) between large companies in addition to companies accounting for this risk in the decision-making process.
<br/>  
&nbsp; This paper will assess past incidents and use analogous examples to create evidence for use in a NIST (National Institute of Standards and Technology) CSWP (Cybersecurity White Paper.) This paper will also propose addendums to the Sherman Act, the Federal Trade Commission Act, or Clayton Act for use by the USFG (United States Federal Government.)

### Objectives:
- Investigate CrowdStrike incident
- Investiagte on SolarWinds incident
- Investiagte Ukraine cyber war telecom attack
- Investigate JBS indident
- Hytpothesize attck on EPIC (Healthcare software)
- Create and/or simulate the reach of an incident using NetLogo
- Address supply chain management concerns
  
### Goals:
- Create guidelines for software adoption to add to existing policy
- Create guidelines for the USFG to consider in M&A filings
- Create guidelines for DoD (Department of Defense) when contractors attempt to consolidate
- Propose addendums to existing anti-trust acts  


# **Proposed Project Timeline**
![Gantt Chart](Gant%20Chart.png)  

[Complete Timeline](https://unomail-my.sharepoint.com/:x:/r/personal/cflood_unomaha_edu/Documents/Consolidation%20%26%20NATSEC.xlsx?d=wbcecc40dd41248a8a813af53553fa10e&csf=1&web=1&e=96HGBF)


### Project Risk List
|Risk  | Impact     | Likelihood | Description |
|-------------------|------------|------------|-------------|
|Resources (70)|9|9|Due to the availability of personnel, the project may be delayed due to unforeseen issues, i.e., family, health, work issues, etc.|
|Testing Environment (60)|9|9|The equipment needed to conduct test may not be available|
|Scope Creep (70) | 8| 8 | In the requirements phase, the project may need modification due to significant changes to the project not included in the original requirement  |  
|Scheduling Risks (70)|9|9|The project may move to the left due to inclement weather, personnel, test environment, etc.|


## **Project Methodology**
### Initial Lit Review  
  
##### Evaluating and Mitigating Software Supply Chain Security Risks by Robert J. Ellison etal.
 - Discusses minimizing opportunites or incidents of unathorized changes. Relevent to CrowdStrike incident of 2024. Identifies supply chain risks and specifys evidence needs to to appropriotely mitigate. According to the report evry phase of life cycle must be part of mitigation: nitiation, development, configuration/deployment, operations/maintenance, and disposal. Lacks any mention of 
----------
##### Cyber supply chain risks in cloud computing – bridging the risk assessment gap by Olusola Akinrolabu etal.
 - Proposes a model called *Cloud Supply Chain Cyber Risk Assessment*  to address dynamic risks associated with cloud computer. Survey dataset showed a lack of flexibility in assessment methods or no assessment at all.
----------
#### Beyond SolarWinds: The Systemic Risks of Critical Infrastructures, State of Play, and Future Directions
- Discusses the reliability of the framework for the cybersecurity of critical infrastructure. It highlights the operation of critical infrastructure, interconnectedness of  the software supply chain.
----------
##### Cloud-Based Disaster Recovery: Reducing Risk and Improving Continuity by Premkumar Ganesan
 - Covers recovery strategies for cloud environment. Cloud Based Disaster Recovery (CBDR). Examples include backup environments, failovers, and redundancies.
----------  
##### Lawmakers Scrutinize Meatpacking as JBS Rebounds From Cyberattack
 - Cyber attack affted JBS meat packing plants in Australia, Canada, and the United States. Operatiosn were shut down for at least a day. Concerns from congressmembers were expressed "If it was 10 or 20 companies instead of 4 wed be less vulnerable." Follow up research suggest nothing came of congressional concerns.  
[archive.today link](http://archive.today/rHVBe)
----------  
##### The World's Food Supply Has Never Been More Vulnerable  
 - One Smithfield Foods plant processing more than 15% of all pork in the U.S. The 2021 JBS attack sabotaged more than a fifth of all U.S. beef processing in a matter of minutes. Four processing companies slaughter more than 80% of US beef; four meatpacking companies process roughly two thirds of the nation's hogs; and five companies control about 60% of the broiler chicken market.  
[archive.today link](http://archive.today/VRpje)  
-------------
## Measuring Impact on Confidence in Institutions by their Use of Software Components

### **Abstract:**  
We discuss the concept of confidence as a type of trust, outline existing techniques how to measure it, and discuss the applicability of known techniques on measuring changes in trust caused by software that cannot be perceived by its users. We conclude that the methods proposed are relevant to domains such as e-Health, e-Government, and other domains from the public sector that aim to increase trust by citizens, patients, and other forms of customer roles.

### **Introduction:**  

### **Problem Statement:**  
> **What is the primary problem that the study investigated?**  
> The purpose of the paper’s research is to answer the following question: How can we measure impact on confidence / trust in an institution, when the institution updates its software in a way that neither in-house users of the institution, nor customers of the institution can directly perceive the change. To the best of our knowledge, this question has not yet been addressed.

> **What has been done in the literature review?**   
> *Answer:* Having both the confidence and trust in the tools to measure the effectiveness of in software changes implemented in both the public and private sector.

> **Why is this an urgent and or severe problem?**  
> *Answer:* When software is implemented both in the public and private sector, the expectation is for the software to have gone through a strict rigorous approval process, The approval process should include factors such as bench testing, change management review boards, software testing in a controlled environment and following industry best practices for software assurance. The problem comes when these factors have not been followed thoroughly in the software assurance process.

 
### **Research Question(s)**  
> **What question related to the problem have not been answered by prior research?**    
> *Answer:* The research indicated how can you measure impact on confidence / trust in an institution, when the institution updates its software in a way that neither in-house users of the institution, nor customers of the institution can directly perceive the change. To the best of our knowledge, this question has not yet been addressed.


> **What are the practioners or prior research lacking an understanding of the phenomenon being studied?**    
> *Answer:* Tools or techniques which can be used to measure the confidence level and trust between in-house users of the institution  and the consumers who receive the updates when software baseline is changed. A good example is when the vendor CrowdStrike implemented a software change which wreaked havoc to government agencies and organizations. One software update, deemed critical,  grounded our nation’s infrastructure throughout the country to a complete halt and work stoppage.

### **Contributions Made:**  
Recently, Hou & Janssen [18] have conducted a literature review on trust within the software ecosystem and in software as such.
They  define the software ecosystem as one that comprises actors such as:
• software end-users who “adopt a software product to makethem more productive”,
• end-user organizations, who “expect that the software products add value to their organization’s goals”,
• software engineers who create and maintain software products in their capacity as talented individuals,
• software producing organizations, who employ software engineers to “build and maintain software to create valuable
software that should be adopted as widely as possible”, and
• package maintainers, who are “responsible for developing and maintaining software packages and their frameworks”.

### **Investigative Approach:**  
Vargas &al. [27] point out that software developers choose third-party packages (libraries, frameworks, or APIs) arbitrarily, without considering the consequences of their decisions, unless constrained
by their organizations’ policies.

The Guttman scale was used to as to conduct a series of short essay type question about how people dealt with trust. Trust factors included the following: third party access consumers data, what would happen if their data was breached and the transfer of consumer data.

### **Primary Findings:**  
Researchers found the software engineering process requires confidence and trust, as software engineers use software using third-party components freely available on software repositories on the internet.  Researchers also found that to build on trust, individuals, institutions or technical systems can be measured by tools from techniques  as the Guttman or Likert scales 

### **Challenges:**  
As public agencies and institutions from the public sector at large have thoroughly digitalized their processes – both customer-facing and internal, they all face the challenge to efficiently communicate to their internal and external stakeholders that they are and will remain trustworthy. This adage applies to agencies from e-Health-
hospitals, social insurances, and other institutions from the health-care ecosystem, e-Democracy - parliaments, electoral commissions, etc., and e-Government - municipalities, ministries, and all bodies engaged in governing public affairs.

[Paulin, Alois. “Measuring Impact on Confidence in Institutions by Their Use of Software Components.” Proceedings of the Central and Eastern European eDem and eGov Days 2024, Association for Computing Machinery, 2024, pp. 119–24. ACM Digital Library,](https://doi.org/10.1145/3670243.3670249.)  

--------
## Towards Agility in Design in Global Component Based Development(CBD) 

### **Abstract:**  
Component Based Development can be appealing to software developer to distribute  work to different sites to maintain ownership and responsibility of software components. This approach can decrease knowledge awareness to achieve agility in the design process. Methodologies used in the Component Based Development platform includes the following: automation of management interdependencies between software components and related files, the setup of bug tracking tools on a centralized server, using processes, tools, techniques and procedures and creating a how to guide on the methodology of tools being used and having a centralized Integrated Development Environment

### **Problem Statement:**  
> **What is the primary problem that the study investigated?**  
> *Answer:* How the adoption of a Component Based Development (CBD) can be globally distributing software to development teams. Based upon research, the primary issue have created expectations of how software should be mitigated based upon globally distributed teams.

> **What has been done in the literature review?** 
> *Answer:*  The LeCroy software team developed a toolbox  which can be integrated in a developmental environment and also be accessible to all members of ta geographical dispersed team. CBD also offers agility based upon software development and support reusable components expanding across multiple platforms across geographical sites. 

> **Why is this an urgent and or severe problem?**  
> *Answer:* Researcher's argued that it took longer to develop reuse of software components than developing a system. The lack of standards, reusable components and the granularity and generality of components made expectations difficult to achieve. Also the ownership to develop mitigated software independently would reduce communication and coordination efforts. Other challenges include each site having specialized experience in a different domain or market (e.g. site A specializes in the banking sector while site B specializes in the insurance sector. This could hinder the development of neighboring sectors and implementation of agility in the software design that offers future integration of existing solutions

### **Research Question(s)**  
> **What question related to the problem have not been answered by prior research?**  
> *Answer:*  How geographically software development teams do not communicate effectively across different industry and government sectors nor have the understanding on how to reuse software components in a rapidly changing environment.

### **Contributions Made:**  
The LeCroy software team developed a toolbox  which can be integrated in a developmental environment and also be accessible to all members of ta geographical dispersed team.

### **Investigative Approach:**  
The LeCroy software team implemented  customer-specific components, modification of existing components with the customers system. Members of the team worked across three geographical locations. Vendors of third-party components were located in various countries (more than 25 vendors total)  

### **Challenges:**  
Researcher argued that it took longer to develop reuse of software components than developing a system. The lack of standards, reusable components and the granularity and generality of components made expectations difficult to achieve. Also the ownership to develop mitigated software independently would reduce communication and coordination efforts. Other challenges include each site having specialized experience in a different domain or market (e.g. site A specializes in the banking sector while site B specializes in the insurance sector. This could hinder the development of neighboring sectors and implementation of agility in the software design that offers future integration of existing solutions

### **Implications for Practice:**  
Supporting reusable components expanding across multiple platforms across geographical sites. 

### **Implications for Research:**  
The potential benefits of implementing CBD methodologies in a globally distributed environment are many. Lessons from the aeronautics, automotive, electronics and computer hardware industries, in which Component Based architectures have been successfully employed for setting up globally distributed design and production in the reuse of software components

### **Reference:**  
[Jarzombek, Joe. “Software Assurance: Enabling Security and Resilience throughout SDLC.” Assurance: Enabling Security and Resilience throughout SDLC,](https://csrc.nist.gov/CSRC/media//Projects/Forum/documents/2012/october-2012_fcsm-jjarzombek.pdf.)  

------------
## Title: National Security and Competition: How Courts Evaluate National Security when Assessing a Merger  

### **Abstract:**  
In prior years, the mergers of firms in the defense industrial base system (DIB) had no impact on national security. Fast forward today where there is increased concerns over mergers and acquisitions. The landscape of threats to national security is concerning because companies have increased footprint in mergers and acquisitions. This consolidation has created a national security risk when previously the only concern was in consolidation.  
The research article also point out there have increased oversight in government challenges to mergers and acquisitions in the defense industrial base. This could lead to conflicts between the goals of antitrust law fostering competition and nations security namely, protecting the security of the American people. 

### **Problem Statement:**  
> **What is the primary problem that the study investigated?**  
> *Answer:* The landscape of threats to national security is concerning because companies have increased footprint in mergers and acquisitions. The courts have to decide or analyze national security concerns in defense mergers because of the lack of competition in many defense markets, barriers to entry in those markets and limitations of non-antitrust tools for improving competition 

> **What has been done in the literature review?**   
> *Answer:* The Department of Defense created five recommended actions to address national security concerns for company mergers or acquisitions:
> •	Strengthening merger oversight
> •	Addressing intellectual property limitations
> •	Increasing new entrants
> •	Increasing opportunities for small businesses
> •	Implementing sector-specific supply chain resiliency plans

> **Why is this an urgent and or severe problem?**  
> *Answer:* Mr. Michael McLaughlin, who conducted the research,  argued when companies merge, there is an increased risk competitively which increase national contracting world

> **What question related to the problem have not been answered by prior research?**  
> *Answer:* How to reduce or balance company mergers while protecting national security in a complex and everchanging world  

**Investigative Research:**  
To show data analysis and trends for industry specific mergers and acquisitions in organizations

**Challenges:**    
Mergers and acquisitions does create challenges for innovation(s). These can hinder the DOD’s access to innovative products and services 
To only have one defense contractor as the sole provider to provide servers leaving other contract companies to not compete. The courts found the merged company would create monopoly having a competitive advantage  

---------
**Reference:**    

[National Security and Competition: How Courts Evaluate National Security When Assessing a Merger](https://jnslp.com/wp-content/uploads/2024/06/National_Security_and_Competition.pdf)  

[DOD Needs Better Insight into Risks from Mergers and Acquisitions.GAO-24-106129, United States Government Accountability Office, Oct. 2023, pg(s)49](https://www.gao.gov/assets/d24106129.pdf.)  

[Federalnewsnetwork.com. - How to mitigate the threat of industrial base consolidation](https://perma.cc/3PPF-H893)  

[Michael, McLaughlin. “National Security and Competition: How Courts Evaluate National Security When Assessing a Merger.” Federal Trade Commission, no. 6621, June 2024,](https://jnslp.com/2024/06/27/national-security-and-competition-how-courts-evaluate-national-security-when-assessing-a-merger#:~:text=3-,National%20Security%20and%20Competition%20How%20Courts%20Evaluate,Security%20When%20Assessing%20a%20Merger&text=Michael%20McLaughlin%20examines%20the%20effect,ought%20to%20be%20framed%20cohesively.)  

[Beyond SolarWinds: The Systemic Risks of Critical Infrastructures, State of Play, and Future Directions](https://ceur-ws.org/Vol-2940/paper33.pdf)  

[SolarWinds hack explained: Everything you need to know](https://www.techtarget.com/whatis/feature/SolarWinds-hack-explained-Everything-you-need-to-know)  

---------
#### **Initial Technical Plan**  
 1. Conduct a Qualtrics survey of cybersecurity professionals and decision makers to determine what parameters are most important when adopting new security software.
 3. Sign up to present at DEFCON402 monthly meetup to find respondents.
 4. Create and simulate a model of an attack and terticary effects using NetLogo. NetLogo is used to create models of all kinds of interconnected devices, diseases, people etc.
 5. Scala drives NetLogo, may need to learn Scala.
 6. Review real world incidents (JBS, CrowdStrike, Ukraine)  

-------------
### **Resources Needed:**
|Resource  | Dr. Hale needed? | Investigating Team member | Description |
|-------------------|---------|---------------------------|-------------|
|Scala| No | Brian | Programming language used in Net Logo  |
|Net Logo | No | Connor | Platform for building and simulating models of natural and social systems |
|ACM Digital Library| No | Sheryl | Search engine that helps users find academic and scholarly materials |
|NIST | No | Ryan | U.S. federal agency that develops and promotes standards and technology |
|Qualtrics| No | All | Web based survey creation and distribution software |

> Note: NetLogo uses the programming language Scala for the construction of agent-based modeling. NetLogo can create models of computer networks to simulate packet transmission, congestion, and routing. It can introduce cyber-attacks, defense strategies, and countermeasures. A person can see real-world impact of vulnerabilities and attacks on their networks.
> Note: Qualtrics is a web based tool used to create, distribute, and code qualitative or quantitative research.  


### **Presentation**
[M1 Presentation](https://unomail-my.sharepoint.com/:p:/r/personal/rjthompson_unomaha_edu/Documents/M1%20Presentation.pptx?d=w572b000d007a44fbac5e42f1fb87c598&csf=1&web=1&e=Gjc7Mg)
