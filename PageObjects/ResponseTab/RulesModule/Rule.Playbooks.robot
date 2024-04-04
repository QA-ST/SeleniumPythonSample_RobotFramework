*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Helpers/CommonMethods.robot
Variables   ../../../Resources/Locators/ResponseTab/RulesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Click the Add Playbook button
    Wait Until Element Is Visible    ${AddPlaybookButton}   ${Timeout}
    Click Element    ${AddPlaybookButton}
    Wait Until Element Is Visible    xpath=//span[text()='Identification']

Search playbook from the list
    [Arguments]     ${playbookName}
    Wait for table page load spinner
    Wait Until Element Is Visible    ${PlaybookSearchBar}    ${Timeout}
    Clear Element Text    ${PlaybookSearchBar}
    Input Text    ${PlaybookSearchBar}    ${playbookName}
    Sleep    1
    Press Keys  ${PlaybookSearchBar}    RETURN
    Wait for table page load spinner

Activate Playbook
    [Arguments]     ${playbookName}
    Wait for table page load spinner
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'table_container_body')])[1]//div[text()='${playbookName}']     ${Timeout}
    ${playbookStatus}   Run Keyword And Return Status    Element Should Contain    xpath=(//div[contains(@class,'table_container_body')])[1]//div[text()='${playbookName}']    ${playbookName}
    IF    ${playbookStatus}
        ${playbookActivateToggleSwitch}     Set Variable    ${ActivatePlaybookToggleSwitch.replace('playbookName', '${playbookName}')}
        Wait Until Page Contains Element    ${playbookActivateToggleSwitch}     ${Timeout}
        Sleep    1
        Click Element    ${playbookActivateToggleSwitch}
        Element Should Be Enabled    ${playbookActivateToggleSwitch}
    ELSE
        ${playbookName} not found
    END

Click the edit icon for the playbook
    [Arguments]     ${playbookName}
    Wait for table page load spinner
    ${playbooksNameListLocator}     Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]//div[contains(@class,'container_body_item')][3]
    FOR    ${playbooksNameList}    IN    @{playbooksNameListLocator}
        ${playbookNameText}     Get Text    ${playbooksNameList}
        IF    '${playbookNameText}' == '${playbookName}'
            Wait Until Element Is Visible    ${EditPlaybookIcon.replace('playbookName', '${playbookName}')}     ${Timeout}
            Click Element    ${EditPlaybookIcon.replace('playbookName', '${playbookName}')}
            Wait Until Element Is Visible    ${PlaybookNameInputField}      ${Timeout}
            BREAK
        END
    END

Click the delete icon for the playbook
    [Arguments]     ${playbookName}
    Wait for table page load spinner
    ${playbooksNameListLocator}     Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]//div[contains(@class,'container_body_item')][3]
    FOR    ${playbooksNameList}    IN    @{playbooksNameListLocator}
        ${playbookNameText}     Get Text    ${playbooksNameList}
        IF    '${playbookNameText}' == '${playbookName}'
            Wait Until Element Is Visible    ${DeletePlaybookIcon.replace('playbookName', '${playbookName}')}   ${Timeout}
            Click Element    ${DeletePlaybookIcon.replace('playbookName', '${playbookName}')}
            Wait Until Element Is Visible    ${DeletePlaybookConfirmationPopup}     ${Timeout}
            BREAK
        END
    END

Verify the playbook is present in the playbooks list
    [Arguments]     ${playbookName}
    ${playbookStatus}    Set Variable   ''
    Wait for table page load spinner
    Sleep    1
    ${playbooksNameListLocator}     Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]//div[contains(@class,'container_body_item')][3]
    FOR    ${playbooksNameList}    IN    @{playbooksNameListLocator}
        ${playbookNameText}     Get Text    ${playbooksNameList}
        IF    '${playbookNameText}' == '${playbookName}'
            ${playbookStatus}   Set Variable    ${True}
        END
    END
    Run Keyword If    ${playbookStatus}
    ...    Log To Console    ${playbookName} is present in the playbooks list
    ...  ELSE
    ...    Fail    ${playbookName} not found in the list of playbooks

