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
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Utils/TestConfigData.py
Variables   ../../Resources/TestData/ResponseTabTestData/BlackWhiteListModuleTestData.py
Variables   ../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Test Cases ***
To verify user is able to edit white list details
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to the Black White list page from the hamburger menu
    And Switch to the White list tab
    And Search for black/white list    ${TestWhiteListName}
    And Verify the black/white list is present in the list table    ${TestWhiteListName}    ${TestWhiteListDescription}
    When Click the edit icon of the black/white list    ${TestWhiteListName}
    And Enter the name of the list    ${TestWhiteListNameEdited}
    And Enter the description of the list    ${TestWhiteListDescriptionEdited}
    And Save the details updated for the black/white list
    And Navigate back to the Black/White list page
    And Switch to the White list tab
    And Search for black/white list    ${TestWhiteListNameEdited}
    Then Verify the black/white list is present in the list table    ${TestWhiteListNameEdited}     ${TestWhiteListDescriptionEdited}

To verify the edited white list is displayed in the companies section of the rule
    Given Navigate to Rules page from the hambuger menu
    And Navigate to the last set of rules through pagination
    And Verify the Rule is present in the list of rules    ${RuleToTestBlackWhiteList}
    And Click the edit icon for the rule    ${RuleToTestBlackWhiteList}
    And Navigate to Companies tab
    And Select Company for the rule     ${DiazeroCompany_Company}
    When Select White list for the rule    ${DiazeroCompany_Company}    ${TestWhiteListNameEdited}
    Then Verify the white list is selected in the rule    ${TestWhiteListNameEdited}
    And Delete the rule created to test white list
    And User logout from the application

*** Keywords ***
Verify the white list is selected in the rule
    [Arguments]     ${whiteList}
    Wait Until Element Is Visible    xpath=(//label[@name='whiteList']//following::div[contains(@class,'dz_input-select')][1]//div[contains(@class,'text-dark-high-emphasis')])[2]  ${Timeout}
    ${whiteListSelected}    Get Text    xpath=(//label[@name='whiteList']//following::div[contains(@class,'dz_input-select')][1]//div[contains(@class,'text-dark-high-emphasis')])[2]
    Run Keyword If    '${whiteListSelected}' == '${whiteList}'
    ...    Log To Console    ${whiteList} is displayed in the companies section of the rule
    ...  ELSE
    ...    Fail    ${whiteList} not found in the companies section of the rule

Delete the rule created to test white list
    Scroll Element Into View    ${NavigateBackToRulesPage}
    Wait Until Element Is Visible    ${NavigateBackToRulesPage}  ${Timeout}
    Click Element    ${NavigateBackToRulesPage}
    Regect the unsaved changes popup for rule
    Navigate to the last set of rules through pagination
    Verify the Rule is present in the list of rules    ${RuleToTestBlackWhiteList}
    Click the delete icon for the rule     ${RuleToTestBlackWhiteList}
    Confirm the delete verfication popup
    Reload Page
    Verify the Rule is not present in the list of rules    ${RuleToTestBlackWhiteList}