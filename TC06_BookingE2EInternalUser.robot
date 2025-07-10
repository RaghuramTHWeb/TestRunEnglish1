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
Goto Settings and logout as consumer
    Goto Settings and logout as consumer
Goto Settings and logout as Provider
    Goto Settings and logout as Provider



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

Check Provider Online Status
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
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    #Sleep    5s
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    #Sleep
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//input[@name='password']    10s
    Click Element        xpath=//input[@name='password']
    Input Text        xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

Goto provider profile and book a session
    Go To    https://app-dev.taskhuman.com/profile/5391
    Sleep    5s
        Wait Until Element Is Visible    xpath=//div[@data-testid="action_menu_book_btn"]    10s
    Click Element                    xpath=//div[@data-testid="action_menu_book_btn"]
    #Sleep    2s
	Wait Until Element Is Visible    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]    10s
    Click Element    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]
    #Sleep    2s
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
    #Sleep    2s
    Wait Until Element Is Visible    xpath=(//button[contains(@class, 'BookingForm-module__accordion--btn')])[2]    10s
    Click Element    xpath=(//button[contains(@class, 'BookingForm-module__accordion--btn')])[2]
    Wait Until Element Is Visible    xpath=(//button[contains(@class, 'BookingForm-module__accordion--btn')])[2]//following-sibling::div//p[contains(@class, 'BookingForm-module__Tag__Text')]    10s
    Click Element    xpath=(//button[contains(@class, 'BookingForm-module__accordion--btn')])[2]//following-sibling::div//p[contains(@class, 'BookingForm-module__Tag__Text')][1]
    #Wait Until Element Is Visible    class:BookingForm-module__Time--Tag    5s
    #${elements}=    Get WebElements    class:BookingForm-module__Time--Tag
    #Click Element    ${elements}[0]
    Wait Until Element Is Visible    xpath=//button[@data-testid="verify_session_btn"]    10s
    Click Element                    xpath=//button[@data-testid="verify_session_btn"]
    Wait Until Element Is Visible    id=book_seesion_btn    10s
    Click Element                    id=book_seesion_btn
    Wait Until Element Is Visible    xpath=//button[@data-testid='got_it_btn']    10s
    Click Element                    xpath=//button[@data-testid='got_it_btn']

Check if booking is available in Our bookings section
    Go To    https://app-dev.taskhuman.com/profile/5391/bookings
    Wait Until Element Is Visible    //div[contains(@class, "BookingCss-module__booking--card")]    10s

    #Wait Until Element Is Visible    xpath=//img[@src='https://images-dev.taskhuman.com/icon/profileTabIcon/our_bookings.png' and @class='chakra-image css-0']
    #Click Element    xpath=//img[@src='https://images-dev.taskhuman.com/icon/profileTabIcon/our_bookings.png' and @class='chakra-image css-0']
    Sleep    3s

Check if booking is listed under provider
    Switch Browser    INC
    Sleep    3s
    Page Should Contain Element    xpath=//div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--Appointments')]/div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--AppointmentCard')]
    Sleep    5s

Validate if booking can be rescheduled to tomorrow
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath=//div[@data-testid='booking_reschedule_btn']    10s
    Click Element                    xpath=//div[@data-testid='booking_reschedule_btn']
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
    Wait Until Element Is Visible    xpath=(//button[contains(@class, 'BookingForm-module__accordion--btn')])[3]    10s
    Click Element    xpath=(//button[contains(@class, 'BookingForm-module__accordion--btn')])[3]
    Wait Until Element Is Visible    xpath=(//button[contains(@class, 'BookingForm-module__accordion--btn')])[3]//following-sibling::div//p[contains(@class, 'BookingForm-module__Tag__Text')]    10s
    Click Element    xpath=(//button[contains(@class, 'BookingForm-module__accordion--btn')])[3]//following-sibling::div//p[contains(@class, 'BookingForm-module__Tag__Text')][1]
    Wait Until Element Is Visible    xpath=//button[@data-testid="verify_session_btn"]    10s
    Click Element                    xpath=//button[@data-testid="verify_session_btn"]
    Wait Until Element Is Visible    id=reschedule_session_btn    10s
    Click Element                    id=reschedule_session_btn
    Wait Until Element Is Visible    xpath=//button[@data-testid='got_it_btn']    10s
    Click Element                    xpath=//button[@data-testid='got_it_btn']
    Sleep    3s
    #Wait Until Element Is Visible   xpath=//p[@class='chakra-text BookingCss-module__booking-cal css-0' and text()='Reschedule']
    ##Click Element    xpath=//p[@class='chakra-text BookingCss-module__booking-cal css-0' and text()='Reschedule']
    #Sleep    4s
    #Click Element    xpath://*[text()='Next']
    #Sleep    5s
    #Wait Until Element Is Visible    xpath://*[text()='Tomorrow']    5s
    #Click Element    xpath://*[text()='Tomorrow']
    #Click Element    xpath=//*[text()='Tomorrow']/following::p[contains(text(), '9:30am')]
    #Sleep    5s
    #Click Element    xpath://*[text()='Verify Session']
    #Sleep    5s
    #Wait Until Element Is Visible    xpath=//button[@class='chakra-button VerifyBooking-module__VerifyModal--close--button css-s88bex' and text()='Reschedule']    10s
    ##Click Element    xpath=//button[@class='chakra-button VerifyBooking-module__VerifyModal--close--button css-s88bex' and text()='Reschedule']
    #Sleep    10s
    #Wait Until Element Is Visible    xpath://*[text()='Got It!']
    #Click Element    xpath://*[text()='Got It!']
    #Sleep    6s

Validate if booking can be deleted
           Go To    https://app-dev.taskhuman.com/bookings/session

    # Wait for delete icon to appear
   #Wait Until Element Is Visible    xpath=//div[@data-testid="booking_delete_btn"]    10s

    # Click delete icon (get fresh element each time)
    #Click Element    xpath=//div[@data-testid="booking_delete_btn"]
    Wait Until Element Is Visible    xpath=(//div[contains(@class, "BookingCss-module__booking--card")])[1]//div[@data-testid="booking_delete_btn"]    10s
    Click Element                    xpath=(//div[contains(@class, "BookingCss-module__booking--card")])[1]//div[@data-testid="booking_delete_btn"]
    Sleep    1s
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']    10s
    Click Element    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']
    Sleep    4s

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