Verify the playbook table is empty
    Wait for table page load spinner
    ${emptyTableStatus}     Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[contains(@class,'dz_table_container')]//following::span[text()='Not found data']      ${Timeout}
    IF    ${emptyTableStatus}
        ${tableStatus}  Get Text    xpath=//div[contains(@class,'dz_table_container')]//following::span[text()='Not found data']
        Should Contain    ${tableStatus}    Not found data
    ELSE
        Fail    Playbook table is not empty
    END

Confirm the delete playbook popup
    Wait Until Element Is Visible   ${PlaybookDeleteConfirmButton}  ${Timeout}
    Sleep    1
    Click Element    ${PlaybookDeleteConfirmButton}
    Wait for table page load spinner

Enter the name of the playbook
    [Arguments]     ${playbookName}
    Wait Until Element Is Visible    ${PlaybookNameInputField}  ${Timeout}
    Sleep    1
    Input Text    ${PlaybookNameInputField}    ${EMPTY}
    Input Text    ${PlaybookNameInputField}    ${playbookName}

Select Advance visibility for the playbook
    [Arguments]     ${companyName}
    Wait Until Page Contains Element    ${AdvancePlaybookVisibilityRadioOption}   ${Timeout}
    Sleep    1
    Click Element    ${AdvancePlaybookVisibilityRadioOption}
    Wait Until Page Contains Element    ${SelectCompanyDropdown}     ${Timeout}
    Input Text    ${SelectCompanyDropdown}    ${companyName}
    Sleep    2
    Press Keys  ${SelectCompanyDropdown}     RETURN

Add phase type and step in playbook
    [Arguments]     ${phaseName}    ${phaseType}    ${phaseStep}    ${addStepToPhaseButton}
    Wait Until Page Contains Element    ${addStepToPhaseButton}     ${Timeout}
    Scroll Element Into View    ${addStepToPhaseButton}
    Wait Until Page Contains Element    ${PlaybookPhaseType.replace('phaseName', '${phaseName}')}    ${Timeout}
    Input Text    ${PlaybookPhaseType.replace('phaseName', '${phaseName}')}    ${phaseType}
    Sleep    2
    Press Keys  ${PlaybookPhaseType.replace('phaseName', '${phaseName}')}     RETURN
    Wait Until Page Contains Element    ${PlaybookPhaseStep.replace('phaseName', '${phaseName}')}    ${Timeout}
    Input Text    ${PlaybookPhaseStep.replace('phaseName', '${phaseName}')}    ${phaseStep}
    Wait Until Page Contains Element    ${addStepToPhaseButton}     ${Timeout}
    Click Element    ${addStepToPhaseButton}

Add Recovery phase step
    [Arguments]     ${phaseType}    ${phaseStep}
    Wait Until Page Contains Element    ${AddRecoveryStepButton}    ${Timeout}
    Scroll Element Into View    ${AddRecoveryStepButton}
    ${responsibleInputField}    Set Variable    //span[text()='Recovery Phase']//following::input[@id='responsible'][1]
    Input Text    ${responsibleInputField}    ${phaseType}
    Sleep    2
    Press Keys  ${responsibleInputField}    RETURN
    Wait Until Page Contains Element    ${PlaybookPhaseStep.replace('phaseName', 'Recovery Phase')}    ${Timeout}
    Input Text    ${PlaybookPhaseStep.replace('phaseName', 'Recovery Phase')}    ${phaseStep}
    Wait Until Page Contains Element    ${AddRecoveryStepButton}     ${Timeout}
    Click Element    ${AddRecoveryStepButton}

Verify the phase step is present in the playbook
    [Arguments]     ${phaseName}    ${phaseStep}
    ${phaseStepStatus}      Set Variable    ''
    Wait Until Page Contains Element    xpath=//span[text()='${phaseName}']    ${Timeout}
    Scroll Element Into View    xpath=//span[text()='${phaseName}']
    Sleep    1
    ${phaseStepsAddedLocator}      Get WebElements    //span[text()='${phaseName}']//following::ul[1]//li//span[2]
    FOR    ${phaseStepsAddedName}    IN    @{phaseStepsAddedLocator}
        ${phaseStepsAddedNameText}      Get Text    ${phaseStepsAddedName}
        IF    '${phaseStepsAddedNameText}' == '${phaseStep}'
            ${phaseStepStatus}      Set Variable    ${True}
        END
    END
    Run Keyword If    ${phaseStepStatus}
    ...    Log To Console    ${phaseStep} is added in the ${phaseName} phase
    ...  ELSE
    ...    Fail    ${phaseStep} is not added in the ${phaseName} phase

