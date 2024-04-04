*** Settings ***
Library     SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/Header.robot
Resource    ../../PageObjects/SettingsTab/SettingsTab.Sidebar.robot
Resource    ../../PageObjects/SettingsTab/CompaniesModule/CompaniesPage.robot
Resource    ../../PageObjects/SettingsTab/CompaniesModule/CompanyDetailsPage.robot
Resource    ../../PageObjects/SettingsTab/CompaniesModule/Companies.MonitoringSystem.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/SettingsTabTestData/CompaniesModuleTestData.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py
Variables   ../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app   ${DevUrl}    ${ChromeBrowser}
Suite Teardown      Destroy browser context

*** Test Cases ***
To verify user is able to add Monitoring system for a company in the settings tab
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the settings button in the header
    And Click the settings tab sidebar hamburger menu option
    And Navigate to the companies page from the settings hamburger menu
    And Search for company      ${DiazeroCompany_Company}
    And Verify the company is present in the companies table    ${DiazeroCompany_Company}
    And Click the edit icon of the company    ${DiazeroCompany_Company}
    And Navigate to the Monitoring system section from the sidebar
    When Click the Add SIEM button
    And Enter the name of the monitoring system    ${TestMonitoringSystemName}
    And Enter the description of the monitoring system    ${TestMonitoringSystemDescription}
    And Select the vendor for the monitoring system    ${WazuhMonitoringSystem}
    And Enter the details for the wazuh integration
    And Save the monitoring system details
    Then Verify the monitoring system is present in the list
    And Click the delete icon for the monitoring system    ${TestMonitoringSystemName}
    And Confirm the delete monitoring system popup
    And User logout from the application

*** Keywords ***
Enter the details for the wazuh integration
    Enter the host for the integration    001    002    003    004
    Enter the port for the integration    1080
    Enter the index value for the integration    1
    Enter the scheme for the integration    Test scheme
    Enter the password for the integration    ${MssUserPassword}
    Enter the username for the integration    ${MssUserUsername}
    Enter the rule path for the integration    TestRulePath
    Enter the timestamp for the integration    Test timestamp

Verify the monitoring system is present in the list
    Search for company      ${DiazeroCompany_Company}
    Verify the company is present in the companies table    ${DiazeroCompany_Company}
    Click the edit icon of the company    ${DiazeroCompany_Company}
    Navigate to the Monitoring system section from the sidebar
    Verify the monitoring system is present    ${TestMonitoringSystemName}