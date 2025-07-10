*** Settings ***
Library    SeleniumLibrary
#book a seesion by scrolling calander to last availability>boook> deleteNA
*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q
${Scroll_L2R_R2L}    2


*** Test Cases ***
Open the browser and login as Consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//div[@class='Login-module__signup-text css-0']    8s
    Sleep    3s
    Click Element    xpath=//div[@class='Login-module__signup-text css-0']
    Sleep    3s
    Wait Until Element Is Visible    id:field-:r0:    8s
    Sleep    3s
    Input Text    id:field-:r0:    ${email}
    Input Text    id:field-:r1:    ${Password}
    Click Element    xpath=//button[@value='submit']
    Sleep    2s
Check months are scrollable left to right and vice versa
    Go To    https://app-dev.taskhuman.com/profile/5466
    Sleep  2s  # Adjust sleep time if necessary to ensure page load
    Wait Until Element Is Visible    xpath://div[contains(@class,'Profile-module__ProviderProfile--Tabs css-0')]//p[contains(text(),'My')]    12s
    Click Element    xpath://div[contains(@class,'Profile-module__ProviderProfile--Tabs css-0')]//p[contains(text(),'My')]
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
    Wait Until Page Contains Element    xpath://div[contains(@class, 'AvailabiltyTab-module__Booking--Availability__Tag css-0')]    3s
    Click Element    xpath://div[contains(@class, 'AvailabiltyTab-module__Booking--Availability__Tag css-0')]
    Sleep    2s
Check if time slot clicked offering option to book a call
    Wait Until Page Contains Element    xpath://*[text()='Select a Topic']    4s
    Sleep    2s
Check if call booked its showing animation under bookings with me
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'BookingForm-module__Topic--Tag') and contains(@class, 'css-1fhfbim') and text()='AK skill']    10s
    Click Element    xpath=//span[contains(@class, 'BookingForm-module__Topic--Tag') and contains(@class, 'css-1fhfbim') and text()='AK skill']
    Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Next']    4s
    Click Element    xpath://*[text()='Next']
    Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Verify Session']    4s
    Click Element    xpath://*[text()='Verify Session']
    Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Book Session']    4s
    Click Element    xpath://*[text()='Book Session']
    Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Got it!']    4s
    Click Element    xpath://*[text()='Got it!']
    Sleep    3s
Checking if booking in Our bookings and delete
    Reload Page
    Wait Until Element Is Visible    xpath=//img[@src='https://images-dev.taskhuman.com/icon/profileTabIcon/our_bookings.png' and contains(@class, 'chakra-image css-0')]    10s
    Click Element    xpath=//img[@src='https://images-dev.taskhuman.com/icon/profileTabIcon/our_bookings.png' and contains(@class, 'chakra-image css-0')]
    Sleep    3s
    Wait Until Page Contains Element    xpath://*[text()='Delete']    4s
    Click Element    xpath://*[text()='Delete']
    Sleep    3s
    Wait Until Page Contains Element    xpath://*[text()='Delete Session?']    4s
    Wait Until Element Is Visible    xpath=//button[text()='Delete' and contains(@class, 'chakra-button') and contains(@class, 'css-s88bex')]    5s
    Click Element    xpath=//button[text()='Delete' and contains(@class, 'chakra-button') and contains(@class, 'css-s88bex')]
    Sleep    7s
    Close Browser

