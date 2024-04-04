*** Settings ***
Library     SeleniumLibrary
Resource    ../../Helpers/CommonMethods.robot
Variables   ../../Resources/Locators/SettingsTab/UsersModuleLocators.py

*** Keywords ***
Click the add user button
    Wait for table page load spinner
    Wait Until Element Is Visible    ${AddUserButton}   ${Timeout}
    Click Element    ${AddUserButton}
    Wait Until Element Is Visible    xpath=//label[@name='firstName']  ${Timeout}

Enter the name of the user
    [Arguments]     ${firstName}    ${lastName}
    Wait Until Element Is Visible    ${UserFirstNameInputField}     ${Timeout}
    Input Text    ${UserFirstNameInputField}    ${EMPTY}
    Input Text    ${UserFirstNameInputField}    ${firstName}
    Wait Until Element Is Visible    ${UserLastNameInputField}  ${Timeout}
    Input Text    ${UserLastNameInputField}    ${EMPTY}
    Input Text    ${UserLastNameInputField}    ${lastName}

Enter the user email
    [Arguments]     ${userEmail}
    Wait Until Element Is Visible    ${UserEmailInputField}     ${Timeout}
    Input Text    ${UserEmailInputField}    ${EMPTY}
    Input Text    ${UserEmailInputField}    ${userEmail}

Enter the user phone number
    [Arguments]     ${userPhone}
    Wait Until Element Is Visible    ${UserTelephoneField}     ${Timeout}
    Input Text    ${UserTelephoneField}    ${EMPTY}
    Input Text    ${UserTelephoneField}    ${userPhone}

Select user language and timezone
    [Arguments]     ${userLanguage}     ${userTimezone}
    Wait Until Element Is Visible    ${UserLanguageField}   ${Timeout}
    Input Text    ${UserLanguageField}    ${EMPTY}
    Input Text    ${UserLanguageField}    ${userLanguage}
    Sleep    1
    Press Keys  ${UserLanguageField}    RETURN
    Wait Until Element Is Visible    ${UserTimezoneField}   ${Timeout}
    Input Text    ${UserTimezoneField}    ${EMPTY}
    Input Text    ${UserTimezoneField}    ${userTimezone}
    Sleep    1
    Press Keys  ${UserTimezoneField}    RETURN

Select user role
    [Arguments]     ${userRole}
    Wait Until Element Is Visible    ${UserRoleInputField}  ${Timeout}
    Scroll Element Into View    ${UserRoleInputField}
    Input Text    ${UserRoleInputField}    ${EMPTY}
    Input Text    ${UserRoleInputField}    ${userRole}
    Wait Until Element Is Visible    xpath=//input[@name='idRoleProfiles[0]']//preceding::div[1]    ${Timeout}
    Scroll Element Into View    xpath=//input[@name='idRoleProfiles[0]']//preceding::div[1]
    Sleep    1
    Click Element    xpath=//input[@name='idRoleProfiles[0]']//preceding::div[1]

Save the new user details entered
    Wait Until Element Is Visible    ${SaveButton}  ${Timeout}
    Scroll Element Into View    ${SaveButton}
    Sleep    1
    Click Element    ${SaveButton}
    Wait Until Element Is Visible    xpath=//div/span[contains(text(),'User has been created')]     ${Timeout}
    Wait Until Element Is Visible    ${PageLoadSpinner}     ${Timeout}
    Wait Until Element Is Not Visible    ${PageLoadSpinner}     ${Timeout}

Save the updated user details
    Wait Until Element Is Visible    ${SaveButton}  ${Timeout}
    Scroll Element Into View    ${SaveButton}
    Sleep    1
    Click Element    ${SaveButton}
    Wait Until Element Is Visible    xpath=//div/span[contains(text(),'User has been updated')]     ${Timeout}
    Wait Until Element Is Not Visible    xpath=//div/span[contains(text(),'User has been updated')]     ${Timeout}
    Wait Until Element Is Visible    xpath=//h4[text()='User']  ${Timeout}

Activate the user
    Wait Until Element Is Visible    ${UserActivateToggleSwitch}    ${Timeout}
    ${activateSwitchStatus}     Run Keyword And Return Status    Checkbox Should Be Selected    ${UserActivateToggleSwitch}${ToggleSwitchStatus}
    IF    ${activateSwitchStatus}
        Log To Console    User is active
    ELSE
        Click Element    ${UserActivateToggleSwitch}
        Checkbox Should Be Selected    ${UserActivateToggleSwitch}${ToggleSwitchStatus}
        Log To Console    User is active
    END

Navigate back to the users list page
    Wait Until Element Is Visible    ${NavigateBackToUsersListPageButton}   ${Timeout}
    Click Element    ${NavigateBackToUsersListPageButton}
    Wait Until Element Is Visible    xpath=//h4[text()='Users']     ${Timeout}

Search user
    [Arguments]     ${userUsername}
    Wait for table page load spinner
    Wait Until Element Is Visible    ${UserSearchBar}   ${Timeout}
    Input Text    ${UserSearchBar}    ${EMPTY}
    Input Text    ${UserSearchBar}    ${userUsername}
    Click the search icon for the search performed
    Wait for table page load spinner

