*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    ../../../Helpers/CommonMethods.robot
Variables   ../../../Resources/Locators/ResponseTab/RulesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Click the Add Rule button
    Wait Until Element Is Visible    ${AddRuleButton}    ${Timeout}
    Click Element    ${AddRuleButton}
    Wait for the add rule load spinner

Wait for the add rule load spinner
    Wait Until Element Is Not Visible    ${PageLoadSpinner}      ${Timeout}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'Rule Progress')]     ${Timeout}

Save Rule information entered
    Wait Until Element Is Visible    ${SaveButton}   ${Timeout}
    Sleep    1
    Click Element    ${SaveButton}

Regect the unsaved changes popup for rule
    Wait Until Element Is Visible    xpath=//section//span[text()='Unsaved Changes']    ${Timeout}
    Wait Until Element Is Visible    ${QuitWithoutSavingButton}     ${Timeout}
    Sleep    1
    Click Element    ${QuitWithoutSavingButton}
    Wait Until Element Is Visible    xpath=//h4[text()='Rules']     ${Timeout}

Navigate to the last set of rules through pagination
    Wait for table page load spinner
    Wait Until Page Contains Element    xpath=(//div[contains(@class,'footer')]//button/*[local-name()='svg'])[2]//preceding::button[1]    ${Timeout}
    Scroll Element Into View    xpath=(//div[contains(@class,'footer')]//button/*[local-name()='svg'])[2]//preceding::button[1]
    Sleep    1
    Click Element    xpath=(//div[contains(@class,'footer')]//button/*[local-name()='svg'])[2]//preceding::button[1]
    Wait for table page load spinner

Search rule from the rules list
    [Arguments]     ${ruleId}
    Wait for table page load spinner
    Wait Until Element Is Visible    ${RulesPageSearchBar}      ${Timeout}
    Input Text    ${RulesPageSearchBar}    ${ruleId}
    Sleep    1
    Press Keys      ${RulesPageSearchBar}   RETURN
    Wait for table page load spinner

Verify the Rule is present in the list of rules
    [Arguments]     ${ruleName}
    @{rulesNameList}   Create List
    Wait for table page load spinner
    Sleep    1
    ${rulesNameListLocator}    Get WebElements    xpath=//section[contains(@class,'dz_table_container')]//div[contains(@class,'body_item')]//span[contains(@class,'text-sm')]
    FOR    ${rulesName}    IN    @{rulesNameListLocator}
        ${ruleNameText}     Get Text    ${rulesName}
        IF    '${ruleNameText}' != ''
            Append To List    ${rulesNameList}  ${ruleNameText}
        END
    END
    Run Keyword If    '${ruleName}' in @{rulesNameList}
    ...    Log To Console    ${ruleName} is present in the rules list
    ...  ELSE
    ...    Fail     ${ruleName} not found in the rules list

Verify the Rule is not present in the list of rules
    [Arguments]     ${ruleName}
    @{rulesNameList}   Create List
    Wait for table page load spinner
    Sleep    1
    ${rulesNameListLocator}    Get WebElements    xpath=//section[contains(@class,'dz_table_container')]//div[contains(@class,'body_item')]//span[contains(@class,'text-sm')]
    FOR    ${rulesName}    IN    @{rulesNameListLocator}
        ${ruleNameText}     Get Text    ${rulesName}
        IF    '${ruleNameText}' != ''
            Append To List    ${rulesNameList}  ${ruleNameText}
        END
    END
    Run Keyword If    '${ruleName}' in @{rulesNameList}
    ...    Fail     ${ruleName} is present in the list of rules
    ...  ELSE
    ...    Log To Console    ${ruleName} is not present in the rules list

Activate the Rule
    [Arguments]     ${ruleName}
    Wait for table page load spinner
    Wait Until Element Is Visible    xpath=//div[contains(@class,'table_container_body')]/span[text()='${ruleName}']   ${Timeout}
    ${ruleStatus}   Run Keyword And Return Status    Element Should Contain    xpath=//div[contains(@class,'table_container_body')]/span[text()='${ruleName}']    ${ruleName}
    IF    ${ruleStatus}
        Wait Until Element Is Visible    ${ActivateRuleToggleSwitch.replace('ruleName', '${ruleName}')}    ${Timeout}
        Sleep    2
        Click Element    ${ActivateRuleToggleSwitch.replace('ruleName', '${ruleName}')}
        Element Should Be Enabled    ${ActivateRuleToggleSwitch.replace('ruleName', '${ruleName}')}
    ELSE
        Fail    ${ruleName} rule not found
    END

Click the view icon for the rule
    [Arguments]     ${ruleName}
    Wait for table page load spinner
    Sleep    1
    ${rulesNameListLocator}    Get WebElements    xpath=//section[contains(@class,'dz_table_container')]//div[contains(@class,'body_item')]//span[contains(@class,'text-sm')]
    FOR    ${rulesName}    IN    @{rulesNameListLocator}
        ${ruleNameText}     Get Text    ${rulesName}
        IF    '${ruleNameText}' != ''
            IF    '${ruleNameText}' == '${ruleName}'
                ${actionMenuIconStatus}     Run Keyword And Return Status    Wait Until Element Is Visible    ${RuleTableActionMenuIcon.replace('ruleName', '${ruleName}')}     8
                IF    ${actionMenuIconStatus}
                    Click Element    ${RuleTableActionMenuIcon.replace('ruleName', '${ruleName}')}
                    Wait Until Element Is Visible    xpath=//button//span[text()='View']   ${Timeout}
                    Click Element    xpath=//button//span[text()='View']
                    Wait Until Element Is Visible    xpath=(//section//span[text()='${ruleName}'])[2]    ${Timeout}
                    BREAK
                ELSE
                    Wait Until Element Is Visible    ${ViewRuleIcon.replace('ruleName', '${ruleName}')}    ${Timeout}
                    Click Element    ${ViewRuleIcon.replace('ruleName', '${ruleName}')}
                    Wait Until Element Is Visible    xpath=(//section//span[text()='${ruleName}'])[2]    ${Timeout}
                    BREAK
                END
            END
        END
    END

Click the edit icon for the rule
    [Arguments]     ${ruleName}
    Wait for table page load spinner
    Sleep    1
    ${rulesNameListLocator}    Get WebElements    xpath=//section[contains(@class,'dz_table_container')]//div[contains(@class,'body_item')]//span[contains(@class,'text-sm')]
    FOR    ${rulesName}    IN    @{rulesNameListLocator}
        ${ruleNameText}     Get Text    ${rulesName}
        IF    '${ruleNameText}' != ''
            IF    '${ruleNameText}' == '${ruleName}'
                ${actionMenuIconStatus}     Run Keyword And Return Status    Wait Until Element Is Visible    ${RuleTableActionMenuIcon.replace('ruleName', '${ruleName}')}     8
                IF    ${actionMenuIconStatus}
                    Click Element    ${RuleTableActionMenuIcon.replace('ruleName', '${ruleName}')}
                    Wait Until Element Is Visible    xpath=//button//span[text()='Edit']   ${Timeout}
                    Click Element    xpath=//button//span[text()='Edit']
                    Wait Until Element Is Visible    ${LanguageDropdown}     ${Timeout}
                    BREAK
                ELSE
                    Wait Until Element Is Visible    ${EditRuleIcon.replace('ruleName', '${ruleName}')}    ${Timeout}
                    Click Element    ${EditRuleIcon.replace('ruleName', '${ruleName}')}
                    Wait Until Element Is Visible    ${LanguageDropdown}     ${Timeout}
                    BREAK
                END
            END
        END
    END

Click the delete icon for the rule
    [Arguments]     ${ruleName}
    Wait for table page load spinner
    Sleep    1
    ${rulesNameListLocator}    Get WebElements    xpath=//section[contains(@class,'dz_table_container')]//div[contains(@class,'body_item')]//span[contains(@class,'text-sm')]
    FOR    ${rulesName}    IN    @{rulesNameListLocator}
        ${ruleNameText}     Get Text    ${rulesName}
        IF    '${ruleNameText}' != ''
            IF    '${ruleNameText}' == '${ruleName}'
                ${actionMenuIconStatus}     Run Keyword And Return Status    Wait Until Element Is Visible    ${RuleTableActionMenuIcon.replace('ruleName', '${ruleName}')}     8
                IF    ${actionMenuIconStatus}
                    Click Element    ${RuleTableActionMenuIcon.replace('ruleName', '${ruleName}')}
                    Wait Until Element Is Visible    xpath=//button//span[text()='Delete']   ${Timeout}
                    Click Element    xpath=//button//span[text()='Delete']
                    Wait Until Element Is Visible    ${DeleteRulePopupVerification}     ${Timeout}
                    BREAK
                ELSE
                    Wait Until Element Is Visible    ${DeleteRuleIcon.replace('ruleName', '${ruleName}')}    ${Timeout}
                    Click Element    ${DeleteRuleIcon.replace('ruleName', '${ruleName}')}
                    Wait Until Element Is Visible    ${DeleteRulePopupVerification}     ${Timeout}
                    BREAK
                END
            END
        END
    END

Confirm the delete verfication popup
    Wait Until Page Contains Element    ${RuleDeleteConfirmButton}  ${Timeout}
    Sleep    2
    Click Element    ${RuleDeleteConfirmButton}
    Sleep    1
    Wait for table page load spinner

Verify the rules table is empty
    Wait for table page load spinner
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'dz_table_container')])[1]//following::div[@class='relative']/div/span    ${Timeout}
    ${ruleTableStatus}  Run Keyword And Return Status    Element Should Contain    xpath=(//div[contains(@class,'dz_table_container')])[1]//following::div[@class='relative']/div/span    Not found data
    IF    ${ruleTableStatus}
        Log To Console    Rules table is empty
    ELSE
        Fail    Rules table is not empty
    END