# Header elements
UserProfileImage = "(//header[@id='header-main']//following::div//img)[1]"
LogoutButton = "//ul//button[text()='Logout']"
SettingsButton = "//button//span[text()='Settings']"
ResponseButton = "//button//span[text()='Response']"

SidebarHamburgerMenuOption = "//div[@id='container-sidebar-title']//div[1]//button"
PageLoadSpinner = "//*[local-name()='svg' and contains(@class,'animate-spin')]"
SaveButton = "//button/span[text()='Save']"
QuitWithoutSavingButton = "//section//span[text()='Unsaved Changes']//following::button[text()='Quit without Saving']"
CancelButton = "//button/span[text()='Cancel']"
SearchIcon = "//input[@name='search']//following::*[local-name()='svg'][2]"
ToggleSwitchStatus = "//input[contains(@class,'dz_input-switch__input')]"
