*** Settings ***
Library     SeleniumLibrary
Resource    ../../Helpers/CommonMethods.robot
Variables   ../../Resources/Locators/ResponseTab/ResponseTabSidebarLocators.py
Variables   ../../Utils/TestConfigData.py

*** Keywords ***
Click the response tab sidebar hamburger option
    Wait Until Page Contains Element    ${SidebarHamburgerMenuOption}   ${Timeout}
    Click Element    ${SidebarHamburgerMenuOption}
    Sleep    1

Navigate to Rules page from the hambuger menu
    Wait Until Element Is Visible    ${RulesSidebarOption}  ${Timeout}
    Sleep    1
    Click Element    ${RulesSidebarOption}
    Wait Until Element Is Visible    xpath=//h4[text()='Rules']    ${Timeout}
    Element Should Contain    xpath=//h4[text()='Rules']    Rules
    Wait for table page load spinner

Navigate to the Black White list page from the hamburger menu
    Wait Until Element Is Visible    ${BlackWhiteListSidebarOption}    ${Timeout}
    Sleep    1
    Click Element    ${BlackWhiteListSidebarOption}
    Wait Until Element Is Visible    xpath=//h4[text()='Black/White List']      ${Timeout}
    Element Should Contain    xpath=//h4[text()='Black/White List']    Black/White List
    Wait for table page load spinner