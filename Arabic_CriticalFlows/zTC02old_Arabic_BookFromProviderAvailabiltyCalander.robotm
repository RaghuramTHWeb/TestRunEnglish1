*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/PreloginArabicSelection.robot
#book a seesion by scrolling calander to last availability>boook> deleteNA
*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q
${Scroll_L2R_R2L}    2


*** Test Cases ***
Check for language in Arabic and switch if needed
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Ensure Arabic Language Selected

Open the browser and login as Consumer
    #Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//div[@class='Login-module__signup-text css-0']    8s
    #Sleep    3s
    Wait Until Element Is Visible    xpath=//div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath=//div[@class='Login-module__signup-text css-0']
    #Sleep    3s
    Wait Until Element Is Visible     xpath=//input[@name='email']    10s
    #Sleep    3s
    Input Text     xpath=//input[@name='email']    ${email}
    Wait Until Element Is Visible   xpath=//input[@name='password']    10s 
    Input Text    xpath=//input[@name='password']    ${Password}
    Wait Until Element Is Visible    xpath=//button[@value='submit']    10s
    Click Element    xpath=//button[@value='submit']
    Sleep    2s
#Check for language in Arabic and switch if needed
 #   Select Arabic Language  # Calls the common test case

Check months are scrollable left to right and vice versa
    Go To    https://app-dev.taskhuman.com/profile/5466
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
    Wait Until Page Contains Element    xpath=//button[contains(@class, 'BookingForm-module__NextButton')]    4s
    Click Element    xpath=//button[contains(@class, 'BookingForm-module__NextButton')]
    Sleep    2s
    Click Element    xpath=//button[contains(@class, 'BookingForm-module__NextButton')]
    Sleep    2s
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'VerifyBooking-module__VerifyModal--ButtonGroup')]//button[contains(@class, 'VerifyBooking-module__VerifyModal--close--button')])[2]    30s
    Click Element    xpath=(//div[contains(@class, 'VerifyBooking-module__VerifyModal--ButtonGroup')]//button[contains(@class, 'VerifyBooking-module__VerifyModal--close--button')])[2]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'VerifyBooking-module__VerifyModal--close--button')]    30s
    Click Element    xpath=//button[contains(@class, 'VerifyBooking-module__VerifyModal--close--button')]
    Sleep    3s
Checking if booking in Our bookings and delete
    Go To    https://app-dev.taskhuman.com/bookings/session

    # Wait for delete icon to appear
    Wait Until Element Is Visible    xpath=//div[@data-testid="booking_delete_btn"]    10s

    # Click delete icon (get fresh element each time)
    Click Element    xpath=//div[@data-testid="booking_delete_btn"]
    Sleep    1s

    # Wait for the confirmation delete button to appear (Arabic text button)
    Wait Until Element Is Visible    xpath=//button[normalize-space(.)='يمسح']    10s

    # Click confirm delete button
    Click Element    xpath=//button[normalize-space(.)='يمسح']
    Sleep    1s

    Close Browser
