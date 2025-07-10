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

*** Test Cases ***
Open and Position Browsers
    # Opens two browsers and positions them side by side.
    # Open first browser (normal mode)
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=NORM
    Set Window Size    650    1200
    Set Window Position    0    0
    Log    Normal browser size and position set

    # Open second browser (incognito mode)
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=INC    options=add_argument("--incognito")
    Set Window Size    650    1200
    Set Window Position    650    0
    Log    Incognito browser size and position set

Login as Provider in Incognito
    # Logs in as a provider in incognito mode.
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:
    Sleep    4s
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

Goto provider profile and book a session
    # Goes to the provider profile page.
    Go To    https://app-dev.taskhuman.com/profile/5466
    Sleep    5s
    Wait Until Element Is Visible    xpath=//img[@src='/6e389bc7e0a35c6cbbb7.svg']    5s
    Click Element    xpath=//img[@src='/6e389bc7e0a35c6cbbb7.svg']
    Sleep    5s
    Wait Until Page Contains Element    xpath://*[text()='Select a Topic']    4s
    Sleep    2s
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'BookingForm-module__Topic--Tag') and contains(@class, 'css-1fhfbim') and text()='AK skill']    10s
    Click Element    xpath=//span[contains(@class, 'BookingForm-module__Topic--Tag') and contains(@class, 'css-1fhfbim') and text()='AK skill']
    Sleep    10s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Today']    3s
    Click Element    xpath://*[text()='Today']
    ${elements}=    Get WebElements    class:BookingForm-module__Time--Tag
    Click Element    ${elements}[0]
    #Wait Until Element Is Visible    xpath=//*[text()='Today']/following::p[contains(text(), '9:30pm')]    4s
    #Click Element    xpath=//*[text()='Today']/following::p[contains(text(), '9:30pm')]
    Sleep    5s
    Click Element    xpath://*[text()='Verify Session']
    Sleep    5s
    Wait Until Element Is Visible  xpath://*[text()='Book Session']
    Click Element    xpath://*[text()='Book Session']
    Sleep    10s
    Wait Until Element Is Visible    xpath://*[text()='Got it!']
    Click Element    xpath://*[text()='Got it!']
    Sleep    6s
Check if booking is available in Our bookings section
    Wait Until Element Is Visible    xpath=//img[@src='https://images-dev.taskhuman.com/icon/profileTabIcon/our_bookings.png' and @class='chakra-image css-0']
    Click Element    xpath=//img[@src='https://images-dev.taskhuman.com/icon/profileTabIcon/our_bookings.png' and @class='chakra-image css-0']
    Sleep    3s
Check if booking is listed under provider
    Switch Browser    INC
    Sleep    3s
    Page Should Contain Element    xpath=//div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--Appointments')]/div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--AppointmentCard')]
    Sleep    5s
Validate if booking can be rescheduled to tomorrow
    Switch Browser    NORM
    Wait Until Element Is Visible   xpath=//p[@class='chakra-text BookingCss-module__booking-cal css-0' and text()='Reschedule']
    Click Element    xpath=//p[@class='chakra-text BookingCss-module__booking-cal css-0' and text()='Reschedule']
    Sleep    4s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Tomorrow']    5s
    Click Element    xpath://*[text()='Tomorrow']
    Click Element    xpath=//*[text()='Tomorrow']/following::p[contains(text(), '11:30am')]
    Sleep    5s
    Click Element    xpath://*[text()='Verify Session']
    Sleep    5s
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button VerifyBooking-module__VerifyModal--close--button css-s88bex' and text()='Reschedule']    10s
    Click Element    xpath=//button[@class='chakra-button VerifyBooking-module__VerifyModal--close--button css-s88bex' and text()='Reschedule']
    Sleep    10s
    Wait Until Element Is Visible    xpath://*[text()='Got it!']
    Click Element    xpath://*[text()='Got it!']
    Sleep    6s
validate if booking can be deleted
    Wait Until Element Is Visible    xpath://*[text()='Delete']
    Click Element    xpath://*[text()='Delete']
    Sleep    6s
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']    10s
    Click Element    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']
    Sleep    10s
    Close Browser