*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

#book a seesion by scrolling calander to last availability>boook> deleteNA
*** Variables ***
${CONSUMER_EMAIL}    Replace this message with your Consumer email
${CONSUMER_PASSWORD}    Replace this message with your COnsumer Password
${Scroll_L2R_R2L}    2


*** Test Cases ***
Open the browser and login as Consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//div[@class='Login-module__signup-text css-0']    8s
    Sleep    3s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    Sleep    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    3s
Check months are scrollable left to right and vice versa
    Go To    https://app-dev.taskhuman.com/profile/5391/availability
    Sleep  2s  # Adjust sleep time if necessary to ensure page load
   Wait Until Element Is Visible    xpath=//div[@data-testid="availability"]    10s
   Click Element    xpath=//div[@data-testid="availability"]
    Sleep    4s
    Wait Until Element Is Visible  xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[2]  30s
    Click Element  xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[2]
    Sleep    2s
    Wait Until Element Is Visible  xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()-1]  30s
    Click Element  xpath=(//div[contains(@class, 'Calendar-module__calendar_day_number css-0')])[last()-1]
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
    Wait Until Page Contains Element    xpath://div[contains(@class, 'AvailabiltyTab-module__Booking--Availability__Tag css-0')]    10s
    Click Element    xpath://div[contains(@class, 'AvailabiltyTab-module__Booking--Availability__Tag css-0')]
    Sleep    2s
Check if time slot clicked offering option to book a call
    Wait Until Page Contains Element    xpath://*[text()='Select a Topic']    10s
    Sleep    2s
Check if call booked its showing animation under bookings with me
    Wait Until Element Is Visible    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]    10s
    Click Element    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]
   # Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Next']    10s
    Click Element    xpath://*[text()='Next']
    #Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Verify Session']    10s
    Click Element    xpath://*[text()='Verify Session']
    #Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Book Session']    10s
    Click Element    xpath://*[text()='Book Session']
    #Sleep    2s
    Wait Until Element Is Visible    xpath=//button[@data-testid='got_it_btn']    10s
    Click Element                    xpath=//button[@data-testid='got_it_btn']
Checking if booking in Our bookings and delete
            Go To    https://app-dev.taskhuman.com/bookings/session

    # Wait for delete icon to appear
    Wait Until Element Is Visible    xpath=//div[@data-testid="booking_delete_btn"]    10s

    # Click delete icon (get fresh element each time)
    Click Element    xpath=//div[@data-testid="booking_delete_btn"]
    Sleep    1s
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']    10s
    Click Element    xpath=//button[@class='chakra-button css-s88bex' and text()='Delete']
    Sleep    1s
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']

    Close Browser
