*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/PreloginArabicSelection.robot
Resource    ../Resources/BrowserKeywords.robot
Suite Teardown    Close All Browsers

*** Variables ***
${PROVIDER_EMAIL}    raghuram.m+rp1@taskhuman.com
${PROVIDER_PASSWORD}    asdfgh@12345A
${CONSUMER_EMAIL}    raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}    asdfgh@12345Q
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!
${ADD_TO_CAL_BUTTON}    xpath=//div[@data-testid="booking_add_to_cal_btn"]
${ADD_EVENT_TO_CALENDAR_MODAL}      xpath=//div[contains(@class, 'addToCalendar-module__AddToCalendar--Body')]
${SECOND_CALENDAR_ICON}    xpath=(//div[contains(@class, 'addToCalendar-module__CalendarIcon--Box')])[2]
${ADD_BUTTON}    xpath=//button[@data-testid="add_btn"]
${CANCEL_BUTTON}    xpath=//button[@data-testid="cancel_btn"]

*** Test Cases ***
Open and Position Browsers
    Open and Position Browsers

Login as Provider in Incognito
    Login as Provider in Incognito

Check Provider Online Status
    Check Provider Online Status
    Wait Until Element Is Visible    xpath=//p[normalize-space(text())="Pause"]    10s
    Click Element                    xpath=//p[normalize-space(text())="Pause"]
    Wait Until Element Is Visible    xpath=//button[normalize-space(text())="Continue"]    10s
    Click Element                    xpath=//button[normalize-space(text())="Continue"]
    Wait Until Element Is Visible    xpath=//button[normalize-space(text())="Continue"]    10s
    Click Element                    xpath=//button[normalize-space(text())="Continue"]


Login as Consumer
    Login as Consumer

Search for Provider and Book
    Go To    https://app-dev.taskhuman.com/search/name/%D8%B1%D8%A7%D8%BA%D9%88%20%D9%83%D8%A8%D8%B4
        Wait Until Element Is Visible    xpath=//div[@data-testid='action_menu_book_btn']    10s
    Click Element                    xpath=//div[@data-testid='action_menu_book_btn']
    Wait Until Element Is Visible    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]    10s
    Click Element                    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
    # Wait until the booking forms are loaded
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'BookingForm-module__BookingForm--Body')])[1]    10s
    # Expand the first accordion section
    Click Element    xpath=(//div[contains(@class,'BookingForm-module__BookingForm--Body')] //button[contains(@class,'BookingForm-module__accordion--btn')])[1]
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'BookingForm-module__BookingForm--Body')] //div[contains(@class,'BookingForm-module__TimeTag--Box')])[1]    10s
    # Click the first time tag inside the expanded section
    Click Element    xpath=(//div[contains(@class,'BookingForm-module__BookingForm--Body')] //div[contains(@class,'BookingForm-module__TimeTag--Box')]//div[contains(@class,'BookingForm-module__Time--Tag')])[1]
    #Wait Until Element Is Visible    xpath=//div[contains(@class, 'ActionMenu-module__ActionMenu--Search--Box') and .//p[text()='Book']]    5s
    #Click Element    xpath=//div[contains(@class, 'ActionMenu-module__ActionMenu--Search--Box') and .//p[text()='Book']]
    Wait Until Element Is Visible    xpath=//button[@data-testid="verify_session_btn"]    10s
    Click Element                    xpath=//button[@data-testid="verify_session_btn"]
    Wait Until Element Is Visible    id=book_seesion_btn    10s
    Click Element    id=book_seesion_btn
    Wait Until Element Is Visible    css=[data-testid="got_it_btn"]    10s
    Click Element    css=[data-testid="got_it_btn"]

Check if booking is visible and delete
           Go To    https://app-dev.taskhuman.com/bookings/session

    # Wait for delete icon to appear
   #Wait Until Element Is Visible    xpath=//div[@data-testid="booking_delete_btn"]    10s

    # Click delete icon (get fresh element each time)
    #Click Element    xpath=//div[@data-testid="booking_delete_btn"]
    Wait Until Element Is Visible    xpath=(//div[contains(@class, "BookingCss-module__booking--card")])[1]//div[@data-testid="booking_delete_btn"]    10s
    Click Element                    xpath=(//div[contains(@class, "BookingCss-module__booking--card")])[1]//div[@data-testid="booking_delete_btn"]
    Sleep    1s
    Wait Until Element Is Visible    xpath=//button[normalize-space(.)='يمسح']    10s
    # Click confirm delete button
    Click Element    xpath=//button[normalize-space(.)='يمسح']
    Sleep    1s

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
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    #Sleep    4s
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${PROVIDER_EMAIL}
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//input[@name='password']    10s
    Click Element        xpath=//input[@name='password']
    Input Text        xpath=//input[@name='password']    ${PROVIDER_PASSWORD}
    #Sleep    5s
    Wait Until Element Is Visible     xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    3s


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
    Sleep    5s

Login as Consumer
    Switch Browser    NORM
    Ensure Arabic Language Selected
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
    ##
    #Wait Until Element Is Visible    id:field-:r0:
    #Sleep    8s
    #Click Element    xpath://input[@id='field-:r0:']
    #Input Text    id:field-:r0:    ${CONSUMER_EMAIL}
    #Sleep    5s
    #Click Element    xpath://input[@id='field-:r1:']
    #Input Text    id:field-:r1:    ${CONSUMER_PASSWORD}
    #Sleep    5s
    #Click Element    xpath://button[@value='submit']
    #Sleep    4s


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

