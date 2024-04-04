*** Settings ***
Library    SeleniumLibrary
Variables   ../../../Resources/Locators/ResponseTab/RulesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py
Resource    ../../../Helpers/CommonMethods.robot

*** Keywords ***
Click the Monitoring Systems button in view menu of rule
    Wait Until Element Is Visible    ${ViewRuleMenuMonitoringSystemsTabButton}  ${Timeout}
    Sleep    1
    Click Element    ${ViewRuleMenuMonitoringSystemsTabButton}
    Wait Until Element Is Visible    xpath=//span[text()='Documentaion']    ${Timeout}

Click the Rule Details button in view menu of rule
    Wait Until Element Is Visible    ${ViewRuleMenuRuleDetailsTabButton}    ${Timeout}
    Sleep    1
    Click Element    ${ViewRuleMenuRuleDetailsTabButton}
    Wait Until Element Is Visible    xpath=//span[text()='Rule Details']    ${Timeout}

Click the Mitre Techniques button in view menu of rule
    Wait Until Element Is Visible    ${ViewRuleMenuMitreTechniquesTabButton}    ${Timeout}
    Sleep    1
    Click Element    ${ViewRuleMenuMitreTechniquesTabButton}
    Wait Until Element Is Visible    xpath=//span[text()='Related Techniques']    ${Timeout}

Click the Playbooks button in view menu of rule
    Wait Until Element Is Visible    ${ViewRuleMenuPlaybooksTabButton}    ${Timeout}
    Sleep    1
    Click Element    ${ViewRuleMenuPlaybooksTabButton}
    Wait Until Element Is Visible    xpath=//span[text()='Playbook']//following::div[contains(@class,'dz_table_container_body')][1]    ${Timeout}

Click the Companies button in view menu of rule
    Wait Until Element Is Visible    ${ViewRuleMenuCompaniesTabButton}    ${Timeout}
    Sleep    1
    Click Element    ${ViewRuleMenuCompaniesTabButton}

