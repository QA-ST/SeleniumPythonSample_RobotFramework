*** Settings ***
Library     SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListPage.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListDetailsPage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Companies.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Main.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Utils/TestConfigData.py
Variables   ../../Resources/TestData/ResponseTabTestData/BlackWhiteListModuleTestData.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py
Variables   ../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Test Cases ***
To verify user is able to add new White list
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to the Black White list page from the hamburger menu
    When Click the Add White list option
    And Enter the identification details for the white list    ${TestWhiteListName}    ${TestWhiteListDescription}
    And Save black/white list details
    And Verify the details of the white list added    ${TestWhiteListName}    ${TestWhiteListDescription}
    And Navigate back to the Black/White list page
    And Switch to the White list tab
    And Search for black/white list    ${TestWhiteListName}
    Then Verify the black/white list is present in the list table    ${TestWhiteListName}   ${TestWhiteListDescription}

To verify the white list is displayed in the companies section of the rule
    Given Navigate to Rules page from the hambuger menu
    And Add rule to test white list created is reflected
    And Navigate to Companies tab
    And Select Company for the rule     ${DiazeroCompany_Company}
    When Select White list for the rule    ${DiazeroCompany_Company}    ${TestWhiteListName}
    And User logout from the application

*** Keywords ***
Verify the details of the white list added
    [Arguments]     ${listName}     ${listDescription}
    Wait Until Element Is Visible    xpath=//h4[text()='${listName}']
    Element Should Contain    xpath=//h4    ${listName}
    Wait Until Element Is Visible    ${ListNameInputField}  ${Timeout}
    ${listNameAdded}    Get Element Attribute    ${ListNameInputField}    value
    Should Be Equal    ${listNameAdded}    ${listName}
    ${listDescriptionAdded}     Get Element Attribute    ${ListDescriptionInputField}    value
    Should Be Equal    ${listDescriptionAdded}    ${listDescription}

Add rule to test white list created is reflected
    Click the Add Rule button
    Enter the name of the rule      ${RuleToTestBlackWhiteList}
    Select Integration for the rule    ${WazuhMonitoringSystem}
    Select Wazuh Relation Id for integration selected    ${Wazuh001_RelationId}
    Select Wazuh Relation Id for integration selected    ${Wazuh002_RelationId}
    Reload Page
    Remove Relation Id from Rule    ${Wazuh001_RelationId}
    Remove Relation Id from Rule    ${Wazuh002_RelationId}