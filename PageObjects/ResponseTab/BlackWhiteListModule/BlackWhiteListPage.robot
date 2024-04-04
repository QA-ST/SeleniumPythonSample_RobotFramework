*** Settings ***
Library    SeleniumLibrary
Resource    ../../../Helpers/CommonMethods.robot
Variables   ../../../Resources/Locators/ResponseTab/BlackWhiteListModuleLocators.py

*** Keywords ***
Click the Add White list option
    Wait Until Element Is Visible    ${AddBlackWhiteListButton}     ${Timeout}
    Click Element    ${AddBlackWhiteListButton}
    Wait Until Element Is Visible    xpath=//h4//following::button[text()='Add']//following::div[1]     ${Timeout}
    Wait Until Element Is Visible    ${AddWhiteListOptionBtn}   ${Timeout}    
    Click Element    ${AddWhiteListOptionBtn}
    Wait Until Element Is Visible    xpath=//h6[text()='Identification']    ${Timeout}

Click the Add Black list option
    Wait Until Element Is Visible    ${AddBlackWhiteListButton}     ${Timeout}
    Click Element    ${AddBlackWhiteListButton}
    Wait Until Element Is Visible    xpath=//h4//following::button[text()='Add']//following::div[1]     ${Timeout}
    Wait Until Element Is Visible    ${AddBlackListOptionBtn}   ${Timeout}
    Click Element    ${AddBlackListOptionBtn}
    Wait Until Element Is Visible    xpath=//h6[text()='Identification']    ${Timeout}
    
Switch to the White list tab
    Wait Until Element Is Visible    ${WhiteListTabButton}      ${Timeout}
    Click Element    ${WhiteListTabButton}
    Wait for table page load spinner

Switch to the Black list tab
    Wait Until Element Is Visible    ${BlackListTabButton}      ${Timeout}
    Click Element    ${BlackListTabButton}
    Wait for table page load spinner

Enter the name of the list
    [Arguments]     ${listName}
    Wait Until Element Is Visible    ${ListNameInputField}  ${Timeout}
    Clear Element Text    ${ListNameInputField}
    Input Text    ${ListNameInputField}    ${listName}

Enter the description of the list
    [Arguments]     ${listDescription}
    Wait Until Element Is Visible    ${ListDescriptionInputField}   ${Timeout}
    Clear Element Text    ${ListDescriptionInputField}
    Input Text    ${ListDescriptionInputField}    ${listDescription}

Enter the identification details for the white list
    [Arguments]     ${listName}     ${listDescription}
    Wait Until Element Is Visible    xpath=//h4[text()='Add Whitelist']     ${Timeout}
    Enter the name of the list      ${listName}
    Enter the description of the list   ${listDescription}

Enter the identification details for the black list
    [Arguments]     ${listName}     ${listDescription}
    Wait Until Element Is Visible    xpath=//h4[text()='Add Blacklist']     ${Timeout}
    Enter the name of the list      ${listName}
    Enter the description of the list   ${listDescription}

Search for black/white list
    [Arguments]     ${listName}
    Wait for table page load spinner
    Wait Until Element Is Visible    ${SearchListBar}   ${Timeout}
    Clear Element Text    ${SearchListBar}
    Input Text    ${SearchListBar}    ${listName}
    Press Keys      ${SearchListBar}    RETURN
    Wait for table page load spinner

Verify the black/white list is present in the list table
    [Arguments]     ${listName}     ${listDescription}
    ${listStatus}   Set Variable    ''
    Wait for table page load spinner
    Sleep    1
    @{listNameInTable}      Get WebElements    xpath=//section[contains(@class,'dz_table_container')]//div[contains(@class,'body_item')][3]/span
    FOR    ${listNameLocator}    IN    @{listNameInTable}
        ${listNameText}     Get Text    ${listNameLocator}
        IF    '${listNameText}' == '${listName}'
            Wait Until Element Is Visible    xpath=//section[contains(@class,'dz_table_container')]//span[text()='${listName}']//following::div[1]/span     ${Timeout}
            Element Should Contain    xpath=//section[contains(@class,'dz_table_container')]//span[text()='${listName}']//following::div[1]/span    ${listDescription}
            ${listStatus}   Set Variable    ${True}
        END
    END
    IF    ${listStatus}
        Log To Console    ${listName} is present in the list table
    ELSE
        Log To Console    ${listName} not found
    END

Click the edit icon of the black/white list
    [Arguments]     ${listName}
    Wait for table page load spinner
    Sleep    1
    @{listNameInTable}      Get WebElements    xpath=//section[contains(@class,'dz_table_container')]//div[contains(@class,'body_item')][3]/span
    FOR    ${listNameLocator}    IN    @{listNameInTable}
        ${listNameText}     Get Text    ${listNameLocator}
        IF    '${listNameText}' == '${listName}'
            Wait Until Element Is Visible    ${BlackWhiteListEditIcon.replace('listName', '${listName}')}   ${Timeout}
            Click Element    ${BlackWhiteListEditIcon.replace('listName', '${listName}')}
            Wait Until Element Is Visible    xpath=//h4[text()='${listName}']   ${Timeout}
            BREAK
        END
    END

Click the delete icon of the black/white list
    [Arguments]     ${listName}
    Wait for table page load spinner
    Sleep    1
    @{listNameInTable}      Get WebElements    xpath=//section[contains(@class,'dz_table_container')]//div[contains(@class,'body_item')][3]/span
    FOR    ${listNameLocator}    IN    @{listNameInTable}
        ${listNameText}     Get Text    ${listNameLocator}
        IF    '${listNameText}' == '${listName}'
            Wait Until Element Is Visible    ${BlackWhiteListDeleteIcon.replace('listName', '${listName}')}   ${Timeout}
            Click Element    ${BlackWhiteListDeleteIcon.replace('listName', '${listName}')}
            BREAK
        END
    END

Confirm the delete black/white list popup
    Wait Until Element Is Visible    xpath=//section//span[text()='DELETE BLACK/WHITE LIST']    ${Timeout}
    Wait Until Element Is Visible    ${DeleteBlackWhiteListConfirmBtn}      ${Timeout}
    Click Element    ${DeleteBlackWhiteListConfirmBtn}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'The Black/White list has been deleted')]     ${Timeout}
    Wait Until Element Is Not Visible    xpath=//span[contains(text(),'The Black/White list has been deleted')]     ${Timeout}

Verify the black/white list table is empty
    Wait for table page load spinner
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'dz_table_container_header')])[1]//following::span[text()='Not found data']   ${Timeout}
    ${listStatus}   Run Keyword And Return Status    Element Should Contain    xpath=(//div[contains(@class,'dz_table_container_header')])[1]//following::span[text()='Not found data']    Not found data
    Run Keyword If    ${listStatus}
    ...    Log To Console    List is removed
    ...  ELSE
    ...    Fail     List is present in the lists table

Save black/white list details
    Wait Until Element Is Visible    xpath=//div[contains(@class,'dz_popup_common')]    ${Timeout}
    Wait Until Element Is Visible    ${SaveButton}   ${Timeout}
    Click Element    ${SaveButton}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'The Black/White list has been created')]     ${Timeout}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'The Black/White list has been created')]//following::button      ${Timeout}
    Click Element    xpath=//span[contains(text(),'The Black/White list has been created')]//following::button