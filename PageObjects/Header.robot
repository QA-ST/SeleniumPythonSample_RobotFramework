*** Settings ***
Library     SeleniumLibrary
Variables   ../Utils/TestConfigData.py
Variables   ../Resources/Locators/CommonLocators.py

*** Keywords ***
Click the settings button in the header
    Wait Until Element Is Visible    ${SettingsButton}      ${Timeout}
    Click Element    ${SettingsButton}
    Wait Until Element Is Visible    xpath=//h4[text()='Users']     ${Timeout}

Click the response button in the header
    Wait Until Element Is Visible    ${ResponseButton}      ${Timeout}
    Click Element    ${ResponseButton}
    Wait Until Element Is Visible    xpath=//h3[text()='Operational Dashboard']     ${Timeout}