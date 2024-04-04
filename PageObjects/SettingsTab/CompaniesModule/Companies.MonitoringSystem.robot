*** Settings ***
Library     SeleniumLibrary
Variables   ../../../Resources/Locators/CommonLocators.py
Variables   ../../../Resources/Locators/SettingsTab/CompaniesModuleLocators.py
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Click the Add SIEM button
    Wait Until Element Is Visible    ${AddSiemButton}   ${Timeout}
    Click Element    ${AddSiemButton}
    Wait Until Element Is Visible    xpath=//h6//following::span[contains(text(),'Assign a name and description')]  ${Timeout}

Enter the name of the monitoring system
    [Arguments]     ${monitoringSystemName}
    Wait Until Element Is Visible    ${MonitoringSystemNameInputField}      ${Timeout}
    Click Element    ${MonitoringSystemNameInputField}
    Input Text    ${MonitoringSystemNameInputField}    ${EMPTY}
    Input Text    ${MonitoringSystemNameInputField}    ${monitoringSystemName}

Enter the description of the monitoring system
    [Arguments]     ${monitoringSystemDescription}
    Wait Until Element Is Visible    ${MonitoringSystemDescriptionInputField}   ${Timeout}
    Input Text    ${MonitoringSystemDescriptionInputField}    ${monitoringSystemDescription}

Select the vendor for the monitoring system
    [Arguments]     ${vendorName}
    Wait Until Element Is Visible    ${SelectVendorInputFieldDropdown}      ${Timeout}
    Input Text    ${SelectVendorInputFieldDropdown}    ${vendorName}
    Sleep    2
    Press Keys      ${SelectVendorInputFieldDropdown}   RETURN

Enter the host for the integration
    [Arguments]     ${hostValueIndex1}  ${hostValueIndex2}  ${hostValueIndex3}  ${hostValueIndex4}
    @{hostIndexValues}  Create List     ${hostValueIndex1}  ${hostValueIndex2}  ${hostValueIndex3}  ${hostValueIndex4}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'required fields for integration')]   ${Timeout}
    ${hostIndexsPresent}   Get WebElements    ${HostInputField}
    FOR    ${counter}    IN RANGE    0    ${hostIndexsPresent.__len__()}    
        Input Text    ${hostIndexsPresent[${counter}]}    ${hostIndexValues[${counter}]}
    END

Enter the port for the integration
    [Arguments]     ${portValue}
    Wait Until Element Is Visible    ${PortInputField}  ${Timeout}
    Input Text    ${PortInputField}    ${portValue}

Enter the index value for the integration
    [Arguments]     ${indexValue}
    Wait Until Element Is Visible    ${IndexInputField}     ${Timeout}
    Input Text    ${IndexInputField}    ${indexValue}
    
Enter the scheme for the integration
    [Arguments]     ${schemeValue}
    Wait Until Element Is Visible    ${SchemeInputField}    ${Timeout}
    Input Text    ${SchemeInputField}    ${schemeValue}
    
Enter the password for the integration
    [Arguments]     ${password}
    Wait Until Element Is Visible    ${IntegrationPasswordInputField}  ${Timeout}
    Input Text    ${IntegrationPasswordInputField}    ${password}
    
Enter the username for the integration
    [Arguments]     ${username}
    Wait Until Element Is Visible    ${IntegrationUsernameInputField}  ${Timeout}
    Input Text    ${IntegrationUsernameInputField}    ${username}

Enter the rule path for the integration
    [Arguments]     ${rulePathValue}
    Wait Until Element Is Visible    ${RulePathInputField}  ${Timeout}
    Input Text    ${RulePathInputField}    ${rulePathValue}
    Sleep    1
    Press Keys      ${RulePathInputField}   RETURN

Enter the timestamp for the integration
    [Arguments]     ${timestampValue}
    Wait Until Element Is Visible    ${TimestampInputField}     ${Timeout}
    Input Text    ${TimestampInputField}    ${timestampValue}

Save the monitoring system details
    Wait Until Element Is Visible    ${SaveButton}   ${Timeout}
    Scroll Element Into View    ${SaveButton}
    Click Element    ${SaveButton}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'The SIEM has been created')]     ${Timeout}
    Wait Until Element Is Not Visible    xpath=//span[contains(text(),'The SIEM has been created')]     ${Timeout}

Search the monitoring system
    [Arguments]     ${monitoringSystem}
    Wait Until Element Is Visible    ${SearchMonitoringSystemInputField}    ${Timeout}
    Input Text    ${SearchMonitoringSystemInputField}    ${monitoringSystem}
    Sleep    1
    Press Keys      ${SearchMonitoringSystemInputField}     RETURN

Verify the monitoring system is present
    [Arguments]     ${monitoringSystemName}
    ${monitoringSystemStatus}   Set Variable    ''
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'table_container_body')])[1]/div[1]  ${Timeout}
    Sleep    1
    ${monitoringSystemPresentLocator}   Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]/div/div[2]/span
    FOR    ${montoringSystemPresent}    IN    @{monitoringSystemPresentLocator}
        ${monitoringSystemNameText}     Get Text    ${montoringSystemPresent}
        IF    '${monitoringSystemNameText}' == '${monitoringSystemName}'
            ${monitoringSystemStatus}   Set Variable    ${True}
        END
    END
    Run Keyword If    ${monitoringSystemStatus}
    ...    Log To Console    ${monitoringSystemName} is present in the monitoring system list
    ...  ELSE
    ...    Fail    ${monitoringSystemName} not found in the monitoring system list

Click the delete icon for the monitoring system
    [Arguments]     ${monitoringSystemName}
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'table_container_body')])[1]
    Sleep    1
    ${monitoringSystemPresentLocator}   Get WebElements    xpath=(//div[contains(@class,'table_container_body')])[1]/div/div[2]/span
    FOR    ${montoringSystemPresent}    IN    @{monitoringSystemPresentLocator}
        ${monitoringSystemNameText}     Get Text    ${montoringSystemPresent}
        IF    '${monitoringSystemNameText}' == '${monitoringSystemName}'
            Wait Until Element Is Visible    ${DeleteMonitoringSystemButton.replace('monitoringSystemName', '${monitoringSystemName}')}     ${Timeout}   
            Click Element    ${DeleteMonitoringSystemButton.replace('monitoringSystemName', '${monitoringSystemName}')}
            Wait Until Element Is Visible    xpath=//div/span[text()='DELETE SIEM']     ${Timeout}
            BREAK
        END
    END
    
Confirm the delete monitoring system popup
    Wait Until Element Is Visible    xpath=//div/span[text()='DELETE SIEM']     ${Timeout}
    Wait Until Element Is Visible    ${DeleteMonitoringSystemConfirmBtn}    ${Timeout}
    Click Element    ${DeleteMonitoringSystemConfirmBtn}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'The SIEM has been deleted')]
    Wait Until Element Is Not Visible    xpath=//span[contains(text(),'The SIEM has been deleted')]