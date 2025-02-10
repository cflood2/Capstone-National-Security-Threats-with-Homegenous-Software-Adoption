Project Risk Introduction: 

There are several potential risks factors, which can affect the project throughout the project lifecycle. For example, there have been several software vulnerabilities in the Endpoint Detection and Response (ERD) deployed by CrowdStrike. 
CrowdStrike is a software vendor contracted to serve several business clients such as financial institutions, government agencies and other organizations. 
Of Note: In April 2022, a Security Advisor who work for Modzero published a log file which indicated a vulnerability found in the CrowdStrike Falcon Sensor (reference report). 
The report advised CrowdStrike, which is a software vendor to Uninstall Protection Bypass for CrowdStrike Falcon Sensor. 
On 09/24/2004, Mr. Adams Meyers, Senior Vice President of CrowdStrike was summoned to appear to the 118th House Committee to provide testimony on why and how their software impacted a global outage.

Other risks to the project may include the following:

Resources: Due to the availability of personnel, the project may be delayed due to unforeseen issues, i.e., family, health, work issues, etc. 
Testing Environment: The equipment needed to conduct test may not be available
Funding:  The resource manager will need to approve funding for this project by February 16. The current funds have been allocated for the remainder of the fiscal year. May need to conduct a feasibility study to determine resources need and at what cost to the organization.
Scope Creep: In the requirements phase, the project may need modification due to significant changes to the project not included in the original requirement
Weather Conditions: The scope of the project may move to the left because of inclement weather (i.e., such as snow, ice, inclement weather, etc.) 
Scheduling Risks: The project may move to the left due to inclement weather, personnel, test environment, etc.

example chart of scope
|Scope Creep  | Impact     | Likelihood | Description |
|-------------------|------------|------------|-------------|
|Some risk (40) | 6 | 8 | In the requirements phase, the project may need modification due to significant changes to the project not included in the original requirement  |

Example of Known Common Vulnerabilities Exploits (CVE) in traditional software
Name and Description: Improper Privilege Management	
Common Vulnerability Exploit Number (CVE): CVE-2024-8306	
Impact: Loss of Confidentiality, Integrity and Availability of Data (CIA) of sensitive data	
Likelihood: Adversary can install malicious code and have escalation of privileges on a device or devices
Mitigation: Use strong passwords, install two factor authentication, password management policy, continuous network monitoring are some mitigations factors to limit access privileges

Name and Description: SQL Injection	
Common Vulnerability Exploit Number (CVE) CVE-2024-8465	
Impact: Adversary could send malicious code through design and retrieve all stored information in a repository.	
Likelihood: If SQL commands are not executed properly, adversary can take control of SQL database holding sensitive information	
Mitigations: Run code with least privileges. Use library or framework that does not allow weaknesses to occur or better provide constructs to make weakness easier to avoid.
Name and Description: CrowdStrike Falcon Sensor	
Common Vulnerability Exploit (CVE) CVE-2022-2841	
Impact: Adversary can attack Remotely with administrative privileges to bypass the token on window endpoint devices. 
Liklihood: Since the software was published to the public, the data is accessible to the public 
Mitigations: Upgrade to version 6.40.15409, 6.42.15611 and 6.44.15807 immediately

References:

CrowdStrike. External Technical Root Cause Analysis Channel File 291. 25 July 2024, p. 12, https://www.crowdstrike.com/wp-content/uploads/2024/08/Channel-File-291-Incident-Root-Cause-Analysis-08.06.2024.pdf.
“CrowdStrike Outage Explained: What Caused It and What’s next.” WhatIs, https://www.techtarget.com/whatis/feature/Explaining-the-largest-IT-outage-in-history-and-whats-next. Accessed 2 Feb. 2025.
Crowdstrike : Security Vulnerabilities, CVEs Published in 2022. https://www.cvedetails.com/vulnerability-list/vendor_id-28072/Crowdstrike.html?page=1&year=2022&order=1. Accessed 5 Feb. 2025.
CVE-2022-2841 : A Vulnerability Was Found in CrowdStrike Falcon 6.31.14505.0/6.42.15610/6.44.158. https://www.cvedetails.com/cve/CVE-2022-2841/. Accessed 5 Feb. 2025.
CWE - 2024 CWE Top 25 Most Dangerous Software Weaknesses. https://cwe.mitre.org/top25/archive/2024/2024_cwe_top25.html. Accessed 5 Feb. 2025.
CWE - CWE-89: Improper Neutralization of Special Elements Used in an SQL Command ('SQL Injection’) (4.16). https://cwe.mitre.org/data/definitions/89.html. Accessed 5 Feb. 2025.
NVD - CVE-2024-8465. https://nvd.nist.gov/vuln/detail/CVE-2024-8465. Accessed 5 Feb. 2025.
Pascal, Zenker. Modzero Security Advisory. Modzero Security Advisory, 22 Aug. 2022, modzero.com/advisories/MZ-22-02-CrowdStrike-FalconSensor.txt.
