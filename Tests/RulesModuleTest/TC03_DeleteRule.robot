*** Settings ***
Library  SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown      Destroy browser context

*** Test Cases ***
To verify user is able to delete rule
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to Rules page from the hambuger menu
    And Navigate to the last set of rules through pagination
    And Verify the Rule is present in the list of rules    ${TestingRuleNameEdited}
    When Click the delete icon for the rule     ${TestingRuleNameEdited}
    And Confirm the delete verfication popup
    And Reload Page
    And Navigate to the last set of rules through pagination
    Then Verify the Rule is not present in the list of rules    ${TestingRuleNameEdited}
    And User logout from the application