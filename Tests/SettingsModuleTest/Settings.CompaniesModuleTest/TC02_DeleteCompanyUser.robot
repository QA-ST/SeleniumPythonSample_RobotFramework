*** Settings ***
Library     SeleniumLibrary
Resource    ../../../PageObjects/LoginPage.robot
Resource    ../../../PageObjects/Header.robot
Resource    ../../../Utils/Config/TestConfig.robot
Resource    ../../../PageObjects/SettingsTab/UsersModule.robot
Resource    ../../../PageObjects/SettingsTab/SettingsTab.Sidebar.robot
Resource    ../../../PageObjects/SettingsTab/CompaniesModule/CompaniesPage.robot
Resource    ../../../PageObjects/SettingsTab/CompaniesModule/CompanyDetailsPage.robot
Variables   ../../../Utils/EnvironmentVariables.py
Variables   ../../../Resources/TestData/CommonTestData.py
Variables   ../../../Resources/TestData/SettingsTabTestData/UsersModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app   ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Test Cases ***
To verify Mss user is able to delete Company user
    Given User enters username and password   ${MssUserUsername_Dev}  ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the settings button in the header
    And Click the settings tab sidebar hamburger menu option
    And Navigate to the companies page from the settings hamburger menu
    And Search for company  ${DiazeroCompany_Company}
    And Verify the company is present in the companies table    ${DiazeroCompany_Company}
    And Click the edit icon of the company    ${DiazeroCompany_Company}
    And Navigate to the Users section from the sidebar
    And Search user     ${TestCompanyUserUsername}
    And Verify the user is present in the users list    ${TestCompanyUserUsername}    ${TestCompanyUserEmail}   ${Language_English}
    When Click the delete icon for the user    ${TestCompanyUserUsername}
    And Confirm the delete user verification popup
    Then Verify the users table is empty
    And User logout from the application