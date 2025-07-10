*** Settings ***
Library    SeleniumLibrary
#book_reschedule_DElete booking case
*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q

*** Test Cases ***
Open the browser and login as Internal consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Wait Until Element Is Visible    id:field-:r0:    10s
    Sleep    5s
    Input Text    id:field-:r0:    ${email}
    Input Text    id:field-:r1:    ${Password}
    Click Element    xpath://button[@value='submit']
    Sleep    5s
Goto provider profile >> Book, reschedule, delete booking
    Go To    https://app-dev.taskhuman.com/profile/5466     #bookcta..blw
    Wait Until Element Is Visible    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]    10s
    Click Element    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Sleep    4s
    Wait Until Element Is Visible    xpath=//span[@class='BookingForm-module__Topic--Tag css-1fhfbim' and text()='Weight']    10s
    Click Element    xpath=//span[@class='BookingForm-module__Topic--Tag css-1fhfbim' and text()='Weight']
    Sleep    10s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Thursday, Aug 15']
    Click Element    xpath://*[text()='Thursday, Aug 15']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='3:00pm']
    Click Element    xpath://*[text()='3:00pm']
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
Validate if booking can be rescheduled to tomorrow
    Wait Until Element Is Visible   xpath=//p[@class='chakra-text BookingCss-module__booking-cal css-0' and text()='Reschedule']
    Click Element    xpath=//p[@class='chakra-text BookingCss-module__booking-cal css-0' and text()='Reschedule']
    Sleep    4s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Tomorrow']
    Click Element    xpath://*[text()='Tomorrow']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='11:30am']
    Click Element    xpath://*[text()='11:30am']
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
    Sleep    20s