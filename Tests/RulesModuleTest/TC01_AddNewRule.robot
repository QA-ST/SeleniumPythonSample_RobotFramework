*** Settings ***
Library  SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Main.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.MonitoringSystems.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.RuleDetails.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Playbooks.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Companies.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/ViewRuleCollapseMenu.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py
Variables   ../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown      Destroy browser context

*** Variables ***
${addedRuleId}

*** Test Cases ***
To verify user is able to add new Rule
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to Rules page from the hambuger menu
    When Click the Add Rule button
    And Enter Main details for the new rule added
    And Store Rule Id for the new rule
    And Click the Go to Monitoring systems link button
    And Enter Monitoring System details for new rule added
    And Click the Go to Rule details link button
    And Enter Rule Details for the new Rule added
    And Click the Go to Mitre techniques link button
    And Add mitre techniques for the new rule
    And Click the Go to Playbooks link button
    And Add and Activate Playbook for the new rule added
    And Click the Go to Companies link button
    And Select Company for the rule    ${DiazeroCompany_Company}
    And Select Rule profile for the rule    ${DiazeroCompany_Company}    ${Main_RuleProfile}
    And Select Monitoring profile for the rule    ${DiazeroCompany_Company}    ${Main_VendorProfile}
    And Activate the company for the rule    ${DiazeroCompany_Company}
    And Save Rule information entered
    And Navigate back to Rules page
    And Reload Page
    And Search rule from the rules list    ${addedRuleId}
    When Verify the Rule is present in the list of rules    ${TestingRuleName}
    And Activate the Rule   ${TestingRuleName}

Verify the details of the new rule added from the view rule collapse menu
    When Click the view icon for the rule    ${TestingRuleName}
    Then Verify the Main details of the rule    ${RuleLanguage}    ${TestingRuleName}    ${RuleAttack}    ${DataSource}    ${EventType}    ${WazuhMonitoringSystem}    ${Wazuh005_RelationId}    ${Wazuh007_RelationId}
    And Verify the Monitoring System details of the rule    ${TestRuleDescription}      ${Main_VendorProfile}    ${WazuhMonitoringSystem}      ${TestRulesetGroupValue_Rule}
    And Verify the Rule Details details of the rule     ${TestingRuleName}    ${IncidentDescription}    ${SourceIpVerifyViewRuleMenu}
    And Verify the Playbooks details of the rule    ${TestPlaybookName}
    And Verify the Companies details of the rule    ${DiazeroCompany_Company}    ${Main_RuleProfile}    ${Main_VendorProfile}
    And Click the cross icon of the view rule collapse menu
    And User logout from the application

*** Keywords ***
Store Rule Id for the new rule
    ${ruleIdValue}   Fetch the Rule Id
    VAR     ${addedRuleId}      ${ruleIdValue}      scope=SUITE

Enter Main details for the new rule added
    Enter Identification details for the rule   ${TestingRuleName}      ${RuleAttack}   ${RuleLanguage}
    Enter Data source details for the rule  ${DataSource}   ${EventType}
    Select Integration for the rule     ${WazuhMonitoringSystem}
    Select Wazuh Relation Id for integration selected     ${Wazuh005_RelationId}
    Select Wazuh Relation Id for integration selected     ${Wazuh007_RelationId}

Enter Monitoring System details for new rule added
    Enter the rule description    ${TestRuleDescription}
    Set severity as Medium using CVSS calculator
    Add Wazuh ruleset for the rule    ${RulesetGroup_Rule}     ${TestRulesetGroupValue_Rule}
    Save Rule information entered

Enter Rule Details for the new Rule added
    Enter Incident description detail for the rule  ${IncidentDescription}
    Select grouping for the rule    ${SourceIpGrouping}
    Save Rule information entered

Add mitre techniques for the new rule
    Search Mitre Technique    ${Recognition_MitreTechnique}
    Add Mitre Techniques for the Rule   ${Recognition_MitreTechnique}    ${ActiveScanning_SubMitreTechnique}
    Save Rule information entered
    Reload Page
    Verify the mitre technique is selected      ${ActiveScanning_SubMitreTechnique}

