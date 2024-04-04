*** Settings ***
Library     SeleniumLibrary
Variables   ../../Utils/TestConfigData.py
Variables   ../../Resources/Locators/CommonLocators.py

*** Keywords ***
Setup browser context and Navigate to the web app
    [Arguments]     ${webAppUrl}    ${broswerName}
    Open Browser    ${webAppUrl}    ${broswerName}    options=add_argument("--user-agent=${UserAgent}"); add_argument("--window-size=1920,1080")
    ${navigatedAppUrl}   Get Location
    Should Be Equal As Strings    ${navigatedAppUrl}    ${webAppUrl}

Destroy browser context
    Close Browser

User logout from the application
    Wait Until Element Is Visible    ${UserProfileImage}    ${Timeout}
    Scroll Element Into View    ${UserProfileImage}
    Sleep    1
    Mouse Over    ${UserProfileImage}
    Wait Until Page Contains Element    xpath=//div[contains(@class,'group-hover:flex')]    ${Timeout}
    Sleep    2
    Wait Until Element Is Visible    ${LogoutButton}    ${Timeout}
    Click Element    ${LogoutButton}