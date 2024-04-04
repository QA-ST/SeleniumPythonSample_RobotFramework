*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Utils/Config/TestConfig.robot
Resource    ../../../PageObjects/LoginPage.robot
Resource    ../../../PageObjects/Header.robot
Resource    ../../../PageObjects/SettingsTab/UsersModule.robot
Variables   ../../../Utils/EnvironmentVariables.py
Variables   ../../../Resources/TestData/CommonTestData.py
Variables   ../../../Resources/TestData/SettingsTabTestData/UsersModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app   ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Test Cases ***
To verify MSS user is able to delete MSS user
    Given User enters username and password   ${MssUserUsername_Dev}  ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the settings button in the header
    And Search user     ${TestMssUserUsername}
    And Verify the user is present in the users list    ${TestMssUserUsername}    ${TestMssUserEmail}   ${Language_English}
    When Click the delete icon for the user    ${TestMssUserUsername}
    And Confirm the delete user verification popup
    Then Verify the users table is empty
    And User logout from the application