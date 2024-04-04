*** Settings ***
Library  SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Main.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.RuleDetails.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/ViewRuleCollapseMenu.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown      Destroy browser context

*** Test Cases ***
To verify user is able to Edit rule
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to Rules page from the hambuger menu
    And Navigate to the last set of rules through pagination
    And Verify the Rule is present in the list of rules    ${TestingRuleName}
    When Click the edit icon for the rule  ${TestingRuleName}
    And Enter the name of the rule    ${TestingRuleNameEdited}
    And Remove Relation Id from Rule    ${Wazuh005_RelationId}
    And Remove Relation Id from Rule    ${Wazuh007_RelationId}
    And Verify the selected integration relation block is empty
    And Navigate to Rule Details page from side menu option
    And Remove grouping from the rule   ${SourceIpGrouping}
    And Select grouping for the rule    ${DestinationIpGrouping}
    And Save Rule information entered
    And Navigate back to Rules page
    And Reload Page
    And Navigate to the last set of rules through pagination
    Then Verify the Rule is present in the list of rules    ${TestingRuleNameEdited}

Verify the details edited of the rule from the view rule collapse menu
    When Click the view icon for the rule    ${TestingRuleNameEdited}
    Then Verify the main details of the rule    ${TestingRuleNameEdited}
    And Verify that no integration relation ids is selected in the view rule collapse menu    ${TestingRuleNameEdited}
    And Click the Rule Details button in view menu of rule
    And Verify the grouping selected in the view rule collapse menu     ${TestingRuleNameEdited}   ${DestinationIpVerifyRuleMenu}
    And Click the cross icon of the view rule collapse menu
    And User logout from the application

*** Keywords ***
Verify the main details of the rule
    [Arguments]     ${ruleName}
    ${ruleDetailsParam}     Set Variable    xpath=(//span[text()='Main'])[2]//following::span[text()='ruleParam'][1]//following::span[1]
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Name')}   ${Timeout}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Name')}    ${ruleName}