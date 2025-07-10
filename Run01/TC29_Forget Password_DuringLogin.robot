*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
During Login_ Validate Back and Login (With Email and Password) functionality
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Sleep    5s
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Wait Until Page Contains    Back
    Sleep    5s
    Wait Until Page Contains    Get a new one
    Click Element    xpath=//*[contains(text(), 'Get a new one')]
    Sleep    5s
    Wait Until Page Contains    Enter your email ID and we’ll send you a one time passcode    5s
    Click Element    xpath=//button[normalize-space()='Cancel']
    Sleep    5s
    Click Element    xpath=//button[@type='button']
    Sleep    5s
    Location Should Be    https://app-dev.taskhuman.com/login
    Sleep    5s


