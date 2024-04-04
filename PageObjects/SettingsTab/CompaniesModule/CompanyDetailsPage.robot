*** Settings ***
Library     SeleniumLibrary
Variables   ../../../Resources/Locators/SettingsTab/CompaniesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Navigate to the Monitoring system section from the sidebar
    Wait Until Element Is Visible    ${MonitoringSystemSidebarOption}   ${Timeout}
    Click Element    ${MonitoringSystemSidebarOption}
    Wait Until Element Is Visible    xpath=//h6[text()='Monitoring Systems']    ${Timeout}

Navigate to the Users section from the sidebar
    Wait Until Element Is Visible    ${UsersSidebarOption}
    Click Element    ${UsersSidebarOption}
    Wait Until Element Is Visible    xpath=//h4[text()='Users']     ${Timeout}