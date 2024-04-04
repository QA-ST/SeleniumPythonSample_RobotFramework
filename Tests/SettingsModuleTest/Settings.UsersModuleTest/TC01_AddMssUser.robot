*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Utils/Config/TestConfig.robot
Resource    ../../../PageObjects/LoginPage.robot
Resource    ../../../PageObjects/Header.robot
Resource    ../../../PageObjects/SettingsTab/UsersModule.robot
Variables   ../../../Utils/EnvironmentVariables.py
Variables   ../../../Resources/TestData/SettingsTabTestData/UsersModuleTestData.py
Variables   ../../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app   ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Test Cases ***
To verify MSS user is able to add MSS user
    Given User enters username and password   ${MssUserUsername_Dev}  ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the settings button in the header
    When Click the add user button
    And Activate the user
    And Enter the name of the user    ${TestUserFirstName}    ${TestMssUserLastName}
    And Enter the user email    ${TestMssUserEmail}
    And Enter the user phone number    ${TestUserPhone}
    And Select user language and timezone    ${Language_English}    ${UserTimezone}
    And Click the cancel button for the unsaved changes
    And Select user role    ${MssUserRole_SystemAdministrator}
    And Save the new user details entered
    And Navigate back to the users list page
    And Search user    ${TestMssUserUsername}
    Then Verify the user is present in the users list    ${TestMssUserUsername}     ${TestMssUserEmail}     ${Language_English}
    And Verify the user is active    ${TestMssUserUsername}
    And User logout from the application