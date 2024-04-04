*** Settings ***
Library     SeleniumLibrary
Variables   ../Resources/Locators/LoginPageLocators.py
Variables   ../Utils/TestConfigData.py

*** Keywords ***
User enters username and password
    [Arguments]     ${username}     ${password}
    Wait Until Element Is Visible    ${UsernameInputField}     ${Timeout}
    Input Text    ${UsernameInputField}    ${username}
    Wait Until Page Contains Element    ${PasswordInputField}
    Input Text    ${PasswordInputField}    ${password}

User clicks the Login button
    Wait Until Element Is Visible    ${LoginButton}     ${Timeout}
    Click Element    ${LoginButton}