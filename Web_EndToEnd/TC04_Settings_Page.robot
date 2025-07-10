*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/Reboot_Consumer_login.robot

*** Test Cases ***
Setting_ Validate discount code section in settings (with and without discount code)
    Login As Consumer    ${NoAmbassador_email}    ${NoAmbassador_password}
    For user with Ambassador "Check for discounts" should be present
    Login As Consumer    ${consumer_email}    ${consumer_password}
    For user with Ambassador "Check for discounts" should not be present
Settings Page_To Validate Preferences section
    Validate Preferences section
Settings Page_To validate Payment method
    validate Payment method
Settings Page_To validate Invite section
    validate Invite section
Settings Page_To validate join a program screen
    validate join a program screen
Settings Page_To validate FAQ section
    validate FAQ section
Settings Page_To validate App feedback section
    validate App feedback section
Settings Page_To validate Notification settings section
    validate Notification settings section
Settings Page_To validate terms and conditions page redirection and content
    validate terms and conditions page redirection and content
Settings Page_ To validate Privacy policy section
    validate Privacy policy section
Settings Page_ Check consumer is able to add cards under payment methods
    Check consumer is able to add cards under payment methods
Settings Page_validate if on adding card it can be made default
    validate if on adding card it can be made default
Settings Page_Validate if added card can be deleted
    Validate if added card can be deleted
Settings Page_Validate if deleted card is not visible
    Validate if deleted card is not visible
    Close Browser
*** Keywords ***
For user with Ambassador "Check for discounts" should be present
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains    Check for Discounts    10s
    Close Browser
For user with Ambassador "Check for discounts" should not be present
    Go To    https://app-dev.taskhuman.com/settings
    Page Should Not Contain    Check for Discounts    10s
Validate Preferences section
    Go To    https://app-dev.taskhuman.com/settings/preferences
    Wait Until Element Is Visible    xpath=//div[@class='SettingComponents-module__Preferences--DeactivateBtn css-0']    10s
validate Payment method
    Go To    https://app-dev.taskhuman.com/settings/payment-method
    Wait Until Element Is Visible    xpath://button[normalize-space()='Add Payment Method']    10s
validate Invite section
    Go To    https://app-dev.taskhuman.com/settings/invite
    Wait Until Element Is Visible    xpath://img[@class='SettingComponents-module__QrImage css-0']    10s
validate join a program screen
    Go To    https://app-dev.taskhuman.com/settings/join-program
    Wait Until Element Is Visible    xpath://div[@class='SettingComponents-module__Discount--Coupons__Icon css-0']    10s
validate FAQ section
        Go To    https://app-dev.taskhuman.com/settings/faq
        Wait Until Element Is Visible    xpath://a[normalize-space()='FAQ']    10s
        Click Element    xpath://a[normalize-space()='FAQ']
        Switch Window    NEW
        Sleep    2s
        Wait Until Location Is    https://taskhuman.com/faq/#employee    10s
validate App feedback section
        Go To    https://app-dev.taskhuman.com/settings/feedback
        Wait Until Element Is Visible    xpath://*[text()='ask@taskhuman.com']    10s
validate Notification settings section
        Go To    https://app-dev.taskhuman.com/settings/notification-settings
        Wait Until Element Is Visible    xpath://p[@class='chakra-text SettingComponents-module__How--Notification--Work--Text css-0']    10s
validate terms and conditions page redirection and content
        Go To    https://app-dev.taskhuman.com/settings/notification-settings
        Wait Until Page Contains    Terms and Conditions    10s
        Click Element    xpath=//*[contains(text(), 'Terms and Conditions')]
        Wait Until Element Is Visible    xpath://a[normalize-space()='Terms and Conditions']    10s
        Click Element    xpath://a[normalize-space()='Terms and Conditions']
        Switch Window    NEW
        Wait Until Location Is    https://taskhuman.com/terms-conditions/    10s
        Location Should Be    https://taskhuman.com/terms-conditions/
validate Privacy policy section
        Go To    url=https://app-dev.taskhuman.com/settings
        Wait Until Page Contains    Privacy Policy    10s
        Click Element    xpath=//*[contains(text(), 'Privacy Policy')]
        Wait Until Element Is Visible    xpath://a[normalize-space()='Privacy Policy']    10s
        Click Element    xpath://a[normalize-space()='Privacy Policy']
        Switch Window    NEW
        Wait Until Location Is    https://taskhuman.com/privacy-policy/    10s
        Location Should Be    https://taskhuman.com/privacy-policy/
Check consumer is able to add cards under payment methods
    Go To    https://app-dev.taskhuman.com/settings/payment-method
    Wait Until Element Is Visible    xpath=//*[text()='Add Payment Method']    10s
    Click Element    xpath=//*[text()='Add Payment Method']
    Wait Until Element Is Visible    xpath=//*[text()='Payment Methods']    10s
    Click Element    xpath=//*[text()='Payment Methods']
    # Input Card Number
    Wait Until Element Is Visible    css=iframe[src*='stripe']    10s
    Select Frame    css=iframe[src*='stripe']
    Wait Until Element Is Visible    css=input[placeholder='Card Number']    15s
    Click Element    css=input[placeholder='Card Number']
    Input Text    css=input[placeholder='Card Number']    4242424242424242
    Unselect Frame
    Wait Until Element Is Visible    css=iframe[src*='componentName=cardExpiry']    10s
    Select Frame    css=iframe[src*='componentName=cardExpiry']
    Wait Until Element Is Visible    css=input[placeholder="MM / YY"]    15s
    Input Text    css=input[placeholder="MM / YY"]    1228
    Unselect Frame
    Wait Until Element Is Visible    css=iframe[src*='componentName=cardCvc']    10s
    Select Frame    css=iframe[src*='componentName=cardCvc']
    Wait Until Element Is Visible    css=input[placeholder="CVV"]    15s
    Input Text    css=input[placeholder="CVV"]    123
    Unselect Frame
validate if on adding card it can be made default
    Wait Until Element Is Visible    xpath=//label[@class='chakra-checkbox PaymentCard-module__CheckBox css-1577qb8']    5s
    Click Element    xpath=//label[@class='chakra-checkbox PaymentCard-module__CheckBox css-1577qb8']
    Wait Until Element Is Visible    xpath=//*[text()='Save']    10s
    Click Element    xpath=//*[text()='Save']

Validate if added card can be deleted
    Wait Until Element Is Visible    xpath://p[@class='chakra-text SettingComponents-module__Card--Number css-0']    10s
    Click Element    xpath://p[@class='chakra-text SettingComponents-module__Card--Number css-0']
    Wait Until Element Is Visible    xpath=//*[text()='Delete']    10s
    Click Element    xpath=//*[text()='Delete']
    Sleep    4s

Validate if deleted card is not visible
    Element Should Not Be Visible    xpath://p[@class='chakra-text SettingComponents-module__Card--Number css-0']    10s
    Close Browser