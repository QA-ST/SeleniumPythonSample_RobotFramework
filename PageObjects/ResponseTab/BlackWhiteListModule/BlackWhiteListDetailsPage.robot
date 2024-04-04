*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Helpers/CommonMethods.robot
Variables   ../../../Utils/TestConfigData.py
Variables   ../../../Resources/Locators/ResponseTab/BlackWhiteListModuleLocators.py

*** Keywords ***
Navigate back to the Black/White list page
    Wait Until Element Is Visible    ${NavigateBackToBlackWhiteListPageBtn}     ${Timeout}
    Click Element    ${NavigateBackToBlackWhiteListPageBtn}
    Wait Until Element Is Visible    xpath=//h4[text()='Black/White List']      ${Timeout}
    Element Should Contain    xpath=//h4[text()='Black/White List']    Black/White List
    Wait for table page load spinner

Save the details updated for the black/white list
    Wait Until Element Is Visible    xpath=//div[contains(@class,'dz_popup_common')]    ${Timeout}
    Wait Until Element Is Visible    ${SaveButton}   ${Timeout}
    Click Element    ${SaveButton}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'The Black/White list has been updated')]     ${Timeout}
    Wait Until Element Is Not Visible    xpath=//span[contains(text(),'The Black/White list has been updated')]     ${Timeout}
    
Click the add entry button
    Wait Until Element Is Visible    ${AddEntryInListButton}    ${Timeout}
    Click Element    ${AddEntryInListButton}
    Wait Until Element Is Visible    xpath=//h4[text()='Add Entry']     ${Timeout}

Enter the name of the black/white list entry
    [Arguments]     ${listEntryName}
    Wait Until Element Is Visible    ${EntryNameInputField}     ${Timeout}
    Input Text    ${EntryNameInputField}    ${listEntryName}

Select the monitoring system for the black/white list
    [Arguments]     ${monitoringSystem}
    Wait Until Element Is Visible    ${EntryMonitoringSystemInputField}     ${Timeout}
    Input Text    ${EntryMonitoringSystemInputField}     ${monitoringSystem}
    Sleep    1
    Press Keys      ${EntryMonitoringSystemInputField}      RETURN

Check the check all checkbox
    Wait Until Element Is Visible    ${ListEntryCheckAllCheckbox}   ${Timeout}
    Sleep    1
    Click Element    ${ListEntryCheckAllCheckbox}
    Checkbox Should Be Selected    xpath=//span[contains(@class,'input-checkbox')]/input[@id='checkAll']

Enter field query and its value with regex enabled
    [Arguments]     ${fieldQueryOrder}      ${fieldQuery}    ${fieldQueryValue}
    Wait Until Element Is Visible    ${ListEntryFieldQueryInputField.replace('fieldQueryOrder', '${fieldQueryOrder}')}      ${Timeout}
    Input Text    ${ListEntryFieldQueryInputField.replace('fieldQueryOrder', '${fieldQueryOrder}')}    ${fieldQuery}
    Wait Until Element Is Visible    ${ListEntryFieldRegexCheckbox.replace('fieldQueryOrder', '${fieldQueryOrder}')}    ${Timeout}
    Click Element    ${ListEntryFieldRegexCheckbox.replace('fieldQueryOrder', '${fieldQueryOrder}')}
    Checkbox Should Be Selected    xpath=//input[@name='checkAll']//following::ul//li['${fieldQueryOrder}']//span[contains(@class,'dz_input-checkbox')]/input
    Wait Until Element Is Visible    ${ListEntryFieldQueryValueInputField.replace('fieldQueryOrder', '${fieldQueryOrder}')}     ${Timeout}
    Input Text    ${ListEntryFieldQueryValueInputField.replace('fieldQueryOrder', '${fieldQueryOrder}')}    ${fieldQueryValue}

Set the list conditional field value
    [Arguments]     ${fieldQueryOrder}     ${conditionType}
    Wait Until Element Is Visible    ${ListConditionFieldInputBox.replace('fieldQueryOrder', '${fieldQueryOrder}')}     ${Timeout}
    Input Text    ${ListConditionFieldInputBox.replace('fieldQueryOrder', '${fieldQueryOrder}')}    ${conditionType}
    Sleep    1
    Press Keys      ${ListConditionFieldInputBox.replace('fieldQueryOrder', '${fieldQueryOrder}')}      RETURN

