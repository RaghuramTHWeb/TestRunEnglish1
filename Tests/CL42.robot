*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q
${Expected Inst01}    Open the app at the time of your session to call your coach.
${Expected Inst02}    Cancel any time without penalty before the session starts.
${Expected Inst03}    If the coach doesn’t pick up the call, your minutes will be credited back to your account.

*** Test Cases ***
Open the browser and login as Consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Wait Until Element Is Visible    id:field-:r0:    10s   #emailfield
    Sleep    5s
    Input Text    id:field-:r0:    ${email}
    Input Text    id:field-:r1:    ${Password}
    Click Element    xpath://button[@value='submit']
    Sleep    5s
Check How Booking work is clickable
    Go To    https://app-dev.taskhuman.com/bookings
    Wait Until Element Is Visible    xpath=//p[@class='chakra-text BookingRouteCss-module__BookingWork--Text css-0']
    Click Element    xpath=//p[@class='chakra-text BookingRouteCss-module__BookingWork--Text css-0']
    Sleep    5s
Validate if 3 instructions are visible
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'Open the app at the time of your session to call your coach.')]    10s
    ${actual_text}=    Get Text    xpath=//div[contains(text(), 'Open the app at the time of your session to call your coach.')]
    Should Be Equal    ${actual_text}    ${Expected Inst01}
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'Cancel any time without penalty before the session starts.')]    10s
    ${actual_text}=    Get Text    xpath=//div[contains(text(), 'Cancel any time without penalty before the session starts.')]
    Should Be Equal    ${actual_text}    ${Expected Inst02}
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'If the coach doesn’t pick up the call, your minutes will be credited back to your account.')]    10s
    ${actual_text}=    Get Text    xpath=//div[contains(text(), 'If the coach doesn’t pick up the call, your minutes will be credited back to your account.')]
    Should Be Equal    ${actual_text}    ${Expected Inst03}
    Sleep    2s
    Wait Until Element Is Visible    xpath://*[text()='Got It!']
    Click Element    xpath://*[text()='Got It!']
    Sleep    6s