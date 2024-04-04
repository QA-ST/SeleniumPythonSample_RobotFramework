*** Settings ***
Library     SeleniumLibrary

Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListPage.robot
Resource    ../../PageObjects/ResponseTab/BlackWhiteListModule/BlackWhiteListDetailsPage.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/BlackWhiteListModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app   ${DevUrl}   ${ChromeBrowser}
Suite Teardown  Destroy browser context

*** Test Cases ***
To verify user is able to delete black list
    Given User enters username and password   ${MssUserUsername_Dev}  ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to the Black White list page from the hamburger menu
    And Search for black/white list     ${TestBlackListNameEdited}
    And Verify the black/white list is present in the list table    ${TestBlackListNameEdited}    ${TestBlackListDescriptionEdited}
    When Click the delete icon of the black/white list    ${TestBlackListNameEdited}
    And Confirm the delete black/white list popup
    And Search for black/white list    ${TestBlackListNameEdited}
    Then Verify the black/white list table is empty
    And User logout from the application