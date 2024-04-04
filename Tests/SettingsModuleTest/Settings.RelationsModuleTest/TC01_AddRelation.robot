*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Utils/Config/TestConfig.robot
Resource    ../../../PageObjects/LoginPage.robot
Resource    ../../../PageObjects/Header.robot
Resource    ../../../PageObjects/SettingsTab/SettingsTab.Sidebar.robot
Resource    ../../../PageObjects/SettingsTab/RelationsModule.robot
Resource    ../../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Resource    ../../../PageObjects/ResponseTab/RulesModule/Rule.Main.robot
Resource    ../../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Variables   ../../../Utils/EnvironmentVariables.py
Variables   ../../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py
Variables   ../../../Resources/TestData/SettingsTabTestData/RelationsModuleTestData.py
Variables   ../../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Variables ***
${addedRuleId}

*** Test Cases ***
To verify MSS user is able to add relation in vendor
    Given User enters username and password   ${MssUserUsername_Dev}      ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the settings button in the header
    And Click the settings tab sidebar hamburger menu option
    And Navigate to the relations page from the settings hamburger menu
    And Click the edit icon for the vendor   ${WazuhMonitoringSystem}
    When Click the add relation button
    And Enter the alert id for the relation    ${TestRelationAlertId}
    And Save the vendor relation details
    And Navigate back to the vendor relation list page    ${WazuhMonitoringSystem}
    And Search the vendor relation    ${TestRelationAlertId}
    Then Verify the vendor relation is present    ${TestRelationAlertId}
    And Click the response button in the header
    And Navigate to Rules page from the hambuger menu
    And Click the Add Rule button
    And Verify the relation added is reflected in the rules

To verify the rule having the relation id selected is displayed in the relations table and relation situation status
    Given Navigate to the relations page
    When Verify the wazuh vendor relation is present
    Then Verify the rule having the vendor relation selected is displayed in the relations table    ${TestRelationAlertId}  ${addedRuleId}  ${RuleToTestRelation}
    And Verify the situation status of the wazuh vendor relation    ${TestRelationAlertId}    ${LinkedSituationStatus}
    And Unselect the vendor relation and delete the rule
    And Navigate to the relations page
    And Verify the wazuh vendor relation is present
    And Verify the rule having the vendor relation selected is displayed in the relations table    ${TestRelationAlertId}    ${EMPTY}    ${EMPTY}
    And Verify the situation status of the wazuh vendor relation    ${TestRelationAlertId}    ${PendingSituationStatus}
    And User logout from the application

*** Keywords ***
Store Rule Id for the new rule
    ${ruleIdValue}   Fetch the Rule Id
    VAR     ${addedRuleId}      ${ruleIdValue}      scope=SUITE

Verify the wazuh vendor relation is present
    Click the edit icon for the vendor      ${WazuhMonitoringSystem}
    Search the vendor relation    ${TestRelationAlertId}
    Verify the vendor relation is present    ${TestRelationAlertId}

Verify the relation added is reflected in the rules
    Store Rule Id for the new rule
    Enter Identification details for the rule   ${RuleToTestRelation}      ${RuleAttack}   ${RuleLanguage}
    Enter Data source details for the rule  ${DataSource}   ${EventType}
    Select Integration for the rule     ${WazuhMonitoringSystem}
    ${addedRelationStatus}  Run Keyword And Return Status    Select Wazuh Relation Id for integration selected    ${TestRelationAlertId}
    IF    ${addedRelationStatus}
        Log To Console    ${TestRelationAlertId} wazuh relation is reflected in the rules module
        Select Wazuh Relation Id for integration selected    ${Wazuh002_RelationId}
        Navigate back to Rules page
        Reload Page
        Verify rule is present
    ELSE
        Fail    ${TestRelationAlertId} wazuh relation not found
    END

Navigate to the relations page
    Click the settings button in the header
    Click the settings tab sidebar hamburger menu option
    Navigate to the relations page from the settings hamburger menu

Verify rule is present
    Search rule from the rules list    ${addedRuleId}
    Verify the Rule is present in the list of rules    ${RuleToTestRelation}

Unselect the vendor relation and delete the rule
    Click the response button in the header
    Navigate to Rules page from the hambuger menu
    Search rule from the rules list    ${addedRuleId}
    Verify the Rule is present in the list of rules    ${RuleToTestRelation}
    Click the edit icon for the rule    ${RuleToTestRelation}
    Remove Relation Id from Rule    ${Wazuh002_RelationId}
    Remove Relation Id from Rule    ${TestRelationAlertId}
    Navigate back to Rules page
    Reload Page
    Search rule from the rules list    ${addedRuleId}
    Verify the Rule is present in the list of rules    ${RuleToTestRelation}
    Click the delete icon for the rule    ${RuleToTestRelation}
    Confirm the delete verfication popup
    Reload Page
    Verify the rules table is empty