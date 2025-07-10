*** Settings ***
Library    SeleniumLibrary
Documentation    MiscCases validation: Settings Module

*** Test Cases ***
Login with valid Credentials
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    sleep    5s
    Wait Until Element Is Visible    id:field-:r0:
    sleep    5s
    Input Text    id:field-:r0:    raghuram.m+rc1@taskhuman.com
    Input Text    id:field-:r1:    asdfgh@12345Q
    Wait Until Element Is Visible    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']    10s
    Click Element    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']
    sleep    5s
Goto settings and validate terms and conditions page redirection and content
        Wait Until Element Is Visible    xpath://a[@href='/settings']
        Click Element    xpath://a[@href='/settings']
        Sleep    3s
        Wait Until Element Is Visible    xpath://p[@class='SettingsRoute-module__active']
        Click Element    xpath://p[@class='SettingsRoute-module__active']
        Sleep    3s
        Wait Until Page Contains    Terms and Conditions
        Click Element    xpath=//*[contains(text(), 'Terms and Conditions')]
        Sleep    3s
        Wait Until Element Is Visible    xpath://a[normalize-space()='Terms and Conditions']
        Click Element    xpath://a[normalize-space()='Terms and Conditions']
        Sleep    3s
        Switch Window    NEW
        Sleep    3s
        Wait Until Location Is    https://taskhuman.com/terms-conditions/    5s
        Location Should Be    https://taskhuman.com/terms-conditions/
        Sleep    3s
        Go To    url=https://app-dev.taskhuman.com/settings
        Sleep    3s
To validate Privacy policy section
        Wait Until Page Contains    Privacy Policy
        Click Element    xpath=//*[contains(text(), 'Privacy Policy')]
        Sleep    3s
        Wait Until Element Is Visible    xpath://a[normalize-space()='Privacy Policy']
        Click Element    xpath://a[normalize-space()='Privacy Policy']
        Sleep    3s
        Switch Window    NEW
        Wait Until Location Is    https://taskhuman.com/privacy-policy/    5s
        Location Should Be    https://taskhuman.com/privacy-policy/
        Sleep    3s
To Validate Preferences section
        Go To    https://app-dev.taskhuman.com/settings/preferences
        Sleep    3s
        Wait Until Element Is Visible    xpath=//div[@class='SettingComponents-module__Preferences--DeactivateBtn css-0']
        Sleep    3s
To validate Payment method
        Go To    https://app-dev.taskhuman.com/settings/payment-method
        Wait Until Element Is Visible    xpath://button[normalize-space()='Add Payment Method']
        Sleep    3s
To validate Invite section
        Go To    https://app-dev.taskhuman.com/settings/invite
        Wait Until Element Is Visible    xpath://img[@class='SettingComponents-module__QrImage css-0']
        Sleep    3s
To validate join a program screen
        Go To    https://app-dev.taskhuman.com/settings/join-program
        Wait Until Element Is Visible    xpath://div[@class='SettingComponents-module__Discount--Coupons__Icon css-0']
        Sleep    3s
To validate FAQ section
        Go To    https://app-dev.taskhuman.com/settings/faq
        Wait Until Element Is Visible    xpath://a[normalize-space()='FAQ']
        Click Element    xpath://a[normalize-space()='FAQ']
        Sleep    3s
        Switch Window    NEW
        Wait Until Location Is    https://taskhuman.com/faq/#employee    5s
        Location Should Be    https://taskhuman.com/faq/#employee
        Sleep    3s
To validate App feedback section
        Go To    https://app-dev.taskhuman.com/settings/feedback
        Wait Until Element Is Visible    xpath://div[@class='SettingComponents-module__Feedback--Logo css-0']
        Sleep    3s
To validate Notification settings section
        Go To    https://app-dev.taskhuman.com/settings/notification-settings
        Wait Until Element Is Visible    xpath://p[@class='chakra-text SettingComponents-module__How--Notification--Work--Text css-0']
        Sleep    3s
