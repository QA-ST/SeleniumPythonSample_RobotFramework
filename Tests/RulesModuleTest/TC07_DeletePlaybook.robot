*** Settings ***
Library  SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Playbooks.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown      Destroy browser context

*** Test Cases ***
To verify user is able to delete playbook
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to Rules page from the hambuger menu
    And Verify the Rule is present in the list of rules    ${RuleNameToTestPlaybook}
    And Click the edit icon for the rule    ${RuleNameToTestPlaybook}
    And Navigate to Playbooks page from side menu option
    And Search playbook from the list    ${TestPlaybookNameEdited}
    And Verify the playbook is present in the playbooks list    ${TestPlaybookNameEdited}
    When Click the delete icon for the playbook    ${TestPlaybookNameEdited}
    And Confirm the delete playbook popup
    And Search playbook from the list    ${TestPlaybookNameEdited}
    Then Verify the playbook table is empty
    And Delete the rule created to test playbook
    And User logout from the application

*** Keywords ***
Delete the rule created to test playbook
    Navigate back to Rules page
    Verify the Rule is present in the list of rules    ${RuleNameToTestPlaybook}
    Click the delete icon for the rule     ${RuleNameToTestPlaybook}
    Confirm the delete verfication popup
    Reload Page
    Verify the Rule is not present in the list of rules    ${RuleNameToTestPlaybook}