Add and Activate Playbook for the new rule added
    Click the Add Playbook button
    Enter the name of the playbook    ${TestPlaybookName}
    Select Advance visibility for the playbook    ${DiazeroCompany_Company}
    
    # Add Preparation phase steps for MSS type
    Add phase type and step in playbook     ${PreparationPhaseName}     ${MssPhaseType}     ${TestMssPreparationPhaseStep}  ${AddPreparationStepButton}
    Verify the phase step is present in the playbook    ${PreparationPhaseName}    ${TestMssPreparationPhaseStep}
    
    # Add Identification phase steps for Company type
    Add phase type and step in playbook    ${IdentificationPhaseName}    ${CompanyPhaseType}    ${TestCompanyIdentificationPhaseStep}    ${AddIdentificationStepButton}
    Verify the phase step is present in the playbook    ${IdentificationPhaseName}    ${TestCompanyIdentificationPhaseStep}
    
    Add Comment in the Versioning tab for the playbook  ${TestVersioningReviewComment}
    Save Rule information entered
    Search playbook from the list   ${TestPlaybookName}
    Verify the playbook is present in the playbooks list    ${TestPlaybookName}
    Activate Playbook   ${TestPlaybookName}

Verify the Main details of the rule
    [Arguments]     ${ruleLanguage}     ${ruleName}     ${ruleAttack}   ${dataSource}   ${eventType}    ${integration}    ${relationId1}  ${relationId2}
    ${ruleDetailsParam}     Set Variable    xpath=(//span[text()='Main'])[2]//following::span[text()='ruleParam'][1]//following::span[1]
    ${ruleDataSourceDetail}    Set Variable    xpath=(//span[text()='Main'])[2]//following::span[text()='Data source'][2]//following::span[1]
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Language')}   ${Timeout}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Language')}    ${ruleLanguage}
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Name')}   ${Timeout}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Name')}    ${ruleName}
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Attack')}   ${Timeout}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Attack')}    ${ruleAttack}
    Wait Until Element Is Visible    ${ruleDataSourceDetail}   ${Timeout}
    Element Should Contain    ${ruleDataSourceDetail}    ${dataSource}
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Event Type')}   ${Timeout}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Event Type')}    ${eventType}
    Wait Until Element Is Visible    ${ruleDetailsParam.replace('ruleParam', 'Integrations')}   ${Timeout}
    Scroll Element Into View    ${ruleDetailsParam.replace('ruleParam', 'Integrations')}
    Element Should Contain    ${ruleDetailsParam.replace('ruleParam', 'Integrations')}    ${integration}

    Verify the integration relation ids selected in the view rule collapse menu    ${ruleName}    ${relationId1}
    Verify the integration relation ids selected in the view rule collapse menu    ${ruleName}    ${relationId2}

Verify the Monitoring System details of the rule
    [Arguments]     ${ruleDescription}      ${vendorProfile}      ${integration}      ${rulesetGroupValue}
    Click the Monitoring Systems button in view menu of rule
    Wait Until Element Is Visible    xpath=//span[text()='Description']//following::span[1]     ${Timeout}
    Element Should Contain    xpath=//span[text()='Description']//following::span[1]    ${ruleDescription}
    Verify wazuh integration and its ruleset in the monitoring system tab of view rule menu    ${vendorProfile}    ${integration}     ${rulesetGroupValue}

Verify the Rule Details details of the rule
    [Arguments]     ${ruleName}     ${incidentDescription}      ${groupingSelected}
    Click the Rule Details button in view menu of rule
    Wait Until Element Is Visible    xpath=//span[text()='Description']//following::span[1]     ${Timeout}
    Element Should Contain    xpath=//span[text()='Description']//following::span[1]    ${incidentDescription}
    Verify the grouping selected in the view rule collapse menu     ${ruleName}     ${groupingSelected}

Verify the Playbooks details of the rule
    [Arguments]     ${playbookName}
    Click the Playbooks button in view menu of rule
    Wait Until Element Is Visible    xpath=//div[text()='${playbookName}']     ${Timeout}
    Element Should Contain    xpath=//div[text()='${playbookName}']    ${playbookName}

Verify the Companies details of the rule
    [Arguments]     ${companyName}  ${ruleProfile}  ${monitoringProfile}
    Click the Companies button in view menu of rule
    Wait Until Element Is Visible    xpath=//span[text()='${companyName}']  ${Timeout}
    Element Should Contain    xpath=//span[text()='${companyName}']    ${companyName}
    Wait Until Element Is Visible    xpath=//span[text()='${companyName}']//following::span[text()='Rule Profile']//following::span[1]  ${Timeout}
    Element Should Contain    xpath=//span[text()='${companyName}']//following::span[text()='Rule Profile']//following::span[1]    ${ruleProfile}
    Wait Until Element Is Visible    xpath=//span[text()='${companyName}']//following::span[text()='Monitoring Profile']//following::span[1]  ${Timeout}
    Element Should Contain    xpath=//span[text()='${companyName}']//following::span[text()='Monitoring Profile']//following::span[1]    ${monitoringProfile}