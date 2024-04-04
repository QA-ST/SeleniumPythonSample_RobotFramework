*** Settings ***
Library  SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Playbooks.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Main.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py
Variables   ../../Resources/TestData/CommonTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown      Destroy browser context

*** Test Cases ***
To verify user is able to add new Playbook
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to Rules page from the hambuger menu
    And Add rule to test playbook
    And Navigate to Playbooks page from side menu option
    When Click the Add Playbook button
    And Enter the name of the playbook    ${TestPlaybookName}
    And Select Advance visibility for the playbook    ${DiazeroCompany_Company}
    And Add preparation phase step for the playbook
    And Add identification phase steps for the playbook
    And Add containment phase steps for the playbook
    And Add eradication phase steps for the playbook
    And Add recovery phase steps for the playbook
    And Add lessons learned in the playbook
    And Add comments in the playbook
    And Add Comment in the Versioning tab for the playbook    ${TestVersioningReviewComment}
    And Save Rule information entered
    And Search playbook from the list    ${TestPlaybookName}
    Then Verify the playbook is present in the playbooks list    ${TestPlaybookName}
    And Activate Playbook   ${TestPlaybookName}
    And Reload Page

Verify the details of the playbook added
    Given Search playbook from the list    ${TestPlaybookName}
    And Verify the playbook is present in the playbooks list    ${TestPlaybookName}
    When Click the edit icon for the playbook    ${TestPlaybookName}
    Then Verify the phase step is present in the playbook    ${PreparationPhaseName}    ${TestMssPreparationPhaseStep}
    And Verify the phase step is present in the playbook    ${IdentificationPhaseName}    ${TestMssIdentificationPhaseStep}
    And Verify the phase step is present in the playbook    ${IdentificationPhaseName}    ${TestCompanyIdentificationPhaseStep}
    And Verify the phase step is present in the playbook    ${ContainmentPhaseName}    ${TestCompanyContainmentPhaseStep}
    And Verify the phase step is present in the playbook    ${ContainmentPhaseName}    ${TestMssContainmentPhaseStep}
    And Verify the phase step is present in the playbook    ${EradicationPhaseName}    ${TestCompanyEradicationPhaseStep}
    And Verify the phase step is present in the playbook    ${RecoveryPhaseName}    ${TestMssRecoveryPhaseResponsible}
    And Verify the phase step is present in the playbook    ${RecoveryPhaseName}    ${TestCompanyRecoveryPhaseStep}
    And Verify the lessons learned is addded in the playbook    ${TestLessonsLearned1}
    And Verify the lessons learned is addded in the playbook    ${TestLessonsLearned2}
    And Verify the comments is added in the playbook    ${TestComment1}
    And Verify the comments is added in the playbook    ${TestComment2}
    And Verify the versioning comment is added in the playbook    ${TestVersioningReviewComment}
    And User logout from the application

*** Keywords ***
Add rule to test playbook
    Click the Add Rule button
    Enter the name of the rule      ${RuleNameToTestPlaybook}
    Select Integration for the rule    ${WazuhMonitoringSystem}
    Select Wazuh Relation Id for integration selected    ${Wazuh001_RelationId}
    Select Wazuh Relation Id for integration selected    ${Wazuh002_RelationId}
    Reload Page
    Remove Relation Id from Rule    ${Wazuh001_RelationId}
    Remove Relation Id from Rule    ${Wazuh002_RelationId}

Add preparation phase step for the playbook
    Add phase type and step in playbook    ${PreparationPhaseName}    ${MssPhaseType}    ${TestMssPreparationPhaseStep}    ${AddPreparationStepButton}

Add identification phase steps for the playbook
    Add phase type and step in playbook    ${IdentificationPhaseName}    ${MssPhaseType}    ${TestMssIdentificationPhaseStep}    ${AddIdentificationStepButton}
    Add phase type and step in playbook    ${IdentificationPhaseName}    ${CompanyPhaseType}    ${TestCompanyIdentificationPhaseStep}    ${AddIdentificationStepButton}

Add containment phase steps for the playbook
    Add phase type and step in playbook    ${ContainmentPhaseName}    ${CompanyPhaseType}    ${TestCompanyContainmentPhaseStep}    ${AddContainmentStepButton}
    Add phase type and step in playbook    ${ContainmentPhaseName}    ${MssPhaseType}    ${TestMssContainmentPhaseStep}    ${AddContainmentStepButton}

Add eradication phase steps for the playbook
    Add phase type and step in playbook    ${EradicationPhaseName}    ${CompanyPhaseType}    ${TestCompanyEradicationPhaseStep}    ${AddEradicationStepButton}

Add recovery phase steps for the playbook
    Add Recovery phase step    ${MssPhaseType}    ${TestMssRecoveryPhaseResponsible}
    Add Recovery phase step    ${CompanyPhaseType}    ${TestCompanyRecoveryPhaseStep}

Add lessons learned in the playbook
    Add lessons learned for the playbook    ${TestLessonsLearned1}
    Add lessons learned for the playbook    ${TestLessonsLearned2}

Add comments in the playbook
    Add comment in the Comments tab for the playbook    ${TestComment1}
    Add comment in the Comments tab for the playbook    ${TestComment2}