Add field in the black/white list entry
    [Arguments]     ${fieldType}
    ${fieldsCount}   Get Element Count    xpath=//input[@name='checkAll']//following::ul//li
    Wait Until Element Is Visible    ${AddFieldInListButton.replace('fieldQueryOrder', '${fieldsCount}')}   ${Timeout}
    Sleep    1
    Click Element    ${AddFieldInListButton.replace('fieldQueryOrder', '${fieldsCount}')}
    Wait Until Element Is Visible    ${SelectFieldToAddButton.replace('fieldType', '${fieldType}')}     ${Timeout}
    Click Element    ${SelectFieldToAddButton.replace('fieldType', '${fieldType}')}
    ${fieldQueryOrder}      Set Variable    ${fieldsCount} + 1
    RETURN      ${fieldQueryOrder}
    
 Save the entry for the black/white list
    Wait Until Element Is Visible    ${SaveButton}     ${Timeout}
    Click Element    ${SaveButton}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'The Entry has been updated')]    ${Timeout}
    Wait Until Element Is Visible    xpath= //span[contains(text(),'The Entry has been updated')]//following::button    ${Timeout}
    Click Element    xpath= //span[contains(text(),'The Entry has been updated')]//following::button
    Wait Until Element Is Not Visible    xpath=//span[contains(text(),'The Entry has been updated')]    ${Timeout}
    Wait for table page load spinner

Search the entry in the black/white list
    [Arguments]     ${listEntryName}
    Wait for table page load spinner
    Wait Until Element Is Visible    ${SearchEntryBar}      ${Timeout}
    Input Text    ${SearchEntryBar}    ${listEntryName}
    Sleep    1
    Press Keys      ${SearchEntryBar}   RETURN
    Wait for table page load spinner

Verify the black/white list entry is present
    [Arguments]     ${listEntryName}
    ${listEntryStatus}      Set Variable    ''
    Wait for table page load spinner
    Sleep    1
    ${listEntriesNameLocator}   Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]//div[contains(@class,'container_body_item')][3]
    FOR    ${listEntryNamePresent}    IN    @{listEntriesNameLocator}
        ${listEntryNameText}    Get Text    ${listEntryNamePresent}
        IF    '${listEntryNameText}' == '${listEntryName}'
            ${listEntryStatus}  Set Variable    ${True}
        END
    END
    Run Keyword If    ${listEntryStatus}
    ...    Log To Console    ${listEntryName} is present in the list
    ...  ELSE
    ...    Fail    ${listEntryName} not found in the list
    
Click the delete icon for the black/white list entry
    [Arguments]     ${listEntryName}
    Wait for table page load spinner
    Sleep    1
    ${listEntriesNameLocator}   Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]//div[contains(@class,'container_body_item')][3]
    FOR    ${listEntryNamePresent}    IN    @{listEntriesNameLocator}
        ${listEntryNameText}    Get Text    ${listEntryNamePresent}
        IF    '${listEntryNameText}' == '${listEntryName}'
            Wait Until Element Is Visible    ${DeleteListEntryButton.replace('entryName', '${listEntryName}')}  ${Timeout}
            Click Element    ${DeleteListEntryButton.replace('entryName', '${listEntryName}')}
            Wait Until Element Is Visible    xpath=//section//span[text()='DELETE ENTRY']   ${Timeout}
            BREAK
        END
    END
    
Confirm the delete entry popup
    Wait Until Element Is Visible    xpath=//section//span[text()='DELETE ENTRY']   ${Timeout}
    Wait Until Element Is Visible    ${DeleteListEntryConfirmBtn}   ${Timeout}
    Click Element    ${DeleteListEntryConfirmBtn}
    Wait Until Element Is Visible    xpath=//div//span[contains(text(),'The Entry has been deleted')]   ${Timeout}
    Wait Until Element Is Not Visible    xpath=//div//span[contains(text(),'The Entry has been deleted')]   ${Timeout}

Verify the entry is not present in the list entry table
    Wait for table page load spinner
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'dz_table_container_header')])[1]//following::span[text()='Not found data']   ${Timeout}
    ${listEntryStatus}   Run Keyword And Return Status    Element Should Contain    xpath=(//div[contains(@class,'dz_table_container_header')])[1]//following::span[text()='Not found data']    Not found data
    Run Keyword If    ${listEntryStatus}
    ...    Log To Console    List entry is removed
    ...  ELSE
    ...    Fail     Entry is present in the list entry table