*** Settings ***
Library     SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListPage.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListDetailsPage.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListPage.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/BlackWhiteListModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Test Cases ***
To verify user is able to delete entry from the white list
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to the Black White list page from the hamburger menu
    And Switch to the White list tab
    And Search for black/white list    ${TestWhiteListEntry_List}
    And Verify the black/white list is present in the list table    ${TestWhiteListEntry_List}  ${TestWhiteListDescription}
    And Click the edit icon of the black/white list    ${TestWhiteListEntry_List}
    And Search the entry in the black/white list    ${TestWhiteListEntryName}
    And Verify the black/white list entry is present    ${TestWhiteListEntryName}
    When Click the delete icon for the black/white list entry    ${TestWhiteListEntryName}
    And Confirm the delete entry popup
    And Search the entry in the black/white list    ${TestWhiteListEntryName}
    Then Verify the entry is not present in the list entry table
    And Delete the white list created
    And User logout from the application
    
*** Keywords ***
Delete the white list created
    Navigate back to the Black/White list page
    Switch to the White list tab
    Search for black/white list    ${TestWhiteListEntry_List}
    Verify the black/white list is present in the list table    ${TestWhiteListEntry_List}  ${TestWhiteListDescription}
    Click the delete icon of the black/white list    ${TestWhiteListEntry_List}
    Confirm the delete black/white list popup
    Search for black/white list    ${TestWhiteListEntry_List}
    Verify the black/white list table is empty