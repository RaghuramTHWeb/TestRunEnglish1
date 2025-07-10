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
${SKILL_DETAILS_TITLE}              xpath=//div[contains(@class, 'SkillDetails-module__SkillDetails--header__title')]
${SKILL_DETAILS_PROVIDER_LIST}      xpath=//div[contains(@class, 'SkillDetails-module__SkillDetails--provider__list')]
${SKILL_DETAILS_CALENDAR}           xpath=//div[contains(@class, 'SkillDetails-module__Provider--Availaibility__calendar')]

*** Keywords ***

Login as Consumer
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
Validate user lands on discovery page after login
    Go To    https://app-dev.taskhuman.com/discover
    Wait Until Page Contains    How To Approach This Program    6s

*** Test Cases ***

Login as Consumer in Normal Mode
    # Test case to log in as a consumer in normal mode.
    Login as Consumer
VGoto settings and check for Discount code section
    Goto settings and check for Discount code section
Validate user lands on discovery page after login
    Validate user lands on discovery page after login
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
