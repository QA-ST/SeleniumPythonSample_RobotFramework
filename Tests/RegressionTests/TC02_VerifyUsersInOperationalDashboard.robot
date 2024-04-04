*** Settings ***
Library     SeleniumLibrary
Library    Collections
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/Header.robot
Resource    ../../Helpers/CommonMethods.robot
Variables   ../../Utils/EnvironmentVariables.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Variables ***
@{usersList}
@{usersOperationalDashboard}

*** Test Cases ***
To verify the users displayed in the operational dashboard match from the users list
    Given User enters username and password   ${MssUserUsername_Dev}      ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the settings button in the header
    When Fetch the name of the users from the users table
    And Click the response button in the header
    And Fetch the name of the users displayed in the operational dashboard
    Then Verify the users match in the users list and operational dashboard
    And User logout from the application

*** Keywords ***
Fetch the name of the users from the users table
    Wait for table page load spinner
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'table_container_body')])[1]      ${Timeout}
    Sleep    1
    ${usersListLocator}    Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]//div[contains(@class,'body_item')][2]/span
    FOR    ${userName}    IN    @{usersListLocator}
        ${userNameText}     Get Text    ${userName}
        IF    '${userNameText}' != ''
           Append To List  ${usersList}    ${userNameText}
        ELSE
           Fail     User name is empty
        END
    END

Fetch the name of the users displayed in the operational dashboard
    Wait Until Element Is Visible    xpath=//section/div/span[text()='Analyst By Availability']     ${Timeout}
    Scroll Element Into View    xpath=//section/div/span[text()='Analyst By Availability']
    Sleep    1
    ${usersListLocator}     Get WebElements    xpath=//div/span[text()='Analyst By Availability']//following::ul/li/span
    FOR    ${userName}    IN    @{usersListLocator}
        ${userNameText}     Get Text    ${userName}
        IF    '${userNameText}' != ''
           Append To List  ${usersOperationalDashboard}    ${userNameText}
        ELSE
           Fail     User name is empty
        END
    END

Verify the users match in the users list and operational dashboard
    ${userStatus}   Set Variable    ''
    FOR    ${userOperationalDashboard}    IN    @{usersOperationalDashboard}
        FOR    ${user}    IN    @{usersList}
            IF    '${user}' == '${userOperationalDashboard}'
                Log To Console    ${userOperationalDashboard} is present in the users list
                ${userStatus}   Set Variable    ${True}
                BREAK
            END
        END
    END