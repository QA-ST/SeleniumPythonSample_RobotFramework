*** Settings ***
Library  SeleniumLibrary
Resource    ../../Utils/Config/TestConfig.robot
Resource    ../../PageObjects/LoginPage.robot
Resource    ../../PageObjects/ResponseTab/ResponseTab.Sidebar.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulePage.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/Rule.Playbooks.robot
Resource    ../../PageObjects/ResponseTab/RulesModule/RulesSideMenu.robot
Variables   ../../Utils/EnvironmentVariables.py
Variables   ../../Resources/TestData/ResponseTabTestData/RulesModuleTestData.py

Suite Setup     Setup browser context and Navigate to the web app    ${DevUrl}    ${ChromeBrowser}
Suite Teardown      Destroy browser context

*** Test Cases ***
To verify user is able to edit playbook
    Given User enters username and password   ${MssUserUsername_Dev}     ${MssUserPassword_Dev}
    And User clicks the Login button
    And Click the response tab sidebar hamburger option
    And Navigate to Rules page from the hambuger menu
    And Verify the Rule is present in the list of rules    ${RuleNameToTestPlaybook}
    And Click the edit icon for the rule    ${RuleNameToTestPlaybook}
    And Navigate to Playbooks page from side menu option
    And Search playbook from the list    ${TestPlaybookName}
    And Verify the playbook is present in the playbooks list    ${TestPlaybookName}
    When Click the edit icon for the playbook    ${TestPlaybookName}
    And Enter the name of the playbook    ${TestPlaybookNameEdited}
    And Edit phase step in the playbook    ${PreparationPhaseName}    ${TestMssPreparationPhaseStep}    ${TestMssPreparationPhaseStepEdited}
    And Edit phase step in the playbook    ${IdentificationPhaseName}    ${TestMssIdentificationPhaseStep}    ${TestMssIdentificationPhaseStepEdited}
    And Edit phase step in the playbook    ${ContainmentPhaseName}    ${TestCompanyContainmentPhaseStep}    ${TestCompanyContainmentPhaseStepEdited}
    And Edit phase step in the playbook    ${EradicationPhaseName}    ${TestCompanyEradicationPhaseStep}    ${TestCompanyEradicationPhaseStepEdited}
    And Edit phase step in the playbook    ${RecoveryPhaseName}    ${TestMssRecoveryPhaseResponsible}    ${TestMssRecoveryPhaseResponsibleEdited}
    And Add Comment in the Versioning tab for the playbook    ${TestVersioningReviewComment2}
    And Save Rule information entered

Verify the details edited in the playbook
    Given Search playbook from the list    ${TestPlaybookNameEdited}
    And Verify the playbook is present in the playbooks list    ${TestPlaybookNameEdited}
    When Click the edit icon for the playbook    ${TestPlaybookNameEdited}
    Then Verify the phase step is present in the playbook    ${PreparationPhaseName}    ${TestMssPreparationPhaseStepEdited}
    And Verify the phase step is present in the playbook    ${IdentificationPhaseName}    ${TestMssIdentificationPhaseStepEdited}
    And Verify the phase step is present in the playbook    ${ContainmentPhaseName}    ${TestCompanyContainmentPhaseStepEdited}
    And Verify the phase step is present in the playbook    ${EradicationPhaseName}    ${TestCompanyEradicationPhaseStepEdited}
    And Verify the phase step is present in the playbook    ${RecoveryPhaseName}    ${TestMssRecoveryPhaseResponsibleEdited}
    And User logout from the application