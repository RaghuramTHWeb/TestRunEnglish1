*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/BrowserKeywords.robot
Suite Teardown    Close All Browsers

*** Variables ***
${ONLINE_TEXT}         You're now online!
${OFFLINE_TEXT}        You're offline now!
${PROVIDER_EMAIL}      raghuram.m+rp1@taskhuman.com
${PROVIDER_PASSWORD}   asdfgh@12345A
${CONSUMER_EMAIL}      raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}   asdfgh@12345Q
${PROVIDER_PROFILE_URL}    https://app-dev.taskhuman.com/profile/5466/about
${CALL_DURATION}       10
${EXTENDED_CALL_TIME}  550  # 9 minutes and 10 seconds for extension

*** Test Cases ***
Login as Provider and Make Online
    Open and Position Browsers
    Login as Provider in Incognito
    Check Provider Status

Login as Consumer
    Open and Position Browsers
    Login as Consumer in Normal Mode

Goto Provider Profile and Place Call
    Go To Provider Profile
    Place Call for ${CALL_DURATION} minutes

Accept Call as Provider in Incognito
    Accept Incoming Call as Provider

Extend Call for ${EXTENDED_CALL_TIME} seconds
    Extend Call Duration
Goto Settings and logout as consumer
    Goto Settings and logout as consumer
Goto Settings and logout as Provider
    Goto Settings and logout as Provider


*** Keywords ***
Open and Position Browsers
    # Opens two browsers and positions them side by side.
    # Open first browser (normal mode)

    Open Browser With Unique Profile    https://app-dev.taskhuman.com/login    NORM
    Set Window Size    650    1200
    Set Window Position    0    0
    Log    Normal browser size and position set.

    Sleep    8s    # ✅ Add this to stagger browser launches in CI

    # Open second browser (incognito mode)
    # Changed to use Open Browser With Unique Profile
    # The --incognito option is part of the ${CHROME_BASE_OPTIONS} variable now in BrowserKeywords.robot
    Open Browser With Unique Profile    https://app-dev.taskhuman.com/login    INC
    Set Window Size    650    1200
    Set Window Position    650    0
    Log    Incognito browser size and position set.

Login as Provider in Incognito
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    #Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${PROVIDER_EMAIL}
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//input[@name='password']    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${PROVIDER_PASSWORD}
    #Sleep    5s
    Wait Until Element Is Visible    xpath://button[@value='submit']    5s
    Click Element    xpath://button[@value='submit']
    Sleep    3s

Check Provider Status
    ${online_status_present}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    10s
    ${offline_status_present}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    10s

    Run Keyword If    ${offline_status_present}    Make Online
    Run Keyword If    ${online_status_present}     Provider is Online

Make Online
    Wait Until Element Is Visible    xpath=//button[@id='go_online_now']    10s
    Click Element    xpath=//button[@id='go_online_now']
    Sleep    5s
    Click Element    xpath=//button[text()='Save']
    Sleep    5s

Provider is Online
    Log    Provider is now online.
    Sleep    5s

Login as Consumer in Normal Mode
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    #Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    #Sleep    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    #Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

Go To Provider Profile
    Go To    ${PROVIDER_PROFILE_URL}
    Sleep    3s
    Wait Until Element Is Visible    xpath=//img[@src='/63e8644ad289ec350b93.svg' and contains(@class, 'chakra-image css-0')]    10s
    Click Element    xpath=//img[@src='/63e8644ad289ec350b93.svg' and contains(@class, 'chakra-image css-0')]
    Sleep    5s

Place Call for ${CALL_DURATION} minutes
    Wait Until Page Contains Element    xpath://*[text()='Select a Topic']    4s
    Wait Until Element Is Visible    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]    10s
    Click Element    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]
    #Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Next']    5s
    Click Element    xpath://*[text()='Next']
    #Sleep    5s
    Decrement Value Until ${CALL_DURATION} and call

Decrement Value Until ${CALL_DURATION} and call
    Wait Until Element Is Visible    id=time-decreament-icon    10
    WHILE    True
        ${current_value}=    Get Element Attribute    xpath=//input[@class="chakra-input css-1cjy4zv"]    value
        Run Keyword If    ${current_value} == ${CALL_DURATION}    Exit For Loop
        Click Element    id=time-decreament-icon
        Sleep    1s
    END
    Wait Until Element Is Visible   xpath://*[text()='Next']    5s 
    Click Element    xpath://*[text()='Next']
    #Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Connect Now']    5s
    Click Element    xpath://*[text()='Connect Now']
    Sleep    5s

Accept Incoming Call as Provider
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://*[text()='Accept']
    Click Element    xpath://*[text()='Accept']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Got It!']    15s
    Click Element    xpath://*[text()='Got It!']

Extend Call Duration
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath://*[text()='Got It!']
    Click Element    xpath://*[text()='Got It!']
    Sleep    4s
    Sleep    ${EXTENDED_CALL_TIME}s
    #Wait Until Element Is Visible    xpath=//*[text()='Extend']    10s
    Mouse Over    //div[@data-testid="video-calling-top-bar"]
    Wait Until Element Is Visible    xpath=//div[@data-testid="extend_button"]    5s
    Click Element    xpath=//div[@data-testid="extend_button"]
    #Wait Until Element Is Enabled    xpath=//*[text()='Extend']    5s
    #Click Element    xpath=//*[text()='Extend']
    Sleep    5s
    #Mouse Over    //div[@data-testid="video-calling-top-bar"]
    #Wait Until Page Contains    This call has been extended    10s  # extend after 2 mins and disconnect
    #Sleep    5s
    Mouse Over    (//button[@aria-label="End Call"])[last()]
    Wait Until Element Is Visible    (//button[@aria-label="End Call"])[last()]    5s
    Click Element    (//button[@aria-label="End Call"])[last()]
    Switch Browser    INC
    Wait Until Page Contains Element    xpath=//div[contains(@class,'ProviderFeedback-module__Feedback--container')]    10s
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
