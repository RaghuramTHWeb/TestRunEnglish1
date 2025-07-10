*** Settings ***
Library    SeleniumLibrary


*** Test Cases ***
Open and Position Browsers
    [Documentation]    Opens two browsers and positions them side by side.

    # Open first browser (normal mode)
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=NORM
    Set Window Size    750    750
    Set Window Position    0    0
    Log    Normal browser size and position set.

    # Open second browser (incognito mode)
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=INC    options=add_argument("--incognito")
    Set Window Size    750    750
    Set Window Position    750    0
    Log    Incognito browser size and position set.

Login as Provider in Incognito
    [Documentation]    Logs in as a provider in incognito mode.
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:
    Sleep    8s
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    raghuram.m+rp1@taskhuman.com
    Sleep    5s
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    asdfgh@12345A
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    3s

Take Provider Online
    [Documentation]    Takes provider online or fails if already online.
    Wait Until Element Is Visible    xpath://button[@id='go_online_now']
    Click Element    xpath://button[@id='go_online_now']
    Sleep    5s
    Click Element    xpath://button[text()='Save']
    Sleep    5s

Login as Consumer
    [Documentation]    Logs in as a consumer in normal mode.
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:
    Sleep    8s
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    raghuram.m+rc1@taskhuman.com
    Sleep    5s
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    asdfgh@12345Q
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

Goto Provider Profile
    [Documentation]    Goes to the provider profile page.
    Go To    https://app-dev.taskhuman.com/profile/5466
    Sleep    5s

Call Provider
    [Documentation]    Calls the provider and clicks through the steps.
    Wait Until Element Is Visible    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Click Element    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Sleep    5s
    Wait Until Element Is Visible    css:.CallForm-module__CallForm--ContinueCall__Skill
    Click Element    css:.CallForm-module__CallForm--ContinueCall__Skill
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Click Element    xpath://*[text()='Connect Now']
    Sleep    5s

Accept Call as Provider in Incognito
    [Documentation]    Accepts the call in incognito mode as the provider.
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://*[text()='Accept']
    Click Element    xpath://*[text()='Accept']
    Sleep    50s
    Wait Until Element Is Visible    xpath://*[text()='Got It!']
    Click Element    xpath://*[text()='Got It!']
    Wait Until Element Is Visible    xpath://img[4]
    Click Element    xpath://img[4]
    Sleep    50s