Verify the integration relation ids selected in the view rule collapse menu
    [Arguments]     ${ruleName}     ${relationId}
    ${relationIdStatus}     Set Variable    ''
    Wait Until Element Is Visible    xpath=(//section//span[text()='${ruleName}'])[2]       ${Timeout}
    Wait Until Page Contains Element    xpath=(//section//span[text()='${ruleName}'])[2]//following::span[text()='Relations'][2]    ${Timeout}
    Scroll Element Into View    xpath=(//section//span[text()='${ruleName}'])[2]//following::span[text()='Relations'][2]
    ${relationIdsLocator}       Get WebElements    ${RelationIdsInViewRuleMenu.replace('ruleName', '${ruleName}')}
    FOR    ${relationIdSelected}    IN    @{relationIdsLocator}
        ${relationIdName}   Get Text    ${relationIdSelected}
        ${relationIdSelected}       Run Keyword And Return Status    Should Contain    ${relationIdName}    ${relationId}
        IF    ${relationIdSelected}
            ${relationIdStatus}     Set Variable    ${True}
        END
    END
    IF    ${relationIdStatus}
        Log To Console    ${relationId} is present in the ${ruleName} view menu
    ELSE
        Fail     ${relationId} not found in the ${ruleName} view menu
    END

Verify that no integration relation ids is selected in the view rule collapse menu
    [Arguments]     ${ruleName}
    Wait Until Element Is Visible    xpath=(//section//span[text()='${ruleName}'])[2]       ${Timeout}
    Wait Until Page Contains Element    xpath=(//section//span[text()='${ruleName}'])[2]//following::span[text()='Relations'][2]    ${Timeout}
    Scroll Element Into View    xpath=(//section//span[text()='${ruleName}'])[2]//following::span[text()='Relations'][2]
    ${relationIdStatus}     Run Keyword And Return Status    Wait Until Element Is Visible    ${RelationIdsInViewRuleMenu.replace('ruleName', '${ruleName}')}      8
    IF    ${relationIdStatus}
        Fail    Relation id is displayed in the view rule collapsible menu
    ELSE
        Log To Console    No integration relation ids is selected in the view rule collapse menu

    END 

Verify wazuh integration and its ruleset in the monitoring system tab of view rule menu
    [Arguments]     ${vendorProfileName}    ${integration}  ${rulesetGroupValue}
    ${rulesetStatus}    Set Variable    ''
    Wait Until Element Is Visible    xpath=(//span[text()='Rule Profile'])[2]   ${Timeout}
    Sleep    1
    @{integrationsDisplayed}    Get WebElements    xpath=(//span[text()='Rule Profile'])[2]//following::span[text()='${vendorProfileName}']//following::section//span
    FOR    ${integrationsDisplayedName}    IN    @{integrationsDisplayed}
        ${integrationsDisplayedNameText}  Get Text    ${integrationsDisplayedName}
        IF    '${integrationsDisplayedNameText}' == '${integration}'
            Sleep    2
            Click Element    ${integrationsDisplayedName}
            Sleep    1
            Verify wazuh ruleset group of the rule    ${rulesetGroupValue}
            Sleep    1
            Click Element    ${integrationsDisplayedName}
            ${rulesetStatus}    Set Variable    ${True}
            BREAK
        END
    END
    IF    ${rulesetStatus}
        Log To Console    ${rulesetGroupValue} is present in the ${integration} for the ${vendorProfileName} vendor
    ELSE
        Fail     ${rulesetGroupValue} not found in the ${integration} for the ${vendorProfileName} vendor
    END

Verify wazuh ruleset group of the rule
    [Arguments]      ${rulesetGroupValue}
    ${rulesetStatus}    Set Variable    ''
    Wait Until Element Is Visible    xpath=//div[@id='wazuh']      ${Timeout}
    @{ruleset}  Get WebElements    xpath=//div[@id='wazuh']//section//section//span
    FOR    ${rulesetValue}    IN    @{ruleset}
        ${rulesetValueText}     Get Text    ${rulesetValue}
        IF    '${rulesetValueText}' == '${rulesetGroupValue}'
            ${rulesetStatus}    Set Variable    ${True}
        END
    END
    IF    ${rulesetStatus}
        Log To Console    ${rulesetGroupValue} is present
    ELSE
        Fail    ${rulesetGroupValue} not found
    END

Verify the grouping selected in the view rule collapse menu
    [Arguments]     ${ruleName}     ${groupingToVerify}
    ${groupingToVerifyStatus}   Set Variable    ''
    Wait Until Element Is Visible    xpath=(//section//span[text()='${ruleName}'])[2]      ${Timeout}
    Sleep    1
    ${groupingSelectedLocator}      Get WebElements    xpath=(//section//span[text()='${ruleName}'])[2]//following::span[text()='Grouping']//following::span
    FOR    ${groupingSelected}    IN    @{groupingSelectedLocator}
        ${groupingSelectedText}     Get Text    ${groupingSelected}
        IF    '${groupingSelectedText}' == '${groupingToVerify}'
            ${groupingToVerifyStatus}   Set Variable    ${True}
        END
    END
    IF    ${groupingToVerifyStatus}
        Log To Console    ${groupingToVerify} is present in the view rule menu
    ELSE
        Fail    ${groupingToVerify} not found in the view rule menu
    END

Select vendor profile in the view rule collapse menu
    [Arguments]     ${vendorProfileName}
    Wait Until Element Is Visible    ${SelectVendorProfileButton_ViewRuleMenu}   ${Timeout}
    Click Element    ${SelectVendorProfileButton_ViewRuleMenu}
    Wait Until Element Is Visible    xpath=(//span[text()='Rule Profile'])[2]//following::div[2]    ${Timeout}
    Sleep    1
    @{vendorProfiles}   Get WebElements    xpath=(//span[text()='Rule Profile'])[2]//following::div[2]//span
    FOR    ${vendorProfileNamePresent}    IN    @{vendorProfiles}
        Wait Until Element Is Visible    ${vendorProfileNamePresent}    ${Timeout}
        ${vendorProfileNameText}    Get Text    ${vendorProfileNamePresent}
        IF    '${vendorProfileNameText}' == '${vendorProfileName}'
            Sleep    1
            Click Element    ${vendorProfileNamePresent} 
            Wait Until Element Is Visible    ${SelectedVendorProfile.replace('vendorProfileName', '${vendorProfileName}')}      ${Timeout}
            ${vendorName}   Get Text    ${SelectedVendorProfile.replace('vendorProfileName', '${vendorProfileName}')}
            Should Contain    ${vendorName}    ${vendorProfileName}
            Sleep    1
            BREAK
        END
    END

Click the cross icon of the view rule collapse menu
    Wait Until Page Contains Element    ${ViewRuleMenuCrossIcon}   ${Timeout}
    Scroll Element Into View    ${ViewRuleMenuCrossIcon}
    Sleep    2
    Click Element    ${ViewRuleMenuCrossIcon}
    Wait for table page load spinner