Edit phase step in the playbook
    [Arguments]     ${phaseName}    ${phaseStep}    ${newPhaseStep}
    Wait Until Page Contains Element    xpath=//span[text()='${phaseName}']    ${Timeout}
    Scroll Element Into View    xpath=//span[text()='${phaseName}']
    ${phaseStepStatus}      Run Keyword And Return Status    Verify the phase step is present in the playbook   ${phaseName}    ${phaseStep}
    IF    ${phaseStepStatus}
        Wait Until Element Is Visible    xpath=//span[text()='${phaseName}']//following::ul[1]//li//span[text()='${phaseStep}']//following::button[1]   ${Timeout}
        Click Element    xpath=//span[text()='${phaseName}']//following::ul[1]//li//span[text()='${phaseStep}']//following::button[1]
        Wait Until Element Is Visible    ${EditPhaseStepInputField.replace('phaseName', '${phaseName}')}     ${Timeout}
        Sleep    1
        Clear Element Text    ${EditPhaseStepInputField.replace('phaseName', '${phaseName}')}
        Input Text    ${EditPhaseStepInputField.replace('phaseName', '${phaseName}')}    ${newPhaseStep}
        Wait Until Element Is Visible    ${EditPhaseStepConfirmIcon.replace('phaseName', '${phaseName}')}   ${Timeout}
        Click Element    ${EditPhaseStepConfirmIcon.replace('phaseName', '${phaseName}')}
    ELSE
        Fail    ${phaseStep} not found in the ${phaseName} in playbook
    END

Remove phase steps in the playbook
    [Arguments]     ${phaseName}    ${phaseStep}
    Wait Until Page Contains Element    xpath=//span[text()='${phaseName}']    ${Timeout}
    Scroll Element Into View    xpath=//span[text()='${phaseName}']
    ${phaseStepStatus}      Run Keyword And Return Status    Verify the phase step is present in the playbook   ${phaseName}    ${phaseStep}
    IF    ${phaseStepStatus}
        Wait Until Element Is Visible    xpath=//span[text()='${phaseName}']//following::ul[1]//li//span[text()='${phaseStep}']//following::button[2]   ${Timeout}
        Click Element    xpath=//span[text()='${phaseName}']//following::ul[1]//li//span[text()='${phaseStep}']//following::button[2]
        Log To Console    ${phaseStep} step is removed from the playbook in ${phaseName}
    ELSE
        Fail    ${phaseStep} not found in the ${phaseName}
    END

Add lessons learned for the playbook
    [Arguments]     ${lessonLearned}
    Scroll Element Into View    ${AddLessonsLearnedButton}
    Wait Until Element Is Visible    ${AddLessonsLearnedButton}     ${Timeout}
    Wait Until Element Is Visible    ${LessonsLearnedInputField}    ${Timeout}
    Input Text    ${LessonsLearnedInputField}    ${lessonLearned}
    Click Element    ${AddLessonsLearnedButton}

Add comment in the Comments tab for the playbook
    [Arguments]     ${comment}
    Wait Until Page Contains Element    ${AddCommentButton}     ${Timeout}
    Scroll Element Into View    ${AddCommentButton}
    Wait Until Element Is Visible    ${CommentsInputField}  ${Timeout}
    Input Text    ${CommentsInputField}    ${comment}
    Wait Until Element Is Visible    ${AddCommentButton}    ${Timeout}
    Click Element    ${AddCommentButton}

Add Comment in the Versioning tab for the playbook
    [Arguments]     ${comment}
    Scroll Element Into View    ${VersioningReviewInputField}
    Wait Until Element Is Visible    ${VersioningReviewInputField}   ${Timeout}
    Input Text    ${VersioningReviewInputField}    ${comment}

