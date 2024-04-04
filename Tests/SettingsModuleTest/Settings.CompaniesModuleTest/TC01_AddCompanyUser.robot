*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Utils/Config/TestConfig.robot
Resource    ../../../PageObjects/LoginPage.robot
Resource    ../../../PageObjects/Header.robot
Resource    ../../../PageObjects/SettingsTab/SettingsTab.Sidebar.robot
Resource    ../../../PageObjects/SettingsTab/CompaniesModule/CompaniesPage.robot
Resource    ../../../PageObjects/SettingsTab/CompaniesModule/CompanyDetailsPage.robot
Resource    ../../../PageObjects/SettingsTab/UsersModule.robot
Variables   ../../../Utils/EnvironmentVariables.py
Variables   ../../../Resources/TestData/CommonTestData.py
Variables   ../../../Resources/TestData/SettingsTabTestData/UsersModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app   ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Test Cases ***
To verify MSS user is able to Company user
    Given User enters username and password   ${MssUserUsername_Dev}  ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the settings button in the header
    And Click the settings tab sidebar hamburger menu option
    And Navigate to the companies page from the settings hamburger menu
    And Search for company  ${DiazeroCompany_Company}
    And Verify the company is present in the companies table    ${DiazeroCompany_Company}
    And Click the edit icon of the company    ${DiazeroCompany_Company}
    And Navigate to the Users section from the sidebar
    When Click the add user button
    And Enter the name of the user    ${TestUserFirstName}    ${TestCompanyUserLastName}
    And Enter the user email    ${TestCompanyUserEmail}
    And Enter the user phone number    ${TestUserPhone}
    And Select user language and timezone    ${Language_English}    ${UserTimezone}
    And Click the cancel button for the unsaved changes
    And Select user role    ${CompanyUserRole_CompanyAnalyst}
    And Save the new user details entered
    And Navigate back to the users list page
    And Search user    ${TestCompanyUserUsername}
    Then Verify the user is present in the users list    ${TestCompanyUserUsername}     ${TestCompanyUserEmail}     ${Language_English}
    And Verify the user is active    ${TestCompanyUserUsername}
    And User logout from the application

