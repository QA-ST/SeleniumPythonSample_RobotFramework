*** Settings ***
Library     SeleniumLibrary
Resource    ../../Helpers/CommonMethods.robot
Variables   ../../Resources/Locators/SettingsTab/RelationsModuleLocators.py

*** Keywords ***
Click the edit icon for the vendor
    [Arguments]     ${vendorName}
    Wait for table page load spinner
    Sleep    1
    ${vendorsList}  Get WebElements    xpath=//section[contains(@class,'table_container')]//div[@class='relative']//div[contains(@class,'body_item')][1]/span
    FOR    ${vendorNamePresent}    IN    @{vendorsList}
        Wait Until Element Is Visible    ${vendorNamePresent}   ${Timeout}
        ${vendorStatus}     Run Keyword And Return Status    Element Should Contain    ${vendorNamePresent}    ${vendorName}
        IF    ${vendorStatus}
            Wait Until Element Is Visible    ${VendorEditIcon.replace('vendorName', '${vendorName}')}    ${Timeout}
            Click Element    ${VendorEditIcon.replace('vendorName', '${vendorName}')}
            Wait Until Element Is Visible    xpath=//h4[text()='${vendorName}']     ${Timeout}
            Wait for table page load spinner
            BREAK
        END
    END
    Run Keyword If    ${vendorStatus}
    ...    Log To Console    ${vendorName} vendor is present in the list
    ...  ELSE
    ...    Fail     ${vendorName} vendor not found

Click the add relation button
    Wait for table page load spinner
    Wait Until Element Is Visible    ${AddRelationButton}   ${Timeout}
    Click Element    ${AddRelationButton}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'create a relation in this vendor')]      ${Timeout}

Enter the alert id for the relation
    [Arguments]     ${alertId}
    Wait Until Element Is Visible    ${AlertIdInputField}   ${Timeout}
    Input Text    ${AlertIdInputField}    ${alertId}

Save the vendor relation details
    Wait Until Element Is Visible    ${SaveButton}    ${Timeout}
    Scroll Element Into View    ${SaveButton}
    Click Element    ${SaveButton}
    Wait Until Element Is Visible    xpath=//div/span[contains(text(),'The Relation has been created')]     ${Timeout}
    Wait Until Element Is Not Visible    xpath=//div/span[contains(text(),'The Relation has been created')]     ${Timeout}

Navigate back to the vendor relation list page
    [Arguments]     ${vendor}
    Wait Until Element Is Visible    ${RelationNavigateBackButton}      ${Timeout}
    Click Element    ${RelationNavigateBackButton}
    Wait Until Element Is Visible    xpath=//h4[text()='${vendor}']     ${Timeout}
    Wait for table page load spinner

Search the vendor relation
    [Arguments]     ${relationAlertId}
    Wait for table page load spinner
    Wait Until Element Is Visible    ${RelationSearchBar}   ${Timeout}
    Input Text    ${RelationSearchBar}    ${relationAlertId}
    Sleep    1
    Press Keys  ${RelationSearchBar}    RETURN
    Wait for table page load spinner

Verify the vendor relation is present
    [Arguments]     ${relationAlertId}
    ${vendorRelationStatus}     Set Variable    ''
    Wait for table page load spinner
    Sleep    1
    @{vendorRelationsPresent}   Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]//div[contains(@class,'grid')]/div[1]
    FOR    ${vendorRelationName}    IN    @{vendorRelationsPresent}
        ${vendorRelationNameText}   Get Text    ${vendorRelationName}
        IF    '${vendorRelationNameText}' == '${relationAlertId}'
            ${vendorRelationStatus}     Set Variable    ${True}
            BREAK
        END
    END
    Run Keyword If    ${vendorRelationStatus}
    ...    Log To Console    ${relationAlertId} relation is present
    ...  ELSE
    ...    Fail     ${relationAlertId} relation not found

