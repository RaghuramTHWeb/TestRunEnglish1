*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/PreloginArabicSelection.robot
Suite Teardown    Close All Browsers

*** Variables ***
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!
${PROVIDER_EMAIL}    raghuram.m+rp1@taskhuman.com
${PROVIDER_PASSWORD}    asdfgh@12345A
${CONSUMER_EMAIL}    raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}    asdfgh@12345Q

*** Test Cases ***
Check for language in Arabic and switch if needed
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Ensure Arabic Language Selected

Open the browser and login as Consumer
   # Open Browser   https://app-dev.taskhuman.com/login    chrome
   # Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    Wait Until Element Is Visible    xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    3s

Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    #Sleep    3s
    Wait Until Element Is Visible    xpath=//div[@data-testid='logout_btn']    10s
    Click Element                    xpath=//div[@data-testid='logout_btn']
     Wait Until Element Is Visible    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                    xpath=//div[@data-testid='confirm_btn']
    Close Browser

