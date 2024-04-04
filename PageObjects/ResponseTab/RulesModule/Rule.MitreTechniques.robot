*** Settings ***
Library     SeleniumLibrary
Variables   ../../../Resources/Locators/ResponseTab/RulesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Wait for mitre technique load spinner
    Wait Until Element Is Not Visible    ${MitreTechniquePageLoadSpinner}   ${Timeout}
    Wait Until Element Is Visible    xpath=//span[text()='Unselected']//following::section[1]   ${Timeout}

Search Mitre Technique
    [Arguments]     ${mitreTechnique}
    Wait for mitre technique load spinner
    Wait Until Element Is Visible    ${MitreTechniqueSearchBar}     ${Timeout}
    Clear Element Text    ${MitreTechniqueSearchBar}
    Input Text    ${MitreTechniqueSearchBar}    ${mitreTechnique}
    Press Keys    ${MitreTechniqueSearchBar}    RETURN
    Wait Until Element Is Visible    xpath=//span[text()='Unselected']//following::section[1]//span[1]  ${Timeout}

Add Mitre Techniques for the Rule
    [Arguments]     ${mitreTechnique}   ${subTechnique}
    ${mitreTechniqueStatus}     Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//span[text()='Unselected']//following::span[text()='${mitreTechnique}'][1]  ${Timeout}
    IF    ${mitreTechniqueStatus}
        Click Element    xpath=//span[text()='Unselected']//following::span[text()='${mitreTechnique}'][1]
        Sleep    1
        ${subTechniqueStatus}   Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//span[text()='${subTechnique}']//preceding::span[contains(@class,'input-checkbox')]  ${Timeout}
        IF    ${subTechniqueStatus}
            Sleep    1
            Click Element    xpath=//span[text()='${subTechnique}']//preceding::input[1]
            Scroll Element Into View    ${GoToPlaybooksLinkBtn}
            Wait Until Page Contains Element    ${DragRightArrowKey}    ${Timeout}
            Sleep    1
            Click Element    ${DragRightArrowKey}
        ELSE
            Fail    ${subTechnique} not found
        END
    ELSE
        Fail    ${mitreTechnique} not found
    END

Verify the mitre technique is selected
    [Arguments]     ${mitreTechnique}
    ${mitreTechniqueSelected}   Set Variable    ''
    Wait Until Element Is Visible    ${GoToPlaybooksLinkBtn}    ${Timeout}
    Sleep    1
    Wait Until Element Is Visible    xpath=//div[@id='box-dnd-mitre-right-column']//div/span[1]     ${Timeout}
    @{mitreTechniqueSelectedNamesLocator}   Get WebElements    xpath=//span[text()='Selected']//following::div//span[3]
    FOR    ${mitreTechniqueNames}    IN    @{mitreTechniqueSelectedNamesLocator}
        Wait Until Element Is Visible    ${mitreTechniqueNames}    ${Timeout}
        ${mitreTechniqueNamesText}     Get Text    ${mitreTechniqueNames}
        IF    '${mitreTechniqueNamesText}' == '${mitreTechnique}'
            ${mitreTechniqueSelected}  Set Variable    ${True}
            BREAK
        END
    END
    Run Keyword If    ${mitreTechniqueSelected}
    ...    Log To Console    ${mitreTechnique} mitre technique is selected
    ...  ELSE
    ...    Fail    ${mitreTechnique} mitre technique is not selected

Click the Go to Playbooks link button
    Wait Until Page Contains Element    ${GoToPlaybooksLinkBtn}    ${Timeout}
    Sleep    1
    Click Element    ${GoToPlaybooksLinkBtn }
    Wait Until Page Contains Element    xpath=(//span[text()='Playbooks'])[2]    ${Timeout}