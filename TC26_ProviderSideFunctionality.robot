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
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!

*** Keywords ***

Login as Provider
    # Logs in as a consumer in normal mode.
    Open Browser    https://app-dev.taskhuman.com/login    Chrome
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${PROVIDER_EMAIL}
    Wait Until Element Is Visible   xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${PROVIDER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    4s
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


*** Test Cases ***

Login as Provider
    # Test case to log in as a consumer in normal mode.
    Login As Provider
Validate as provider: lands on availability page after login
    Wait Until Element Is Visible    xpath=//a[@href='/provider/availability']    10s
Verify Countdown Timer Is Running
    Wait Until Element Is Visible    xpath=//p[@class='MenuBar-module__Menubar--Availability__Timer']    5s
    ${initial_timer}=    Get Text    xpath=//p[@class='MenuBar-module__Menubar--Availability__Timer']
    Sleep    5s
    ${subsequent_timer}=    Get Text    xpath=//p[@class='MenuBar-module__Menubar--Availability__Timer']
    Should Not Be Equal    ${initial_timer}    ${subsequent_timer}
Validate Multiple Availabilities (Precondition: Availability should be added)
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    3s
    ${availabilities}=    Get WebElements    css:.AvailabilityCard-module__AvailabilityCard
    ${availability_count}=    Get Length    ${availabilities}
    Should Be True    ${availability_count} > 1
    Sleep    3s
Verify Pause Functionality
    Wait Until Element Is Visible    xpath=//*[text()="Pause"]    10s
    Click Element    xpath=//*[text()="Pause"]
    Sleep    5s
    Wait Until Page Contains Element    xpath=//*[text()="Take a break. You deserve it!"]    10s
    Sleep    5s
    Wait Until Element Is Visible    xpath=//*[text()="Continue"]    10s
    Click Element    xpath=//*[text()="Continue"]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//*[text()="Continue"]    10s
    Click Element    xpath=//*[text()="Continue"]
    Sleep    5s
    #Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    10s
Verify Add availability
    Wait Until Element Is Visible    xpath=//button[@id='add_availability_icon']    5s
    Click Element    xpath=//button[@id='add_availability_icon']
    Sleep    2s
    Wait Until Page Contains Element    xpath=//*[text()='Save']    2s
    Click Element    xpath=//*[text()='Save']
    Sleep    2s
    #Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    2s
    #Sleep    2s
Validate delete functionality
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'AvailabilityCard--Online__ButtonGroup')]//div[contains(@class, 'AvailabilityCard--Online__Button')])[2]    5s
    Click Element    xpath=(//div[contains(@class, 'AvailabilityCard--Online__ButtonGroup')]//div[contains(@class, 'AvailabilityCard--Online__Button')])[2]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[@type='submit']    10s
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    2s
    Sleep    2s

Goto Settings and logout as Provider
    Go To    https://app-dev.taskhuman.com/provider/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
