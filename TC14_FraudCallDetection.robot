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
${CALL_DURATION}       10
${EXTENDED_CALL_TIME}  420  # 7mins

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
    Validate FraudCallDetection
Goto Settings and logout as consumer
    Goto Settings and logout as consumer
Goto Settings and logout as Provider
    Goto Settings and logout as Provider
#Validate on admin for fraudcallDetection
 #   Validate on admin for fraudcallDetection

*** Keywords ***
Open and Position Browsers
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=NORM
    Set Window Size    650    1200
    Set Window Position    0    0

    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=INC    options=add_argument("--incognito")
    Set Window Size    650    1200
    Set Window Position    650    0

Login as Provider in Incognito
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${PROVIDER_EMAIL}
    Sleep    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${PROVIDER_PASSWORD}
    Sleep    5s
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
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    5s
    #Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    5s
    #Sleep    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//input[@name='password']    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    #Sleep    5s
    Wait Until Element Is Visible    xpath://button[@value='submit']    5s
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
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Decrement Value Until ${CALL_DURATION} and call

Decrement Value Until ${CALL_DURATION} and call
    Wait Until Element Is Visible    id=time-decreament-icon    10
    WHILE    True
        ${current_value}=    Get Element Attribute    xpath=//input[@class="chakra-input css-1cjy4zv"]    value
        Run Keyword If    ${current_value} == ${CALL_DURATION}    Exit For Loop
        Click Element    id=time-decreament-icon
        Sleep    1s
    END
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Click Element    xpath://*[text()='Connect Now']
    Sleep    5s

Accept Incoming Call as Provider
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://*[text()='Accept']
    Click Element    xpath://*[text()='Accept']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Got It!']    15s
    Click Element    xpath://*[text()='Got It!']

Validate FraudCallDetection
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath://*[text()='Got It!']
    Click Element    xpath://*[text()='Got It!']
    Sleep    60s
    Mouse Over    (//button[@data-testid="enable_btn"])[1]
    Wait Until Element Is Visible    (//button[@data-testid="enable_btn"])[1]    5s
    Click Element    (//button[@data-testid="enable_btn"])[1]
    Wait Until Element Is Visible    (//button[@data-testid="enable_btn"])[2]    5s
    Click Element    (//button[@data-testid="enable_btn"])[2]
    Switch Browser    INC
    Mouse Over    (//button[@data-testid="enable_btn"])[1]
    Wait Until Element Is Visible    (//button[@data-testid="enable_btn"])[1]    5s
    Click Element    (//button[@data-testid="enable_btn"])[1]
    Wait Until Element Is Visible    (//button[@data-testid="enable_btn"])[2]    5s
    Click Element    (//button[@data-testid="enable_btn"])[2]
    Sleep    ${EXTENDED_CALL_TIME}s
    #Mouse Over    (//button[@data-testid="enable_btn"])[1]
    Page Should Not Contain Element    (//button[@aria-label="End Call"])[last()]    5s
    #to actually validate this we can status on admin but need pwd reset
Goto Settings and logout as consumer
    Switch Browser    NORM
    Go To    https://app-dev.taskhuman.com/settings
     Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
Goto Settings and logout as Provider
    Switch Browser    INC
    Go To    https://app-dev.taskhuman.com/provider/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
Validate on admin for fraudcallDetection
    Open Browser    https://provider-devenv.taskhuman.com/admin/callDetails    chrome
    Wait Until Page Contains Element     xpath=//input[@type='text' and @name='email']    10s
    Input Text     xpath=//input[@type='text' and @name='email']    raghuram.m@taskhuman.com
    Wait Until Element Is Visible    xpath=//input[@type='password' and @name='password']    10s
    Input Password    xpath=//input[@type='password' and @name='password']    qwerty@12345Q
    Click Element    xpath=//span[text()='Sign In']
    Sleep    3s
    Go To    https://provider-devenv.taskhuman.com/admin/callDetails
    Wait Until Page Contains Element    xpath=//td[text()='fraudDetectedAudioVideoDisable']    20s
    Page Should Contain Element    xpath=//td[text()='fraudDetectedAudioVideoDisable']
