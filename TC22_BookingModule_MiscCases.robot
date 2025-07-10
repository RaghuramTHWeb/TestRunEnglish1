*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}    Replace this message with your Consumer email
${Password}   Replace this message with your Consumer email
${Expected Inst01}    Open the app at the time of your session to call your coach.
${Expected Inst02}    Cancel any time without penalty before the session starts.
${Expected Inst03}    If the coach doesn’t pick up the call, your minutes will be credited back to your account.
${PROVIDER_EMAIL}    Replace this message with your provider email
${PROVIDER_PASSWORD}    Replace this message with your provider Password
${CONSUMER_EMAIL}    Replace this message with your Consumer email
${CONSUMER_PASSWORD}    Replace this message with your Consumer email
*** Test Cases ***
Open the browser and login as Consumer
     # Logs in as a consumer in normal mode.
    Open Browser    https://app-dev.taskhuman.com/login    Chrome
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    Wait Until Element Is Visible   xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    4s
Check How Booking work is clickable
    Go To    https://app-dev.taskhuman.com/bookings
    Reload Page
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
Validate that 1:1 Sessions/Group Coaching are visible
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'BookingRouteCss-module__SessionType--Tab--Box')]    10s
    Wait Until Element Is Visible    xpath=(//p[contains(@class, 'BookingRouteCss-module__SessionType--Text')])[1]    10s  #1-1sessions
    Wait Until Element Is Visible    xpath=(//p[contains(@class, 'BookingRouteCss-module__SessionType--Text')])[2]    10s    #group coaching
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
