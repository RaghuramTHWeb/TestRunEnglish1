*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***
${ONLINE_TEXT}         You're now online!
${OFFLINE_TEXT}        You're offline now!
${PROVIDER_EMAIL}    Replace this message with your provider email
${PROVIDER_PASSWORD}    Replace this message with your provider Password
${CONSUMER_EMAIL}    Replace this message with your Consumer email
${CONSUMER_PASSWORD}    Replace this message with your COnsumer Password
${PROVIDER_PROFILE_URL}    https://app-dev.taskhuman.com/profile/5466/about

*** Test Cases ***

Open and Position Browsers
    Open First Browser
    Open Second Browser

Login as Provider in Incognito
    Switch to Incognito Browser
    Login as Provider
    Ensure Provider is Online

Login as Consumer
    Switch to Normal Browser
    Login as Consumer

Search for Provider and Call
    Search for Provider
    Select Call Topic and Place Call

Accept Call as Provider in Incognito
    Switch to Incognito Browser
    Accept Call
    End Call
Goto Settings and logout as consumer
    Goto Settings and logout as consumer
Goto Settings and logout as Provider
    Goto Settings and logout as Provider

*** Keywords ***

Open First Browser
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=NORM
    Set Window Size    650    1200
    Set Window Position    0    0
    Log    Normal browser size and position set.

Open Second Browser
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=INC    options=add_argument("--incognito")
    Set Window Size    650    1200
    Set Window Position    650    0
    Log    Incognito browser size and position set.

Switch to Incognito Browser
    Switch Browser    INC

Switch to Normal Browser
    Switch Browser    NORM

Login as Provider
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    #Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${PROVIDER_EMAIL}
   # Sleep    5s
    Wait Until Element Is Visible    xpath=//input[@name='password']    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${PROVIDER_PASSWORD}
    #Sleep    5s
    Wait Until Element Is Visible    xpath://button[@value='submit']    5s
    Click Element    xpath://button[@value='submit']
    Sleep    3s

Ensure Provider is Online
    ${online_status_present}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    10s
    ${offline_status_present}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    10s

    Run Keyword If    ${offline_status_present}    Make Online
    Run Keyword If    ${online_status_present}     Provider is Online

Make Online
    Wait Until Element Is Visible    xpath=//button[@id='go_online_now']    10s
    Click Element    xpath=//button[@id='go_online_now']
    Sleep    5s
    Click Element    xpath://button[text()='Save']
    Sleep    5s

Provider is Online
    Log    Provider is now online.
    Sleep    5s

Login as Consumer
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    #Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Click Element    xpath=//input[@name='email']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    #Sleep    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    #Sleep    5s
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

Search for Provider
    Go To    https://app-dev.taskhuman.com/search/name/raghu
    Wait Until Element Is Visible    xpath=//div[@data-testid="action_menu_call_btn"]    10s
    Click Element                    xpath=//div[@data-testid="action_menu_call_btn"]
    Sleep    5s

Select Call Topic and Place Call
    Wait Until Page Contains Element    xpath://*[text()='Select a Topic']    4s
    Wait Until Element Is Visible    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]    10s
    Click Element    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
    Sleep    5s
    Decrement Time Until 10 Minutes

Decrement Time Until 10 Minutes
    Wait Until Element Is Visible    id=time-decreament-icon    10s
    WHILE    True
        ${current_value}=    Get Element Attribute    xpath=//input[@class="chakra-input css-1cjy4zv"]    value
        Run Keyword If    ${current_value} == 10    Exit For Loop
        Click Element    id=time-decreament-icon
        Sleep    1s
    END
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]

Accept Call
    Wait Until Element Is Visible    xpath://*[text()='Accept']
    Click Element    xpath://*[text()='Accept']
    Sleep    30s
    Wait Until Element Is Visible    xpath://*[text()='Got It!']
    Click Element    xpath://*[text()='Got It!']

End Call
    #Wait Until Element Is Visible    xpath://img[4]  # Call ending button
    #Click Element    xpath://img[4]
    Mouse Over    (//button[@aria-label="End Call"])[last()]
    Wait Until Element Is Visible    (//button[@aria-label="End Call"])[last()]    5s
    Click Element    (//button[@aria-label="End Call"])[last()]
    Sleep    5s

Goto Settings and logout as consumer
    Switch Browser    NORM
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']

Goto Settings and logout as Provider
    Switch Browser    INC
    Go To    https://app-dev.taskhuman.com/provider/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']

    Close Browser
