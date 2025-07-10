*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!
${PROVIDER_EMAIL}    raghuram.m+rp1@taskhuman.com
${PROVIDER_PASSWORD}    asdfgh@12345A
${CONSUMER_EMAIL}    raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}    asdfgh@12345Q

*** Keywords ***
Login as Provider in Incognito
    # Logs in as a provider in incognito mode.
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:
    Sleep    8s
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    ${PROVIDER_EMAIL}
    Sleep    5s
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    ${PROVIDER_PASSWORD}
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    3s

    # Determine page status and handle accordingly
    ${online_status_present}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    10s
    ${offline_status_present}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    10s

    Run Keyword If    ${offline_status_present}    Make Online
    Run Keyword If    ${online_status_present}     Provider is Online

Make Online
    Wait Until Element Is Visible    xpath://button[@id='go_online_now']    10s
    Click Element    xpath://button[@id='go_online_now']
    Sleep    5s
    Click Element    xpath://button[text()='Save']
    Sleep    5s

Provider is Online
    Sleep    5s

Login as Consumer
    # Logs in as a consumer in normal mode.
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:
    Sleep    8s
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    ${CONSUMER_EMAIL}
    Sleep    5s
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    ${CONSUMER_PASSWORD}
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

Goto Provider Profile
    # Goes to the provider profile page.
    Go To    https://app-dev.taskhuman.com/profile/5466
    Sleep    5s

Call Provider
    # Calls the provider and clicks through the steps.
    Wait Until Element Is Visible    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Click Element    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'CallForm-module__CallForm--ContinueCall__Skill') and contains(@class, 'css-0') and text()='AK skill']    20s
    Click Element    xpath=//div[contains(@class, 'CallForm-module__CallForm--ContinueCall__Skill') and contains(@class, 'css-0') and text()='AK skill']
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Click Element    xpath://*[text()='Connect Now']
    Sleep    5s

Accept Call as Provider in Incognito
    # Accepts the call in incognito mode as the provider.
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://*[text()='Decline']
    #Click Element    xpath://*[text()='Decline']
    Sleep    70s
    #Wait Until Element Is Visible    xpath://*[text()='Got It!']
    #Click Element    xpath://*[text()='Got It!']
    #Wait Until Element Is Visible    xpath://img[4]
    #Click Element    xpath://img[4]
    #Sleep    10s
    Switch Browser    NORM
    Location Should Be    https://app-dev.taskhuman.com/profile/5466
    Sleep    3s

*** Test Cases ***
Open and Position Browsers
    # Opens two browsers and positions them side by side.
    # Open first browser (normal mode)
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=NORM
    Set Window Size    650    1200
    Set Window Position    0    0
    Log    Normal browser size and position set.

    # Open second browser (incognito mode)
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=INC    options=add_argument("--incognito")
    Set Window Size    650    1200
    Set Window Position    650    0
    Log    Incognito browser size and position set.

Login as Provider in Incognito Mode
    # Test case to log in as a provider in incognito mode.
    Login as Provider in Incognito

Login as Consumer in Normal Mode
    # Test case to log in as a consumer in normal mode.
    Login as Consumer

Goto Provider Profile and make online if found offline
    # Test case to go to the provider profile page.
    Goto Provider Profile

Call Provider
    # Test case to call the provider.
    Call Provider

Accept Call as Provider and wait insession for 1m and end the call
    # Test case to accept the call as a provider in incognito mode.
    Accept Call as Provider in Incognito