Verify the lessons learned is addded in the playbook
    [Arguments]     ${lessonLearnedAdded}
    ${lessonAddedStatus}    Set Variable    ''
    Wait Until Page Contains Element    ${AddLessonsLearnedButton}     ${Timeout}
    Scroll Element Into View    ${AddLessonsLearnedButton}
    ${leassonsAddedLocator}     Get WebElements    (//span[text()='Lessons Learned'])[1]//following::button[following::label[@name='lessonLearned']]//preceding::span[1]
    FOR    ${lessonAddedName}    IN    @{leassonsAddedLocator}
        ${lessonAddedNameText}      Get Text    ${lessonAddedName}
        IF    '${lessonAddedNameText}' == '${lessonLearnedAdded}'
            ${lessonAddedStatus}    Set Variable    ${True}
        END
    END
    Run Keyword If    ${lessonAddedStatus}
    ...    Log To Console    ${lessonLearnedAdded} lesson has been added in the playbook
    ...  ELSE
    ...    Fail    ${lessonLearnedAdded} lesson not found in the playbook

Verify the comments is added in the playbook
    [Arguments]     ${commentAdded}
    ${commentAddedStatus}       Set Variable    ''
    Wait Until Page Contains Element    ${AddCommentButton}     ${Timeout}
    Scroll Element Into View    ${AddCommentButton}
    ${commentsAddedLocator}     Get WebElements    //span[text()='Comments']//following::button[following::label[@name='comment']]//preceding::span[1]
    FOR    ${commentsAdded}    IN    @{commentsAddedLocator}
        ${commentAddedText}     Get Text    ${commentsAdded}
        IF    '${commentAddedText}' == '${commentAdded}'
            ${commentAddedStatus}       Set Variable    ${True}
        END
    END
    Run Keyword If    ${commentAddedStatus}
    ...    Log To Console    ${commentAdded} comment has been added to the playbook
    ...  ELSE
    ...    Fail    ${commentAdded} comment is not added to the playbook

Verify the versioning comment is added in the playbook
    [Arguments]     ${versionComment}
    ${versionCommentStatus}     Set Variable    ''
    Wait Until Page Contains Element    ${VersioningReviewInputField}      ${Timeout}
    Scroll Element Into View    ${VersioningReviewInputField}
    ${versioningCommentsLocator}    Get WebElements    xpath=//span[text()='HISTORY']//following::div//span[5]
    FOR    ${versoningCommentsAdded}    IN    @{versioningCommentsLocator}
        ${versionCommentText}       Get Text    ${versoningCommentsAdded}
        IF    '${versionCommentText}' == '${versionComment}'
            ${versionCommentStatus}     Set Variable    ${True}
        END
    END
    Run Keyword If    ${versionCommentStatus}
    ...    Log To Console    ${versionComment} version comment is added in the playbook
    ...  ELSE
    ...    Fail    ${versionComment} version comment not found in the playbook

Remove the lesson learned comment from the playbook
    [Arguments]     ${lessonLearnedComment}
    Wait Until Page Contains Element    ${AddLessonsLearnedButton}    ${Timeout}
    Scroll Element Into View    ${AddLessonsLearnedButton}
    ${leassonLearnedCommentStatus}      Run Keyword And Return Status    Verify the lessons learned is addded in the playbook   ${lessonLearnedComment}
    IF    ${leassonLearnedCommentStatus}
        Wait Until Element Is Visible    xpath=//span[text()='Lessons Learned']//following::span[text()='${lessonLearnedComment}']//following::button[1]    ${Timeout}
        Click Element    xpath=//span[text()='Lessons Learned']//following::span[text()='${lessonLearnedComment}']//following::button[1]
        Log To Console    ${lessonLearnedComment} is removed from the lessons learned in playbook
    ELSE
        Fail    ${lessonLearnedComment} is not present in lessons learned in playbook
    END

Remove the comment from the playbook
    [Arguments]     ${comment}
    Wait Until Page Contains Element    ${AddCommentButton}    ${Timeout}
    Scroll Element Into View    ${AddCommentButton}
    ${commentStatus}    Run Keyword And Return Status    Verify the comments is added in the playbook   ${comment}
    IF    ${commentStatus}
        Wait Until Element Is Visible    xpath=//span[text()='Comments']//following::span[text()='${comment}']//following::button[1]    ${Timeout}
        Click Element    xpath=//span[text()='Comments']//following::span[text()='${comment}']//following::button[1]
        Log To Console    ${comment} has been removed from the comments in playbook
    ELSE
        Fail    ${comment} not found in the playbook
    END

Click the Go to Companies link button
    Wait Until Page Contains Element    ${GoToCompaniesLinkBtn}    ${Timeout}
    Click Element    ${GoToCompaniesLinkBtn}
    Wait Until Element Is Visible    xpath=(//span[contains(text(),'Companies')])[2]    ${Timeout}