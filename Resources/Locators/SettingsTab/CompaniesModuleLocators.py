# Companies page locators
SearchCompanyInputField = "//input[@name='findBy']"
CompanyEditIcon = "//div[contains(@class,'table_container_body')]/div/div[3]/span[text()='companyName']//following::button[1]"

# Company detail page sidebar
MonitoringSystemSidebarOption = "//span[text()='Monitoring Systems']"
UsersSidebarOption = "//span[text()='Main']//following::span[text()='Users']"

# Company submodule Monitoring System
AddSiemButton = "//button/span[text()='Add SIEM']"
SearchMonitoringSystemInputField = "//input[@name='search']"
MonitoringSystemNameInputField = "//input[@name='name']"
MonitoringSystemDescriptionInputField = "//textarea[@name='description']"
SelectVendorInputFieldDropdown = "//label[@name='idVendor']//following::input[1]"
HostInputField = "//label[text()='Host']//following::div/div/input[contains(@id,'configuration.host')]"
PortInputField = "//input[@name='configuration.port']"
IndexInputField = "//input[@name='configuration.index']"
SchemeInputField = "//input[@name='configuration.scheme']"
IntegrationPasswordInputField = "//input[@name='configuration.password']"
IntegrationUsernameInputField = "//input[@name='configuration.username']"
RulePathInputField = "//label[@name='configuration.rulePaths']//following::li/input"
TimestampInputField = "//input[@name='configuration.timestampField']"
DeleteMonitoringSystemButton = "(//div[contains(@class,'table_container_body')])[1]/div/div[2]/span[text()='monitoringSystemName']//following::button[2]"
DeleteMonitoringSystemConfirmBtn = "//div/span[text()='DELETE SIEM']//following::button[text()='Delete']"
