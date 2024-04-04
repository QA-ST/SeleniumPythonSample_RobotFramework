*** Settings ***
Library     SeleniumLibrary
Variables   ../Utils/TestConfigData.py
Variables   ../Resources/Locators/CommonLocators.py

*** Keywords ***
Wait for table page load spinner
    Wait Until Element Is Not Visible    ${PageLoadSpinner}     ${Timeout}
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'dz_table_container')])[1]//following::div[@class='relative']     ${Timeout}

Click the cancel button for the unsaved changes
    Wait Until Element Is Visible    ${CancelButton}    ${Timeout}
    Click Element    ${CancelButton}

Click the search icon for the search performed
    Wait Until Element Is Visible    ${SearchIcon}  ${Timeout}
    Sleep    1
    Click Element    ${SearchIcon}