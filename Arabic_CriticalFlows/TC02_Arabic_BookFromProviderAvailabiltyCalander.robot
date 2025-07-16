*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/BrowserKeywords.robot
Resource    ../Common_Resources/PreloginArabicSelection.robot
Suite Teardown    Close And Clean All Browsers

*** Variables ***
${PROVIDER_EMAIL}    raghuram.m+rp1@taskhuman.com
${PROVIDER_PASSWORD}    asdfgh@12345A
${CONSUMER_EMAIL}    raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}    asdfgh@12345Q
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!
#${email}    raghuram.m+rc1@taskhuman.com
#${Password}    asdfgh@12345Q
${Scroll_L2R_R2L}    2


*** Test Cases ***
Open and Position Browsers
   Open the browser and login as Consumer
Check for language in Arabic and switch if needed
    Switch Browser    NORM
    Ensure Arabic Language Selected
    Login as Consumer

Login as Provider in Incognito
    Login as Provider in Incognito

Check Provider Online Status
    Check Provider Online Status
Check months are scrollable left to right and vice versa
    Check months are scrollable left to right and vice versa

Check if available date tapped/selected by consumer should show available time slots
    Check if available date tapped/selected by consumer should show available time slots

Check if call booked its showing animation under bookings with me
    Check if call booked its showing animation under bookings with me

Checking if booking in Our bookings and delete
    Checking if booking in Our bookings and delete

Goto Settings and logout as consumer
    Goto Settings and logout as consumer
Goto Settings and logout as Provider
    Goto Settings and logout as Provider

*** Keywords ***
Open the browser and login as Consumer
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
    Log    Incognito browser size and position set.t
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


Check months are scrollable left to right and vice versa
    Switch Browser    NORM
    Go To    https://app-dev.taskhuman.com/profile/5466/availability
    Sleep  2s  # Adjust sleep time if necessary to ensure page load
    Wait Until Element Is Visible    xpath=//img[contains(@src, 'my_availability.png')]    12s
    Click Element    xpath=//img[contains(@src, 'my_availability.png')]
    Sleep    4s
    Execute JavaScript    document.evaluate("(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue?.scrollIntoView();
    Wait Until Element Is Visible  xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()]  30s
    Click Element  xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()]
    Sleep    2s
    Wait Until Element Is Visible  xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[1]  30s
    Click Element  xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[1]
    Sleep    2s
    #FOR    ${index}    IN RANGE    ${Scroll_L2R_R2L}
    #    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[2]    30s
    #    Click Element    xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[2]
    #   Sleep    2s

    #   Wait Until Element Is Visible    xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()-1]    30s
    #    Click Element    xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()-1]
    #   Sleep    2s

     #   Wait Until Element Is Visible    xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()-1]    30s
      #  Click Element    xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()-1]
       # Sleep    2s

       # Wait Until Element Is Visible    xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[2]    30s
       # Click Element    xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[2]
       # Sleep    2s
    #END
Check if available date tapped/selected by consumer should show available time slots
    Wait Until Page Contains Element    xpath://div[contains(@class, 'AvailabiltyTab-module__Booking--Availability__Tag css-0')]    3s
    Click Element    xpath://div[contains(@class, 'AvailabiltyTab-module__Booking--Availability__Tag css-0')]
    Sleep    2s

Check if call booked its showing animation under bookings with me
    Wait Until Element Is Visible    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]    10s
    Click Element    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[@data-testid="verify_session_btn"]    10s
    Click Element                    xpath=//button[@data-testid="verify_session_btn"]
    Wait Until Element Is Visible    id=book_seesion_btn    10s
    Click Element                    id=book_seesion_btn
    Wait Until Element Is Visible    xpath=//button[@data-testid='got_it_btn']    10s
    Click Element                    xpath=//button[@data-testid='got_it_btn']
    Sleep    3s
Checking if booking in Our bookings and delete
    Go To    https://app-dev.taskhuman.com/bookings/session

    # Wait for delete icon to appear
    Wait Until Element Is Visible    xpath=//div[@data-testid="booking_delete_btn"]    10s

    # Click delete icon (get fresh element each time)
    Click Element    xpath=//div[@data-testid="booking_delete_btn"]
    Sleep    3s

    # Wait for the confirmation delete button to appear (Arabic text button)
    Wait Until Element Is Visible    xpath=//button[normalize-space(.)='يمسح']    10s

    # Click confirm delete button
    Click Element    xpath=//button[normalize-space(.)='يمسح']
    Sleep    3s

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
