*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Before login_ Validate redirection of terms and conditions, Privacy Policy on Prelogin page
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Page Contains    Terms & Conditions    5s
    Click Element    xpath=//*[contains(text(), 'Terms & Conditions')]
    Switch Window    NEW
    Wait Until Location Is    https://taskhuman.com/terms-conditions/    5s
    Location Should Be    https://taskhuman.com/terms-conditions/
    Go To    https://app-dev.taskhuman.com/login
    Wait Until Element Is Visible    xpath://a[normalize-space()='Privacy Policy']
    Click Element    xpath://a[normalize-space()='Privacy Policy']
    Sleep    3s
    Switch Window    NEW
    Wait Until Location Is    https://taskhuman.com/privacy-policy/    5s
    Location Should Be    https://taskhuman.com/privacy-policy/
    Sleep    3s

