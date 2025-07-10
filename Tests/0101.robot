*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${PROVIDER_EMAIL}    raghuram.m+rp1@taskhuman.com
${PROVIDER_PASSWORD}    asdfgh@12345A
${CONSUMER_EMAIL}    raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}    asdfgh@12345Q
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!

*** Test Cases ***

Open and Position Browsers
    Open and Position Browsers

Login as Provider in Incognito
    Login as Provider in Incognito

Check Provider Online Status
    Check Provider Online Status

Login as Consumer
    Login as Consumer

Goto provider profile and book a session
    Goto provider profile and book a session

Check if booking is available in Our bookings section
    Check if booking is available in Our bookings section

Check if booking is listed under provider
    Check if booking is listed under provider

Validate if booking can be rescheduled to tomorrow
    Validate if booking can be rescheduled to tomorrow

Validate if booking can be deleted
    Validate if booking can be deleted

Close browser
    Close Browser

*** Keywords ***

Open and Position Browsers
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=NORM
    Set Window Size    650    1200
    Set Window Position    0    0
    Log    Normal browser size and position set

    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=INC    options=add_argument("--incognito")
    Set Window Size    650    1200
    Set Window Position    650    0
    Log    Incognito browser size and position set

Login as Provider in Incognito
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:    10s
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    ${PROVIDER_EMAIL}
    Wait Until Element Is Visible    xpath://input[@id='field-:r1:']    10s
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    ${PROVIDER_PASSWORD}
    Wait Until Element Is Visible    xpath://input[@id='field-:r1:']    10s
    Click Element    xpath://button[@value='submit']
    
Check Provider Online Status
    ${online_status_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[text()="${ONLINE_TEXT}"]    10s
    ${offline_status_present}=   Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[text()="${OFFLINE_TEXT}"]    10s

    Run Keyword If    ${online_status_present}    Log    Provider is already online. Skipping "Go Online Now" action.
    Run Keyword If    ${offline_status_present}    Make Online

Make Online
    Log    Provider is offline. Proceeding to make the provider online.
    Wait Until Element Is Visible    xpath=//button[@id='go_online_now']    10s
    Wait Until Element Is Enabled    xpath=//button[@id='go_online_now']    10s
    Click Element    xpath=//button[@id='go_online_now']
    Wait Until Element Is Visible    xpath=//button[text()='Save']    10s
    Click Element    xpath=//button[text()='Save']
    
Login as Consumer
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:    10s
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    ${CONSUMER_EMAIL}
    Wait Until Element Is Visible    xpath://input[@id='field-:r1:']    10s
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    ${CONSUMER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Wait Until Location Is    https://app-dev.taskhuman.com/discover/66d99d3082098164d315705d    10s

Goto provider profile and book a session
    Go To    https://app-dev.taskhuman.com/profile/5466
    Wait Until Element Is Visible    xpath=//img[@src='/6e389bc7e0a35c6cbbb7.svg']    10s
    Click Element    xpath=//img[@src='/6e389bc7e0a35c6cbbb7.svg']
    Wait Until Page Contains Element    xpath://*[text()='Select a Topic']    10s
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'BookingForm-module__Topic--Tag') and contains(@class, 'css-1fhfbim') and text()='AK skill']    10s
    Click Element    xpath=//span[contains(@class, 'BookingForm-module__Topic--Tag') and contains(@class, 'css-1fhfbim') and text()='AK skill']
    Wait Until Element Is Visible    xpath://*[text()='Next']    10s
    Click Element    xpath://*[text()='Next']
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'chakra-accordion__item')]//button)[3]    10s
    Click Element    xpath=(//div[contains(@class, 'chakra-accordion__item')]//button)[3]
    Sleep    2s
    ${js}=    Set Variable    document.querySelectorAll('.BookingForm-module__Time--Tag')[3].click();
    Execute JavaScript    ${js}
    Click Element    xpath://*[text()='Verify Session']
    Wait Until Element Is Visible  xpath://*[text()='Book Session']    10s
    Click Element    xpath://*[text()='Book Session']
    Wait Until Element Is Visible    xpath://*[text()='Got it!']    10s
    Click Element    xpath://*[text()='Got it!']

Check if booking is available in Our bookings section
    Wait Until Element Is Visible    xpath=//img[@src='https://images-dev.taskhuman.com/icon/profileTabIcon/our_bookings.png' and @class='chakra-image css-0']    10s
    Click Element    xpath=//img[@src='https://images-dev.taskhuman.com/icon/profileTabIcon/our_bookings.png' and @class='chakra-image css-0']
Check if booking is listed under provider
    Switch Browser    INC
    Sleep    3s
    Page Should Contain Element    xpath=//div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--Appointments')]/div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--AppointmentCard')]    10s
    #Sleep    5s

Validate if booking can be rescheduled to tomorrow
    Switch Browser    NORM
    Wait Until Element Is Visible   xpath=//p[@class='chakra-text BookingCss-module__booking-cal css-0' and text()='Reschedule']    10s
    Click Element    xpath=//p[@class='chakra-text BookingCss-module__booking-cal css-0' and text()='Reschedule']
    #Sleep    4s
    Wait Until Element Is Visible    xpath://*[text()='Next']    10s
    Click Element    xpath://*[text()='Next']
    #Sleep    3s
    Wait Until Element Is Visible    xpath://*[text()='Tomorrow']    10s
    Click Element    xpath://*[text()='Tomorrow']
    Click Element    xpath=//*[text()='Tomorrow']/following::p[contains(text(), '11:30am')]
    Wait Until Element Is Visible    xpath://*[text()='Verify Session']    10s
    Click Element    xpath://*[text()='Verify Session']
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button VerifyBooking-module__VerifyModal--close--button css-s88bex' and text()='Reschedule']    10s
    Click Element    xpath=//button[@class='chakra-button VerifyBooking-module__VerifyModal--close--button css-s88bex' and text()='Reschedule']
    Wait Until Element Is Visible    xpath://*[text()='Got it!']    10s
    Click Element    xpath://*[text()='Got it!']

Validate if booking can be deleted
    Wait Until Element Is Visible    xpath://*[text()='Delete']    10s
    Click Element    xpath://*[text()='Delete']
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']    10s
    Click Element    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']
    Sleep    3s
    Close Browser
