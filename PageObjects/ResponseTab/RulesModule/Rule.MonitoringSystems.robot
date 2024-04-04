*** Settings ***
Library     SeleniumLibrary
Resource    RulePage.robot
Variables   ../../../Resources/Locators/ResponseTab/RulesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Enter the rule description
    [Arguments]     ${ruleDescription}
    Wait Until Element Is Visible    ${RuleDescriptionInputField}    ${Timeout}
    Clear Element Text    ${RuleDescriptionInputField}
    Input Text    ${RuleDescriptionInputField}    ${ruleDescription}

Set severity as Medium using CVSS calculator
    Wait Until Page Contains Element    ${CvssCalculatorButton}    ${Timeout}
    Click Element    ${CvssCalculatorButton}
    Wait Until Element Is Visible    ${CvssCalculatorTab}    ${Timeout}
    Wait Until Page Contains Element    ${LocalAttackVendorType}   ${Timeout}
    Sleep    1
    Click Element    ${LocalAttackVendorType}
    Wait Until Page Contains Element    ${HighAttackComplexity}   ${Timeout}
    Sleep    1
    Click Element    ${HighAttackComplexity}
    Wait Until Page Contains Element    ${LowPrivilegesRequired}   ${Timeout}
    Sleep    1
    Click Element    ${LowPrivilegesRequired}
    Scroll Element Into View    xpath=//h4[contains(text(),'CVSS')]//following::span[contains(text(),'Availability')]
    Wait Until Page Contains Element    ${HighConfidentiality}   ${Timeout}
    Sleep    1
    Click Element    ${HighConfidentiality}
    Save Rule information entered
    Wait Until Page Contains Element    ${CvssCalculatorTabCrossIcon}   ${Timeout}
    Sleep    2
    Click Element    ${CvssCalculatorTabCrossIcon}

Switch the Monitoring system selected for the rule
    [Arguments]     ${integration}
    Wait Until Page Contains Element    ${GoToRuleDetailsLinkBtn}   ${Timeout}
    Scroll Element Into View    ${GoToRuleDetailsLinkBtn}
    Sleep    1
    @{monitoringSystemsSelected}   Get WebElements    xpath=//span[text()='Vendors']//following::div//button//span[following::span[text()='Add Line']]
    FOR    ${monitoringSystemNames}    IN    @{monitoringSystemsSelected}
        Wait Until Element Is Visible    ${monitoringSystemNames}    ${Timeout}
        ${monitoringSystemNameText}     Get Text    ${monitoringSystemNames}
        IF    '${monitoringSystemNameText}' == '${integration}'
            Click Element    ${monitoringSystemNames}
            BREAK
        ELSE
            Fail    ${integration} not found
        END
    END

Add Wazuh ruleset for the rule
    [Arguments]     ${rulesetGroup}     ${rulesetValue}
    Wait Until Element Is Visible    ${AddRulesetButton}     ${Timeout}
    Click Element    ${AddRulesetButton}
    Wait Until Page Contains Element    ${RuleSetGroupDropdown}     ${Timeout}
    Input Text    ${RuleSetGroupDropdown}    ${rulesetGroup}
    Sleep    1
    Press Keys  ${RuleSetGroupDropdown}     RETURN
    Wait Until Element Is Visible    ${RulesetGroupValueInputField}     ${Timeout}
    Input Text    ${RulesetGroupValueInputField}    ${rulesetValue}

Create new Vendor profile for rule
    [Arguments]     ${vendorProfileName}
    Wait Until Page Contains Element    ${GoToRuleDetailsLinkBtn}   ${Timeout}
    Scroll Element Into View    ${GoToRuleDetailsLinkBtn}
    Wait Until Element Is Visible    ${AddVendorProfileButton}  ${Timeout}
    Click Element    ${AddVendorProfileButton}
    Wait Until Element Is Visible    ${VendorProfileNameInputField}     ${Timeout}
    Input Text    ${VendorProfileNameInputField}    ${vendorProfileName}
    Wait Until Element Is Visible    ${SaveNewVendorProfileButton}  ${Timeout}
    Click Element    ${SaveNewVendorProfileButton}

Select vendor profile
    [Arguments]     ${vendorProfileName}
    Wait Until Page Contains Element    ${GoToRuleDetailsLinkBtn}   ${Timeout}
    Scroll Element Into View    ${GoToRuleDetailsLinkBtn}
    Wait Until Element Is Visible    ${SelectVendorProfileDropdown}     ${Timeout}
    Click Element    ${SelectVendorProfileDropdown}
    Wait Until Element Is Visible    xpath=(//span[text()='Rule Profile'])[2]//following::div[2]    ${Timeout}
    Sleep    1
    @{vendorProfiles}   Get WebElements    xpath=(//span[text()='Rule Profile'])[2]//following::div[2]//span
    FOR    ${vendorProfileNamePresent}    IN    @{vendorProfiles}
        Wait Until Element Is Visible    ${vendorProfileNamePresent}    ${Timeout}
        ${vendorProfileNameText}    Get Text    ${vendorProfileNamePresent}
        IF    '${vendorProfileNameText}' == '${vendorProfileName}'
            Click Element    ${vendorProfileNamePresent}
            Wait Until Element Is Visible    ${SelectedVendorProfile.replace('vendorProfileName', '${vendorProfileName}')}      ${Timeout}
            ${vendorName}   Get Text    ${SelectedVendorProfile.replace('vendorProfileName', '${vendorProfileName}')}
            Should Contain    ${vendorName}    ${vendorProfileName}
            Sleep    2
            BREAK
        END
    END

Delete vendor profile
    [Arguments]     ${vendorProfileName}
    Wait Until Element Is Visible    ${SelectedVendorProfile.replace('vendorProfileName', '${vendorProfileName}')}      ${Timeout}
    ${vendorProfileStatus}  Run Keyword And Return Status    Element Should Contain    ${SelectedVendorProfile.replace('vendorProfileName', '${vendorProfileName}')}    ${vendorProfileName}
    IF    ${vendorProfileStatus}
        Wait Until Element Is Visible    ${DeleteVendorProfileButton.replace('vendorProfile', '${vendorProfileName}')}  ${Timeout}
        Click Element    ${DeleteVendorProfileButton.replace('vendorProfile', '${vendorProfileName}')}
        Confirm the delete vendor profile popup
    ELSE
        ${vendorProfileName} vendor profile not selected
    END

Confirm the delete vendor profile popup
    Wait Until Element Is Visible    xpath=//span[text()='Delete Vendor Profile']       ${Timeout}
    Wait Until Element Is Visible    xpath=//span[text()='Delete Vendor Profile']//following::button[contains(text(),'Delete')]     ${Timeout}
    Click Element    xpath=//span[text()='Delete Vendor Profile']//following::button[contains(text(),'Delete')]
    Wait Until Element Is Visible    xpath=//div//span[contains(text(),'Profile deleted')]      ${Timeout}
    Wait Until Element Is Not Visible    xpath=//div//span[contains(text(),'Profile deleted')]      ${Timeout}

Click the Go to Rule details link button
    Wait Until Page Contains Element    ${GoToRuleDetailsLinkBtn}    ${Timeout}
    Click Element    ${GoToRuleDetailsLinkBtn }
    Wait Until Element Is Visible    xpath=(//span[contains(text(),'Incident Description')])[1]