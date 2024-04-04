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
Variables   ../../../Resources/TestData/CommonTestData.py
Variables   ../../../Utils/EnvironmentVariables.py
Variables   ../../../Resources/TestData/SettingsTabTestData/RelationsModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Variables ***
${addedRuleId}

*** Test Cases ***
To verify user is able to delete vendor relation
    Given User enters username and password   ${MssUserUsername_Dev}      ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the settings button in the header
    And Click the settings tab sidebar hamburger menu option
    And Navigate to the relations page from the settings hamburger menu
    And Click the edit icon for the vendor   ${WazuhMonitoringSystem}
    And Search the vendor relation    ${TestRelationAlertId}
    And Verify the vendor relation is present    ${TestRelationAlertId}
    When Click the delete icon of the vendor relation    ${TestRelationAlertId}
    And Confirm the delete vendor relation popup
    And Search the vendor relation    ${TestRelationAlertId}
    Then Verify the vendor relation is not found in the relations list    ${TestRelationAlertId}
    And Click the response button in the header
    And Navigate to Rules page from the hambuger menu
    And Verify the relation deleted is not reflected in the rules module
    And Delete the rule
    And User logout from the application

*** Keywords ***
Store Rule Id for the new rule
    ${ruleIdValue}   Fetch the Rule Id
    VAR     ${addedRuleId}      ${ruleIdValue}      scope=SUITE

Verify the relation deleted is not reflected in the rules module
    Click the Add Rule button
    Store Rule Id for the new rule
    Select Integration for the rule     ${WazuhMonitoringSystem}
    Wait Until Page Contains Element    ${SearchRelationInputField}     ${Timeout}
    Sleep    1
    Input Text    ${SearchRelationInputField}    ${EMPTY}
    Input Text    ${SearchRelationInputField}    ${TestRelationAlertId}
    Verify the unselected integration relation block is empty
    Scroll Element Into View    ${NavigateBackToRulesPage}
    Wait Until Element Is Visible    ${NavigateBackToRulesPage}  ${Timeout}
    Click Element    ${NavigateBackToRulesPage}
    Regect the unsaved changes popup for rule

Delete the rule
    Search rule from the rules list    ${addedRuleId}
    Sleep    1
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'table_container_body')])[1]//button[3]   ${Timeout}
    Click Element    xpath=(//div[contains(@class,'table_container_body')])[1]//button[3]
    Confirm the delete verfication popup
    Verify the rules table is empty