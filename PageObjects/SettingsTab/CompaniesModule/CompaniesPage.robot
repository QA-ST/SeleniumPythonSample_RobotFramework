*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Helpers/CommonMethods.robot
Variables   ../../../Resources/Locators/SettingsTab/CompaniesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Search for company
    [Arguments]     ${companyName}
    Wait for table page load spinner
    Wait Until Element Is Visible    ${SearchCompanyInputField}     ${Timeout}
    Input Text    ${SearchCompanyInputField}    ${companyName}
    Sleep    1
    Press Keys      ${SearchCompanyInputField}      RETURN
    Wait for table page load spinner

Verify the company is present in the companies table
    [Arguments]     ${companyName}
    ${companyNameStatus}    Set Variable    ''
    Wait for table page load spinner
    Sleep    1
    ${companiesNameLocator}     Get WebElements    xpath=//div[contains(@class,'table_container_body')]/div/div[3]/span
    FOR    ${companiesNamePresent}    IN    @{companiesNameLocator}
        ${companyNameText}      Get Text    ${companiesNamePresent}
        IF    '${companyNameText}' == '${companyName}'
            ${companyNameStatus}    Set Variable    ${True}
        END
    END
    Run Keyword If    ${companyNameStatus}
    ...    Log To Console    ${companyName} is present in the companies table
    ...  ELSE
    ...    Fail     ${companyName} not found in the companies table

Click the edit icon of the company
    [Arguments]     ${companyName}
    Wait for table page load spinner
    Sleep    1
    ${companiesNameLocator}     Get WebElements    xpath=//div[contains(@class,'table_container_body')]/div/div[3]/span
    FOR    ${companiesNamePresent}    IN    @{companiesNameLocator}
        ${companyNameText}      Get Text    ${companiesNamePresent}
        IF    '${companyNameText}' == '${companyName}'
            Wait Until Element Is Visible    ${CompanyEditIcon.replace('companyName', '${companyName}')}    ${Timeout}
            Click Element    ${CompanyEditIcon.replace('companyName', '${companyName}')}
            Wait Until Element Is Visible    xpath=//span[text()='Name']//following::span[1]    ${Timeout}
            Element Should Contain    xpath=//span[text()='Name']//following::span[1]    ${companyName}
            BREAK
        END
    END