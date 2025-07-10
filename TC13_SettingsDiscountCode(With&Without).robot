*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!
${PROVIDER_EMAIL}    Replace this message with your provider email
${PROVIDER_PASSWORD}    Replace this message with your provider Password
${CONSUMER_EMAIL}    Replace this message with your Consumer email
${CONSUMER_PASSWORD}    Replace this message with your COnsumer Password


*** Test Cases ***
Validate Menu Section Based on User Type
    Login as consumer
Goto settings and check for Discount code section
    Goto settings and check for Discount code section
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Element Is Visible    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                    xpath=//div[@data-testid="logout_btn"]
    Wait Until Element Is Visible    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                    xpath=//div[@data-testid='confirm_btn']

*** Keywords ***
Login as consumer
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
#    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    Wait Until Element Is Visible    xpath=//input[@name='password']    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    5s
    Click Element    xpath://button[@value='submit']
    Sleep    4s


Goto settings and check for Discount code section
        Go To    https://app-dev.taskhuman.com/settings
        Sleep    5s
        Run Keyword And Ignore Error    Page Should Not Contain    Check for Discounts
    ${status} =    Run Keyword And Return Status    Page Should Contain    Check for Discounts
    Run Keyword If    '${status}' == 'False'    Evaluate User Type
    Sleep    10s

Evaluate User Type
    Wait Until Element Is Visible    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']    8s
    Click Element    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']
    Sleep    5s
    ${internal_user} =    Run Keyword And Return Status    Page Should Contain    Free!
    Run Keyword If    '${internal_user}' == 'True'    Log To Console    Internal user identified
    Run Keyword If    '${internal_user}' == 'False'    Check for Reboot User

Check for Reboot User
    Wait Until Page Contains    Buy Minutes    5s
    Log To Console    Reboot user identified