Verify the user is present in the users list
    [Arguments]     ${userUsername}     ${userEmail}    ${userLanguage}
    ${userStatus}   Set Variable    ''
    Wait for table page load spinner
    Sleep    1
    ${usersLocator}     Get WebElements    xpath=(//div[contains(@class,'table_container')])[1]//following::div[@class='relative']//div[contains(@class,'body_item')][2]/span
    FOR    ${userNameLocator}    IN    @{usersLocator}
        Wait Until Element Is Visible    ${userNameLocator}     ${Timeout}
        ${userUsernameMatchStatus}  Run Keyword And Return Status    Element Should Contain    ${userNameLocator}    ${userUsername}
        IF    ${userUsernameMatchStatus}
            ${userStatus}   Set Variable    ${True}
            ${userEmailLocator}     Set Variable    xpath=(//div[contains(@class,'table_container')])[1]//following::div[@class='relative']//div[contains(@class,'body_item')][2]/span[contains(text(),'${userUsername}')]//following::div[1]/span
            Wait Until Element Is Visible   ${userEmailLocator}     ${Timeout}
            Element Should Contain    ${userEmailLocator}    ${userEmail}
            ${userLanguageLocator}  Set Variable    xpath=(//div[contains(@class,'table_container')])[1]//following::div[@class='relative']//div[contains(@class,'body_item')][2]/span[contains(text(),'${userUsername}')]//following::div[2]/span
            Wait Until Element Is Visible   ${userLanguageLocator}     ${Timeout}
            Element Should Contain    ${userLanguageLocator}    ${userLanguage}
            BREAK
        END
    END
    Run Keyword If    ${userStatus}
    ...    Log To Console    ${userUsername} user is present in the users list
    ...  ELSE
    ...    Fail     ${userUsername} user not found

Verify the user is active
    [Arguments]     ${userUsername}
    ${userActiveStatus}     Set Variable    ''
    Wait Until Element Is Visible    ${UserActiveToggleSwitch.replace('userUsername', '${userUsername}')}   ${Timeout}
    ${userActiveStatus}     Run Keyword And Return Status    Checkbox Should Be Selected    ${UserActiveToggleSwitch.replace('userUsername', '${userUsername}')}${ToggleSwitchStatus}
    IF    ${userActiveStatus}
        Log To Console    ${userUsername} user is active
    ELSE
        Fail    ${userUsername} is not active
    END

Click the edit icon for the user
    [Arguments]     ${userUserName}
    Wait for table page load spinner
    Sleep    1
    ${usersLocator}     Get WebElements    xpath=(//div[contains(@class,'table_container')])[1]//following::div[@class='relative']//div[contains(@class,'body_item')][2]/span
    FOR    ${userNameLocator}    IN    @{usersLocator}
        Wait Until Element Is Visible    ${userNameLocator}     ${Timeout}
        ${userUsernameMatchStatus}  Run Keyword And Return Status    Element Should Contain    ${userNameLocator}    ${userUsername}
        IF    ${userUsernameMatchStatus}
            Wait Until Element Is Visible    ${UserEditIcon.replace('userUsername', '${userUserName}')}   ${Timeout}
            Click Element    ${UserEditIcon.replace('userUsername', '${userUserName}')}
            Wait Until Element Is Visible    locator
            BREAK
        END
    END

Click the delete icon for the user
    [Arguments]     ${userUserName}
    Wait for table page load spinner
    Sleep    1
    ${usersLocator}     Get WebElements    xpath=(//div[contains(@class,'table_container')])[1]//following::div[@class='relative']//div[contains(@class,'body_item')][2]/span
    FOR    ${userNameLocator}    IN    @{usersLocator}
        Wait Until Element Is Visible    ${userNameLocator}     ${Timeout}
        ${userUsernameMatchStatus}  Run Keyword And Return Status    Element Should Contain    ${userNameLocator}    ${userUsername}
        IF    ${userUsernameMatchStatus}
            Wait Until Element Is Visible    ${UserDeleteIcon.replace('userUsername', '${userUserName}')}   ${Timeout}
            Click Element    ${UserDeleteIcon.replace('userUsername', '${userUserName}')}
            Wait Until Element Is Visible    ${UserDeletePopup}     ${Timeout}
            BREAK
        END
    END

Confirm the delete user verification popup
    Wait Until Element Is Visible    ${UserDeletePopup}     ${Timeout}
    Wait Until Element Is Visible    ${UserDeleteConfirmButton}     ${Timeout}
    Click Element    ${UserDeleteConfirmButton}
    Wait Until Element Is Visible    xpath=//span[contains(text(),'User has been deleted')]     ${Timeout}
    Wait Until Element Is Not Visible    xpath=//span[contains(text(),'User has been deleted')]     ${Timeout}
    Wait for table page load spinner

Verify the users table is empty
    Wait for table page load spinner
    ${usersTableStatus}     Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[contains(@class,'dz_table_container')]//following::span[text()='Not found data']      ${Timeout}
    IF    ${usersTableStatus}
        ${tableStatus}  Get Text    xpath=//div[contains(@class,'dz_table_container')]//following::span[text()='Not found data']
        Should Contain    ${tableStatus}    Not found data
    ELSE
        Fail    Users table is not empty
    END