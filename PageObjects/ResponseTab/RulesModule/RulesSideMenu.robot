*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Helpers/CommonMethods.robot
Resource    Rule.MitreTechniques.robot
Variables   ../../../Resources/Locators/ResponseTab/RulesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Navigate back to Rules page
    Scroll Element Into View    ${NavigateBackToRulesPage}
    Wait Until Element Is Visible    ${NavigateBackToRulesPage}  ${Timeout}
    Sleep    1
    Click Element    ${NavigateBackToRulesPage}
    Wait Until Element Is Visible    xpath=//h4[text()='Rules']    ${Timeout}
    Element Should Contain    xpath=//h4[text()='Rules']    Rules
    Wait for table page load spinner

Navigate to Rule Details page from side menu option
    Wait Until Element Is Visible    ${RuleDetailsSideMenuOption}    ${Timeout}
    Scroll Element Into View    ${RuleDetailsSideMenuOption}
    Sleep    1
    Click Element    ${RuleDetailsSideMenuOption}
    Wait Until Element Is Visible    xpath=(//span[contains(text(),'Incident Description')])[1]

Navigate to Mitre Techniques page from side menu option
    Wait Until Element Is Visible    ${MitreTechniquesSideMenuOption}    ${Timeout}
    Scroll Element Into View    ${MitreTechniquesSideMenuOption}
    Sleep    1
    Click Element    ${MitreTechniquesSideMenuOption}
    Wait Until Element Is Visible    xpath=(//span[contains(text(),'Mitre Techniques')])[2]
    Wait for mitre technique load spinner

Navigate to Playbooks page from side menu option
    Wait Until Element Is Visible    ${PlaybooksSideMenuOption}    ${Timeout}
    Scroll Element Into View    ${PlaybooksSideMenuOption}
    Sleep    1
    Click Element    ${PlaybooksSideMenuOption}
    Wait Until Element Is Visible    xpath=(//span[text()='Playbooks'])[2]

Navigate to Companies tab
    Scroll Element Into View    ${CompaniesSideMenuOption}
    Wait Until Element Is Visible    ${CompaniesSideMenuOption}  ${Timeout}
    Click Element    ${CompaniesSideMenuOption}
    Wait Until Element Is Visible    xpath=(//span[contains(text(),'Companies')])[2]
    
Navigate to the Rule Main page from the side menu option
    Wait Until Element Is Visible    ${MainSideMenuOption}      ${Timeout}
    Scroll Element Into View    ${MainSideMenuOption}
    Sleep    1
    Click Element    ${MainSideMenuOption}
    Wait Until Element Is Visible    xpath=//span[text()='Identification']      ${Timeout}