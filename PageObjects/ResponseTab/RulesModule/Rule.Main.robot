*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    RulePage.robot
Variables   ../../../Resources/Locators/ResponseTab/RulesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Fetch the Rule Id
    Wait Until Element Is Visible    xpath=//div/span[text()='Rule Progress']   ${Timeout}
    Wait Until Page Contains Element   xpath=//h4   ${Timeout}
    Scroll Element Into View    xpath=//h4
    ${ruleIdAndName}    Get Text    xpath=//h4
    ${ruleId}   Split String    ${ruleIdAndName}    ${SPACE}
    RETURN    ${ruleId[0]}

Enter the name of the rule
    [Arguments]     ${ruleName}
    Wait Until Element Is Visible    ${RuleNameInputField}     ${Timeout}
    Sleep    1
    Input Text    ${RuleNameInputField}    ${EMPTY}
    Input Text    ${RuleNameInputField}    ${ruleName}

Enter Identification details for the rule
    [Arguments]     ${ruleName}     ${ruleAttack}   ${ruleLanguage}
    Wait Until Element Is Visible    ${LanguageDropdown}     ${Timeout}
    Input Text    ${LanguageDropdown}    ${ruleLanguage}
    Sleep    1
    Press Keys  ${LanguageDropdown}     RETURN
    Wait Until Element Is Visible    ${RuleNameInputField}     ${Timeout}
    Input Text    ${RuleNameInputField}    ${ruleName}
    Wait Until Element Is Visible    ${RuleAttackInputField}     ${Timeout}
    Input Text    ${RuleAttackInputField}    ${ruleAttack}

Enter Data source details for the rule
    [Arguments]     ${dataSource}   ${eventType}
    Scroll Element Into View    ${MonitoringSystemDropdown}
    Wait Until Page Contains Element    ${DataSourceDropdown}     ${Timeout}
    Input Text    ${DataSourceDropdown}    ${dataSource}
    Sleep    1
    Press Keys  ${DataSourceDropdown}     RETURN
    Wait Until Page Contains Element    ${EventTypeDropdown}     ${Timeout}
    Input Text    ${EventTypeDropdown}    ${eventType}
    Sleep    2
    Press Keys  ${EventTypeDropdown}     RETURN

Select Integration for the rule
    [Arguments]     ${integration}
    Scroll Element Into View    xpath=//span[text()='Selected']
    Wait Until Page Contains Element    ${MonitoringSystemDropdown}     ${Timeout}
    Sleep    1
    Input Text    ${MonitoringSystemDropdown}    ${integration}
    Sleep    2
    Press Keys  ${MonitoringSystemDropdown}     RETURN

Search integration relation
    [Arguments]     ${relationId}
    Wait Until Page Contains Element    ${GoToMonitoringLinkBtn}    ${Timeout}
    Scroll Element Into View    ${GoToMonitoringLinkBtn}
    Wait Until Page Contains Element    ${SearchRelationInputField}     ${Timeout}
    Sleep    2
    Clear Element Text    ${SearchRelationInputField}
    Input Text    ${SearchRelationInputField}    ${relationId}
    Wait Until Page Contains Element    xpath=(//span[text()='Unselected']//following::div//div)[1]//span[2]    ${Timeout}
    ${relationIdStatus}     Run Keyword And Return Status    Element Should Contain    xpath=(//span[text()='Unselected']//following::div//div)[1]//span[2]    ${relationId}
    IF    ${relationIdStatus}
        Log To Console    ${relationId} realtion id present
    ELSE
        Fail    ${relationId} relation id not found
    END

Select Wazuh Relation Id for integration selected
    [Arguments]     ${relationId}
    Search integration relation     ${relationId}
    Sleep    1
    Click Element    ${RelationSearched}
    Wait Until Page Contains Element    ${DragRightArrowKey}    ${Timeout}
    Click Element    ${DragRightArrowKey}

    # Verify the Relation selected by user is not reflected in the list of available relations
    Wait Until Element Is Visible    xpath=//span[text()='Unselected']//following::h3[1]    ${Timeout}
    ${relationIdStatus}     Run Keyword And Return Status    Element Should Contain    xpath=//span[text()='Unselected']//following::h3[1]    There are no related items yet.
    IF    ${relationIdStatus}
        Log To Console    Wazuh ${relationId} selected and not present in the unselected block
        Save Rule information entered
    ELSE
        Fail    Wazuh ${relationId} is still present in the unselected block
    END

Remove Relation Id from Rule
    [Arguments]     ${relationId}
    ${relationRemoved}  Set Variable    ''
    Wait Until Page Contains Element    ${GoToMonitoringLinkBtn}    ${Timeout}
    Scroll Element Into View    ${GoToMonitoringLinkBtn}
    Sleep    1
    Wait Until Element Is Visible    xpath=(//span[text()='Selected']//following::div//div//span)[2]    ${Timeout}
    @{relationIdSelectedNamesLocator}   Get WebElements    xpath=//span[text()='Selected']//following::div//div//span[2]
    FOR    ${relationIdsNames}    IN    @{relationIdSelectedNamesLocator}
        Wait Until Element Is Visible    ${relationIdsNames}    ${Timeout}
        ${relationIdsNamesText}     Get Text    ${relationIdsNames}
        IF    '${relationIdsNamesText}' == '(${relationId})'
            Click Element    ${relationIdsNames}
            Scroll Element Into View    ${GoToMonitoringLinkBtn}
            Wait Until Element Is Visible    ${DragLeftArrowKey}    ${Timeout}
            Click Element    ${DragLeftArrowKey}
            ${relationRemoved}  Set Variable    ${True}
            Save Rule information entered
            BREAK
        END
    END
    Run Keyword If    ${relationRemoved}
    ...    Log To Console    ${relationId} is removed
    ...  ELSE
    ...    Fail    ${relationId} not found in the selected relation list

Verify the selected integration relation block is empty
    Wait Until Element Is Visible    xpath=//span[text()='Selected']//following::h3[1]   ${Timeout}
    ${relationsSelectedBlockStatus}     Run Keyword And Return Status    Element Should Contain    xpath=//span[text()='Selected']//following::h3[1]    There are no related items yet.
    IF    ${relationsSelectedBlockStatus}
        Log To Console    The realtion selected block is empty
    ELSE
        Fail    The relation selected block is not empty
    END

Verify the unselected integration relation block is empty
    Wait Until Element Is Visible    xpath=//span[text()='Unselected']//following::h3[1]    ${Timeout}
    ${relationsUnselectedBlockStatus}   Run Keyword And Return Status    Element Should Contain    xpath=//span[text()='Unselected']//following::h3[1]    There are no related items yet. :(
    IF    ${relationsUnselectedBlockStatus}
        Log To Console    The realtion unselected block is empty
    ELSE
        Fail    The relation unselected block is not empty
    END

Click the Go to Monitoring systems link button
    Wait Until Page Contains Element    ${GoToMonitoringLinkBtn}    ${Timeout}
    Click Element    ${GoToMonitoringLinkBtn}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'Documentaion')]