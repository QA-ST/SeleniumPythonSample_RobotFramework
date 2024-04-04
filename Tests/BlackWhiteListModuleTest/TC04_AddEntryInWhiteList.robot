*** Settings ***
Library     SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListPage.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListDetailsPage.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/BlackWhiteListModuleTestData.py
Variables   ../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Variables ***
${addedFieldQueryOrder}

*** Test Cases ***
To verify user is able to add entry in the white list
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to the Black White list page from the hamburger menu
    And Add white list
    When Click the add entry button
    And Enter the name of the black/white list entry    ${TestWhiteListEntryName}
    And Select the monitoring system for the black/white list    ${WazuhMonitoringSystem}
    And Check the check all checkbox
    And Enter field query and its value with regex enabled    1    ${TestListFieldQuery}    ${TestListFieldQueryValue}
    And Set the list conditional field value    2    ${ListConditionFieldValue_And}
    And Enter field query and its value with regex enabled    3    ${TestListFieldQuery2}    ${TestListFieldQueryValue2}
    And Add field in the list    ${ConditionFieldType}
    And Set the list conditional field value    ${addedFieldQueryOrder}    ${ListConditionFieldValue_Or}
    And Add field in the list    ${RowFieldType}
    And Enter field query and its value with regex enabled    ${addedFieldQueryOrder}   ${TestListFieldQuery}    ${TestListFieldQueryValue}
    And Save the entry for the black/white list
    And Reload Page
    And Search the entry in the black/white list    ${TestWhiteListEntryName}
    Then Verify the black/white list entry is present    ${TestWhiteListEntryName}
    And User logout from the application
    
*** Keywords ***
Add white list
    Click the Add White list option
    Enter the identification details for the white list    ${TestWhiteListEntry_List}    ${TestWhiteListDescription}
    Save black/white list details
    Wait Until Element Is Visible    xpath=//h4[text()='${TestWhiteListEntry_List}']
    Element Should Contain    xpath=//h4    ${TestWhiteListEntry_List}
    Wait Until Element Is Visible    ${ListNameInputField}  ${Timeout}
    ${listNameAdded}    Get Element Attribute    ${ListNameInputField}    value
    Should Be Equal    ${listNameAdded}    ${TestWhiteListEntry_List}
    ${listDescriptionAdded}     Get Element Attribute    ${ListDescriptionInputField}    value
    Should Be Equal    ${listDescriptionAdded}    ${TestWhiteListDescription}

Add field in the list
    [Arguments]     ${fieldType}
    ${fieldQueryOrder}      Add field in the black/white list entry    ${fieldType}
    VAR     ${addedFieldQueryOrder}     ${fieldQueryOrder}      scope=SUITE