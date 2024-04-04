*** Settings ***
Library     SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListPage.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListDetailsPage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Main.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Companies.robot
Resource    ../../PageObjects/Header.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Utils/TestConfigData.py
Variables   ../../Resources/TestData/ResponseTabTestData/BlackWhiteListModuleTestData.py
Variables   ../../Resources/TestData/CommonTestData.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Variables ***
${addedRuleId}

*** Test Cases ***
To verify user is able to add a new Black list
    Given User enters username and password   ${MssUserUsername_Dev}  ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to the Black White list page from the hamburger menu
    When Click the Add Black list option
    And Enter the identification details for the black list    ${TestBlackListName}    ${TestBlackListDescription}
    And Save black/white list details
    And Verify the details of the black list added    ${TestBlackListName}    ${TestBlackListDescription}
    And Navigate back to the Black/White list page
    And Search for black/white list    ${TestBlackListName}
    Then Verify the black/white list is present in the list table    ${TestBlackListName}   ${TestBlackListDescription}
    And Navigate to Rules page from the hambuger menu
    And Add rule to test black list
    And Verify the black list is reflected in the rules page    ${DiazeroCompany_Company}   ${TestBlackListName}
    And Reload Page

To verify user is able to edit black list
    Given Click the response tab sidebar hamburger option
    And Navigate to the Black White list page from the hamburger menu
    And Search for black/white list    ${TestBlackListName}
    And Verify the black/white list is present in the list table    ${TestBlackListName}    ${TestBlackListDescription}
    When Click the edit icon of the black/white list    ${TestBlackListName}
    And Verify the details of the black list added    ${TestBlackListName}    ${TestBlackListDescription}
    And Enter the name of the list    ${TestBlackListNameEdited}
    And Enter the description of the list    ${TestBlackListDescriptionEdited}
    And Save the details updated for the black/white list
    And Navigate back to the Black/White list page
    And Search for black/white list    ${TestBlackListNameEdited}
    Then Verify the black/white list is present in the list table    ${TestBlackListNameEdited}     ${TestBlackListDescriptionEdited}
    And Navigate to Rules page from the hambuger menu
    And Search rule
    And Click the edit icon for the rule    ${RuleToTestBlackWhiteList}
    And Verify the black list is reflected in the rules page    ${DiazeroCompany_Company}    ${TestBlackListNameEdited}
    And Delete the rule
    And User logout from the application

*** Keywords ***
Verify the details of the black list added
    [Arguments]     ${listName}     ${listDescription}
    Wait Until Element Is Visible    xpath=//h4[text()='${listName}']
    Element Should Contain    xpath=//h4    ${listName}
    Wait Until Element Is Visible    ${ListNameInputField}  ${Timeout}
    ${listNameAdded}    Get Element Attribute    ${ListNameInputField}    value
    Should Be Equal    ${listNameAdded}    ${listName}
    ${listDescriptionAdded}     Get Element Attribute    ${ListDescriptionInputField}    value
    Should Be Equal    ${listDescriptionAdded}    ${listDescription}

Store Rule Id for the new rule
    ${ruleIdValue}   Fetch the Rule Id
    VAR     ${addedRuleId}      ${ruleIdValue}      scope=SUITE

Add rule to test black list
    Click the Add Rule button
    Store Rule Id for the new rule
    Enter the name of the rule    ${RuleToTestBlackWhiteList}
    Select Integration for the rule    ${WazuhMonitoringSystem}
    Select Wazuh Relation Id for integration selected    ${Wazuh001_RelationId}
    Select Wazuh Relation Id for integration selected    ${Wazuh002_RelationId}
    Reload Page
    Remove Relation Id from Rule    ${Wazuh001_RelationId}
    Remove Relation Id from Rule    ${Wazuh002_RelationId}

Search rule
    Search rule from the rules list    ${addedRuleId}
    Verify the Rule is present in the list of rules    ${RuleToTestBlackWhiteList}

Verify the black list is reflected in the rules page
    [Arguments]     ${companyName}  ${blackListName}
    Navigate to Companies tab
    Select Company for the rule     ${companyName}
    Select Black list for the rule    ${companyName}    ${blackListName}
    Scroll Element Into View    ${NavigateBackToRulesPage}
    Wait Until Element Is Visible    ${NavigateBackToRulesPage}  ${Timeout}
    Sleep    1
    Click Element    ${NavigateBackToRulesPage}
    Regect the unsaved changes popup for rule

Delete the rule
    Search rule
    Click the delete icon for the rule    ${RuleToTestBlackWhiteList}
    Confirm the delete verfication popup
    Verify the rules table is empty