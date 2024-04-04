AddUserButton = "//button/span[text()='Add User']"
UserEditIcon = "(//div[contains(@class,'table_container')])[1]//following::div[@class='relative']//div[contains(@class,'body_item')][2]/span[contains(text(),'userUsername')]//following::div[3]//button[2]"
UserDeleteIcon = "(//div[contains(@class,'table_container')])[1]//following::div[@class='relative']//div[contains(@class,'body_item')][2]/span[contains(text(),'userUsername')]//following::div[3]//button[3]"
UserDeletePopup = "//section//span[text()='DELETE USER']"
UserDeleteConfirmButton = "//section//span[text()='DELETE USER']//following::button[text()='Delete']"
UserSearchBar = "//h4[text()='Users']//following::input[@name='search']"
UserActiveToggleSwitch = "(//div[contains(@class,'table_container')])[1]//following::div[@class='relative']//div[contains(@class,'body_item')][2]/span[contains(text(),'userUsername')]//preceding::div[contains(@class,'dz_input-switch__container')][1]"

# Add user page locators
UserFirstNameInputField = "//input[@name='firstName']"
UserLastNameInputField = "//input[@name='lastName']"
UserEmailInputField = "//input[@name='email']"
UserTelephoneField = "//input[@name='telephone']"
UserLanguageField = "//label[text()='Language']/following::input[1]"
UserTimezoneField = "//label[text()='Timezone']/following::input[1]"
UserRoleInputField = "//h6[text()='Roles']/following::input[1]"
UserActivateToggleSwitch = "//div[contains(@class,'dz_input-switch__container')]"
NavigateBackToUsersListPageButton = "//h4[text()='User']//preceding::button[1]/*[local-name()='svg']"
