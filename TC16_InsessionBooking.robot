*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Suite Teardown    Close All Browsers

*** Variables ***
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!
${PROVIDER_EMAIL}    Replace this message with your provider email
${PROVIDER_PASSWORD}    Replace this message with your provider Password
${CONSUMER_EMAIL}    Replace this message with your Consumer email
${CONSUMER_PASSWORD}    Replace this message with your COnsumer Password

*** Keywords ***
Login as Provider in Incognito
    # Logs in as a provider in incognito mode.
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
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
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    Wait Until Element Is Visible    xpath=//input[@name='password']    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    5s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

Goto Provider Profile
    # Goes to the provider profile page.
    Go To    https://app-dev.taskhuman.com/profile/5391
    Sleep    5s

Call Provider
    # Calls the provider and clicks through the steps.
    #Wait Until Element Is Visible    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    #Click Element    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Wait Until Element Is Visible    xpath=//div[@data-testid="action_menu_call_btn"]    10s
    Click Element    xpath=//div[@data-testid="action_menu_call_btn"]
    #Sleep    5s
    #Wait Until Element Is Visible    xpath=//div[contains(@class, 'CallForm-module__CallForm--ContinueCall__Skill') and contains(@class, 'css-0') and text()='AK skill']    20s
    #Click Element    xpath=//div[contains(@class, 'CallForm-module__CallForm--ContinueCall__Skill') and contains(@class, 'css-0') and text()='AK skill']
    Wait Until Element Is Visible    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]    10s
    Click Element    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
   # Wait Until Element Is Visible   xpath://*[text()='Next']    10s
   # Click Element    xpath://*[text()='Next']
    #Sleep     2s
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]

    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
    Sleep    5s


Accept Call as Provider in Incognito
    # Accepts the call in incognito mode as the provider.
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://*[text()='Accept']    15s
    Click Element    xpath://*[text()='Accept']
    Wait Until Element Is Visible    xpath://*[text()='Got It!']    15s
    Click Element    xpath://*[text()='Got It!']
Validate Insession Booking
    Wait Until Element Is Visible  //button[@aria-label="Book Next Session Now"]    10s
    Click Element    //button[@aria-label="Book Next Session Now"]
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Availability__Chip')]//span[contains(text(), ':')]    10s
    Wait Until Element Is Visible    xpath=//section[contains(@class, 'InSessionBookingForm')]//button[contains(@class, 'InSessionBookingForm--SaveButton')]    10s
    Click Element    xpath=//section[contains(@class, 'InSessionBookingForm')]//button[contains(@class, 'InSessionBookingForm--SaveButton')]
    Sleep    5s
Accept Insession Request
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath=//button[@data-testid="insession_accept_session_btn"]    10S
    Click Button    xpath=//button[@data-testid="insession_accept_session_btn"]
    Wait Until Element Is Visible     xpath=//button[@data-testid='got_id_btn']    10S
    Click Element    xpath=//button[@data-testid='got_id_btn']
    Wait Until Element Is Visible    xpath=//div[text()='Got It!']    5s
    Click Element                    xpath=//div[text()='Got It!']
Decline Insessoin Request
    Switch Browser    INC
    Mouse Over    //button[@aria-label="Book Next Session Now"]
    Wait Until Element Is Visible  //button[@aria-label="Book Next Session Now"]    10s
    Click Element    //button[@aria-label="Book Next Session Now"]
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Availability__Chip')]//span[contains(text(), ':')]    10s
    Wait Until Element Is Visible    xpath=//section[contains(@class, 'InSessionBookingForm')]//button[contains(@class, 'InSessionBookingForm--SaveButton')]    10s
    Click Element    xpath=//section[contains(@class, 'InSessionBookingForm')]//button[contains(@class, 'InSessionBookingForm--SaveButton')]
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath=//button[@data-testid='insession_decline_session_btn']    10S
    Click Element    xpath=//button[@data-testid='insession_decline_session_btn']
    Element Should Not Be Visible    xpath=//button[@data-testid='got_id_btn']    5s
    Mouse Over    (//button[@aria-label="End Call"])[last()]
    Wait Until Element Is Visible    (//button[@aria-label="End Call"])[last()]    5s
    Click Element                    (//button[@aria-label="End Call"])[last()]
Validate Insession booking visibility in Bookings page
    Go To    https://app-dev.taskhuman.com/bookings/session
    Wait Until Element Is Visible    //div[contains(@class, "BookingCss-module__booking--card")]    10s
        # Wait for delete icon to appear
    Wait Until Element Is Visible    xpath=//div[@data-testid="booking_delete_btn"]    10s

    # Click delete icon (get fresh element each time)
    Click Element    xpath=//div[@data-testid="booking_delete_btn"]
    Sleep    1s
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']    10s
    Click Element    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']
    Sleep    1s
    #Switch Browser    INC
    #Wait Until Element Is Visible    (//button[@aria-label="End Call"])[last()]    5s
    #Click Element                    (//button[@aria-label="End Call"])[last()]
    #Wait Until Element Is Visible    xpath://img[4]
    #Click Element    xpath://img[4]
    #Sleep    10s

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
Validate Insession Booking - Accept, Decline, Booking visibility
    Validate Insession Booking
    Accept Insession Request
    Decline Insessoin Request
    Validate Insession booking visibility in Bookings page
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

