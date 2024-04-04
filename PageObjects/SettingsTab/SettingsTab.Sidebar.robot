*** Settings ***
Library     SeleniumLibrary
Variables   ../../Resources/Locators/SettingsTab/SettingsTabSidebarLocators.py
Variables   ../../Utils/TestConfigData.py
Resource    ../../Helpers/CommonMethods.robot

*** Keywords ***
Click the settings tab sidebar hamburger menu option
    Wait Until Element Is Visible    ${SidebarHamburgerMenuOption}  ${Timeout}
    Click Element    ${SidebarHamburgerMenuOption}
    Sleep    1

Navigate to the companies page from the settings hamburger menu
    Wait Until Element Is Visible    ${CompaniesSidebarOption}  ${Timeout}
    Click Element    ${CompaniesSidebarOption}
    Wait Until Element Is Visible    xpath=//h4[text()='Companies']     ${Timeout}
    Element Should Contain    xpath=//h4[text()='Companies']    Companies
    Wait for table page load spinner

Navigate to the relations page from the settings hamburger menu
    Wait Until Element Is Visible    ${RelationsSidebarOption}    ${Timeout}
    Click Element    ${RelationsSidebarOption}
    Wait Until Element Is Visible    xpath=//h4[text()='Relations']     ${Timeout}
    Element Should Contain    xpath=//h4[text()='Relations']    Relations
    Wait for table page load spinner