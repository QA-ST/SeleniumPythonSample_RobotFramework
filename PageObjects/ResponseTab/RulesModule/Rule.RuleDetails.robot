*** Settings ***
Library     SeleniumLibrary
Variables   ../../../Resources/Locators/ResponseTab/RulesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Enter Incident description detail for the rule
    [Arguments]     ${incidentDescription}
    Wait Until Element Is Visible    ${IncidentDescriptionInputField}    ${Timeout}
    Input Text    ${IncidentDescriptionInputField}    ${incidentDescription}

Wait for grouping load spinner
    Wait Until Element Is Not Visible    ${GroupingLoadSpinner}     ${Timeout}
    Wait Until Element Is Visible    xpath=(//span[text()='Unselected']//following::div//div)[1]    ${Timeout}

Search grouping
    [Arguments]     ${groupingToSelect}
    Wait Until Page Contains Element    ${GoToMitreTechniquesLinkBtn}   ${Timeout}
    Scroll Element Into View    ${GoToMitreTechniquesLinkBtn}
    Wait Until Page Contains Element    ${GroupingSearchInputField}     ${Timeout}
    Clear Element Text    ${GroupingSearchInputField}
    Input Text    ${GroupingSearchInputField}    ${groupingToSelect}
    Wait for grouping load spinner

Select grouping for the rule
    [Arguments]     ${groupingToSelect}
    Search grouping    ${groupingToSelect}
    Sleep    1
    @{groupingsNameLocator}     Get WebElements    xpath=//span[text()='Unselected']//following::div/span[2][following::span[text()='Selected']]
    FOR    ${groupingName}    IN    @{groupingsNameLocator}
        ${goupingNameText}      Get Text    ${groupingName}
        IF    '${goupingNameText}' == '(${groupingToSelect})'
            Wait Until Page Contains Element    ${groupingName}   ${Timeout}
            Sleep    2
            Click Element    ${groupingName}
            Wait Until Page Contains Element    ${DragRightArrowKey}    ${Timeout}
            Click Element    ${DragRightArrowKey}
            BREAK
        END
    END
    ${groupingSelectedStatus}   Run Keyword And Return Status    Verify the grouping is selected    ${groupingToSelect}
    IF    ${groupingSelectedStatus}
        Log To Console    ${groupingToSelect} grouping is selected
    ELSE
        Fail    Failed to select ${groupingToSelect} grouping
    END

Remove grouping from the rule
    [Arguments]     ${groupingToRemove}
    ${groupingToRemoveStatus}   Set Variable    ''
    Scroll Element Into View    ${GoToMitreTechniquesLinkBtn}
    Wait for grouping load spinner
    Sleep    1
    @{groupingSelectedLocator}      Get WebElements    xpath=//span[text()='Selected']//following::div/span[2]
    FOR    ${groupingName}    IN    @{groupingSelectedLocator}
        ${groupingNameText}     Get Text    ${groupingName}
        IF    '${groupingNameText}' == '(${groupingToRemove})'
            Click Element    ${groupingName}
            Wait Until Page Contains Element    ${DragLeftArrowKey}     ${Timeout}
            Click Element    ${DragLeftArrowKey}
            ${groupingToRemoveStatus}      Set Variable    ${True}
            BREAK
        END
    END
    IF    ${groupingToRemoveStatus}
        Log To Console    ${groupingToRemove} grouping removed
    ELSE
        Fail    Failed to remove the ${groupingToRemove} grouping
    END

Verify the grouping is present in the unselected block
    [Arguments]     ${groupingToSelect}
    ${groupingStatus}   Set Variable    ''
    Wait Until Page Contains Element    ${GoToMitreTechniquesLinkBtn}   ${Timeout}
    Scroll Element Into View    ${GoToMitreTechniquesLinkBtn}
    Wait for grouping load spinner
    Sleep    1
    @{groupingsNameLocator}     Get WebElements    xpath=//span[text()='Unselected']//following::div/span[2][following::span[text()='Selected']]
    FOR    ${groupingName}    IN    @{groupingsNameLocator}
        ${goupingNameText}      Get Text    ${groupingName}
        IF    '${goupingNameText}' == '(${groupingToSelect})'
            ${groupingStatus}   Set Variable    ${True}
        END
    END
    IF    ${groupingStatus}
        Log To Console    ${groupingToSelect} found in the unselected block
    ELSE
        Fail    ${groupingToSelect} not found
    END

Verify the grouping is selected
    [Arguments]     ${groupingSelected}
    ${groupingSelectedStatus}   Set Variable    ''
    Scroll Element Into View    ${GoToMitreTechniquesLinkBtn}
    Wait for grouping load spinner
    Sleep    1
    @{groupingsSelectedLocator}     Get WebElements    xpath=//span[text()='Selected']//following::div/span[2]
    FOR    ${groupingName}    IN    @{groupingsSelectedLocator}
        ${groupingNameText}      Get Text    ${groupingName}
        IF    '${groupingNameText}' == '(${groupingSelected})'
            ${groupingSelectedStatus}       Set Variable    ${True}
        END
    END
    IF    ${groupingSelectedStatus}
        Log To Console    ${groupingSelected} found in the selected block
    ELSE
        Fail    ${groupingSelected} not found
    END

Click the Go to Mitre techniques link button
    Wait Until Page Contains Element    ${GoToMitreTechniquesLinkBtn}    ${Timeout}
    Click Element    ${GoToMitreTechniquesLinkBtn }
    Wait Until Page Contains Element    xpath=(//span[text()='Mitre Techniques'])[2]    ${Timeout}