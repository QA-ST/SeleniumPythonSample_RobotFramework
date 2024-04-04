*** Settings ***
Library     SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Main.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.MonitoringSystems.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/ViewRuleCollapseMenu.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py
Variables   ../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown      Destroy browser context

*** Variables ***
${testRuleName}     Test vendor profile
${addedRuleId}

*** Test Cases ***
To verify user is able to add vendor profile for a rule
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to Rules page from the hambuger menu
    And Click the Add Rule button
    And Enter Main details for the new rule added
    And Store Rule Id for the new rule
    And Click the Go to Monitoring systems link button
    And Enter the rule description    ${TestRuleDescription}
    And Add Wazuh ruleset for the rule    ${RulesetGroup_Rule}     ${TestRulesetGroupValue_Rule}
    And Save Rule information entered
    When Create new Vendor profile for rule    ${TestVendorProfileName}
    And Select vendor profile    ${TestVendorProfileName}
    And Add Wazuh ruleset for the rule    ${RulesetGroup_Match}    ${TestRulesetGroupValue_Match}
    And Save Rule information entered
    And Navigate back to Rules page
    And Reload Page
    And Search rule from the rules list    ${addedRuleId}
    And Click the view icon for the rule    ${testRuleName}
    And Verify the Main details of the rule    ${testRuleName}    ${RuleAttack}    ${DataSource}    ${EventType}    ${WazuhMonitoringSystem}
    And Click the Monitoring Systems button in view menu of rule
    And Verify the rule description of the rule    ${TestRuleDescription}
    And Verify wazuh integration and its ruleset in the monitoring system tab of view rule menu    ${Main_VendorProfile}    ${WazuhMonitoringSystem}     ${TestRulesetGroupValue_Rule}
    Then Verify the integration and ruleset of the new vendor added    ${TestVendorProfileName}    ${WazuhMonitoringSystem}    ${TestRulesetGroupValue_Match}
    And Click the cross icon of the view rule collapse menu

To verify user is able to delete rule vendor profile
    Given Click the edit icon for the rule    ${testRuleName}
    And Click the Go to Monitoring systems link button
    And Select vendor profile    ${TestVendorProfileName}
    When Delete vendor profile    ${TestVendorProfileName}
    And Navigate back to Rules page
    And Reload Page
    And Search rule from the rules list    ${addedRuleId}
    And Click the view icon for the rule    ${testRuleName}
    And Click the Monitoring Systems button in view menu of rule
    Then Verify the vendor profile is deleted from the rule
    And Click the cross icon of the view rule collapse menu
    And Click the delete icon for the rule    ${testRuleName}
    And Confirm the delete verfication popup
    And Verify the rules table is empty
    And User logout from the application

*** Keywords ***
Enter Main details for the new rule added
    Enter Identification details for the rule   ${testRuleName}      ${RuleAttack}   ${RuleLanguage}
    Enter Data source details for the rule  ${DataSource}   ${EventType}
    Select Integration for the rule     ${WazuhMonitoringSystem}
    Select Wazuh Relation Id for integration selected     ${Wazuh004_RelationId}
    Select Wazuh Relation Id for integration selected     ${Wazuh009_RelationId}
    Reload Page
    Remove Relation Id from Rule    ${Wazuh004_RelationId}
    Remove Relation Id from Rule    ${Wazuh009_RelationId}
    Verify the selected integration relation block is empty

Store Rule Id for the new rule
    ${ruleIdValue}   Fetch the Rule Id
    VAR     ${addedRuleId}      ${ruleIdValue}      scope=SUITE

Verify the Main details of the rule
    [Arguments]     ${ruleName}     ${ruleAttack}   ${dataSource}   ${eventType}    ${integration}
    ${ruleDetailsParam}     Set Variable    xpath=(//span[text()='Main'])[2]//following::span[text()='ruleParam'][1]//following::span[1]
    ${ruleDataSourceDetail}    Set Variable    xpath=(//span[text()='Main'])[2]//following::span[text()='Data source'][2]//following::span[1]
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Name')}   ${Timeout}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Name')}    ${ruleName}
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Attack')}   ${Timeout}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Attack')}    ${ruleAttack}
    Wait Until Element Is Visible    ${ruleDataSourceDetail}   ${Timeout}
    Element Should Contain    ${ruleDataSourceDetail}    ${dataSource}
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Event Type')}   ${Timeout}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Event Type')}    ${eventType}
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Integrations')}   ${Timeout}
    Scroll Element Into View    ${ruleDetailsParam.replace('ruleParam', 'Integrations')}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Integrations')}    ${integration}

Verify the rule description of the rule
    [Arguments]     ${ruleDescription}
    Wait Until Element Is Visible    xpath=//span[text()='Description']//following::span[1]     ${Timeout}
    Element Should Contain    xpath=//span[text()='Description']//following::span[1]    ${ruleDescription}

Verify the integration and ruleset of the new vendor added
    [Arguments]     ${vendorProfile}      ${integration}      ${rulesetGroupValue}
    Select vendor profile in the view rule collapse menu    ${vendorProfile}
    Verify wazuh integration and its ruleset in the monitoring system tab of view rule menu     ${vendorProfile}    ${integration}    ${rulesetGroupValue}

Verify the vendor profile is deleted from the rule
    Wait Until Element Is Visible    xpath=//span[text()='Description']//following::span[1]     ${Timeout}
    ${vendorProfileStatus}      Run Keyword And Return Status    Wait Until Element Is Not Visible    ${SelectVendorProfileButton_ViewRuleMenu}      10
    IF    ${vendorProfileStatus}
        Log To Console    Vendor profile is deleted
    ELSE
        Fail    Vendor profile is not deleted
    END