Verify the rule having the vendor relation selected is displayed in the relations table
    [Arguments]     ${testRelationId}   ${ruleId}   ${ruleName}
    Wait for table page load spinner
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'table_container_body')])[1]/div/div[text()='${testRelationId}']     ${Timeout}
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'table_container_body')])[1]/div/div[text()='${testRelationId}']//following::div[1]   ${Timeout}
    ${ruleIdStatus}     Run Keyword And Return Status    Element Should Contain    xpath=(//div[contains(@class,'table_container_body')])[1]/div/div[text()='${testRelationId}']//following::div[1]    ${ruleId}
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'table_container_body')])[1]/div/div[text()='${testRelationId}']//following::div[2]   ${Timeout}
    ${ruleNameStatus}   Run Keyword And Return Status    Element Should Contain    xpath=(//div[contains(@class,'table_container_body')])[1]/div/div[text()='${testRelationId}']//following::div[2]    ${ruleName}
    IF    ${ruleIdStatus} and ${ruleNameStatus}
        Log To Console    ${ruleName} having the ${testRelationId} selected is reflected in the relations table
    ELSE
        Fail    ${ruleName} having the ${testRelationId} selected not found in the relations table
    END

Verify the situation status of the wazuh vendor relation
    [Arguments]     ${testRelationId}   ${status}
    Wait for table page load spinner
    ${relationSituationStatusLocator}  Set Variable    xpath=(//div[contains(@class,'table_container_body')])[1]/div/div[text()='${testRelationId}']//following::input[@id='situation']//preceding::div[1]
    Wait Until Element Is Visible    ${relationSituationStatusLocator}    ${Timeout}
    ${relationSituationStatusDisplayed}     Get Text    ${relationSituationStatusLocator}
    IF    '${relationSituationStatusDisplayed}' == '${status}'
        Log To Console    ${testRelationId} wazuh relation status is ${status}
    ELSE
        Fail    ${testRelationId} wazuh relation status is not ${status}
    END

Click the delete icon of the vendor relation
    [Arguments]     ${vendorRelation}
    Wait for table page load spinner
    Sleep    1
    @{vendorRelationsPresent}   Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]//div[contains(@class,'grid')]/div[1]
    FOR    ${vendorRelationName}    IN    @{vendorRelationsPresent}
        ${vendorRelationNameText}   Get Text    ${vendorRelationName}
        IF    '${vendorRelationNameText}' == '${vendorRelation}'
            Wait Until Element Is Visible    ${VendorRelationDeleteIcon.replace('vendorRelation', '${vendorRelationNameText}')}     ${Timeout}
            Click Element    ${VendorRelationDeleteIcon.replace('vendorRelation', '${vendorRelationNameText}')}
            Wait Until Element Is Visible    ${DeleteVendorRelationPopup}   ${Timeout}
            BREAK
        END
    END

Confirm the delete vendor relation popup
    Wait Until Element Is Visible    ${DeleteVendorRelationPopup}   ${Timeout}
    Wait Until Element Is Visible    ${DeleteVendorRelationConfirmBtn}  ${Timeout}
    Click Element    ${DeleteVendorRelationConfirmBtn}
    Wait Until Element Is Visible    xpath=//div/span[contains(text(),'The Relation has been deleted')]     ${Timeout}
    Wait Until Element Is Not Visible    xpath=//div/span[contains(text(),'The Relation has been deleted')]     ${Timeout}
    Wait for table page load spinner


Verify the vendor relation is not found in the relations list
    [Arguments]     ${vendorRelation}
    Wait for table page load spinner
    Wait Until Element Is Visible    xpath=//section[contains(@class,'dz_table_container')]/div[@class='relative']//span[text()='Not found data']   ${Timeout}
    ${relationTableStatus}  Run Keyword And Return Status    Element Should Contain    xpath=//section[contains(@class,'dz_table_container')]/div[@class='relative']//span[text()='Not found data']    Not found data
    IF    ${relationTableStatus}
        Log To Console    ${vendorRelation} relation not found
    ELSE
        Fail    ${vendorRelation} realtion is present
    END