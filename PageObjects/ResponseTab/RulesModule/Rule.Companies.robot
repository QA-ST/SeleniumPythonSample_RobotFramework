*** Settings ***
Library     SeleniumLibrary
Variables   ../../../Utils/TestConfigData.py

*** Keywords ***
Select Company for the rule
    [Arguments]     ${companyName}
    ${companyStatus}    Run Keyword And Return Status    Wait Until Element Is Visible    ${CompanyToSelectForRule.replace('companyName', '${companyName}')}  ${Timeout}
    IF    ${companyStatus}
        Click Element    ${CompanyToSelectForRule.replace('companyName', '${companyName}')}
    ELSE
        Fail    ${companyName} company not found
    END

Select Rule profile for the rule
    [Arguments]     ${companyName}     ${ruleProfile}
    Wait Until Element Is Visible    ${RuleProfileDropdown.replace('companyName', '${companyName}')}    ${Timeout}
    Input Text    ${RuleProfileDropdown.replace('companyName', '${companyName}')}    ${ruleProfile}
    Sleep    1
    Press Keys  ${RuleProfileDropdown.replace('companyName', '${companyName}')}     RETURN

Select Monitoring profile for the rule
    [Arguments]     ${companyName}      ${monitoringProfile}
    Wait Until Page Contains Element    ${MonitoringProfileDropdown.replace('companyName', '${companyName}')}    ${Timeout}
    Input Text    ${MonitoringProfileDropdown.replace('companyName', '${companyName}')}    ${monitoringProfile}
    Sleep    1
    Press Keys  ${MonitoringProfileDropdown.replace('companyName', '${companyName}')}     RETURN

Select White list for the rule
    [Arguments]     ${companyName}      ${whiteListName}
    Wait Until Element Is Visible    ${WhiteListDropdown.replace('companyName', '${companyName}')}      ${Timeout}
    Input Text    ${WhiteListDropdown.replace('companyName', '${companyName}')}    ${whiteListName}
    Sleep    1
    Press Keys  ${WhiteListDropdown.replace('companyName', '${companyName}')}     RETURN
    ${whiteListSelected}    Set Variable    xpath=(//label[@name='whiteList']//following::div[contains(@class,'dz_input-select')][1]//div[contains(@class,'text-dark-high-emphasis')])[2]
    Wait Until Element Is Visible    ${whiteListSelected}   ${Timeout}
    Element Should Contain    ${whiteListSelected}    ${whiteListName}

Select Black list for the rule
    [Arguments]     ${companyName}      ${blackListName}
    Wait Until Element Is Visible    ${BlackListDropdown.replace('companyName', '${companyName}')}      ${Timeout}
    Input Text    ${BlackListDropdown.replace('companyName', '${companyName}')}    ${blackListName}
    Sleep    1
    Press Keys  ${BlackListDropdown.replace('companyName', '${companyName}')}     RETURN
    ${blackListSelected}    Set Variable    xpath=(//label[@name='blackList']//following::div[contains(@class,'dz_input-select')][1]//div[contains(@class,'text-dark-high-emphasis')])[2]
    Wait Until Element Is Visible    ${blackListSelected}   ${Timeout}
    Element Should Contain    ${blackListSelected}    ${blackListName}

Activate the company for the rule
    [Arguments]     ${companyName}
    ${companyStatus}    Run Keyword And Return Status    Wait Until Element Is Visible    ${ActivateRuleInCompanyToggleSwitch.replace('companyName', '${companyName}')}    ${Timeout}
    IF    ${companyStatus}
        Sleep    1
        Click Element    ${ActivateRuleInCompanyToggleSwitch.replace('companyName', '${companyName}')}
    ELSE
        Fail    ${companyName} company not found
    END