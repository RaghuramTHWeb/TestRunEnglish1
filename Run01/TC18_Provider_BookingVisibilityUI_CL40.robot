*** Settings ***
Library    SeleniumLibrary
  #should have exisiting bookings or can be modified by booking one from consumer end in future and checking its avilability

*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q
${email2}    raghuram.m+rp1@taskhuman.com
${Password2}    asdfgh@12345A

*** Test Cases ***
Open the browser and login as consumer
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
Goto provider profile >> Book session
    Go To    https://app-dev.taskhuman.com/profile/5466     #bookcta..blw
    Wait Until Element Is Visible    xpath=//img[@src='/6e389bc7e0a35c6cbbb7.svg']    5s
    Click Element    xpath=//img[@src='/6e389bc7e0a35c6cbbb7.svg']
        
    #Wait Until Element Is Visible    xpath=//div[@class='ActionMenu-module__ActionMenu--List css-0']//img[2]    10s     #if fails make provider online
    #Click Element    xpath=//div[@class='ActionMenu-module__ActionMenu--List css-0']//img[2]
    Sleep    4s
    Wait Until Page Contains Element    xpath://*[text()='Select a Topic']    4s
    Sleep    2s
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'BookingForm-module__Topic--Tag') and contains(@class, 'css-1fhfbim') and text()='AK skill']    10s
    Click Element    xpath=//span[contains(@class, 'BookingForm-module__Topic--Tag') and contains(@class, 'css-1fhfbim') and text()='AK skill']
    Sleep    10s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Tomorrow']
    Click Element    xpath://*[text()='Tomorrow']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[normalize-space(text())='Tomorrow']//following::div[contains(@class, 'BookingForm-module__Time--Tag')][1]
    Click Element    xpath=//div[normalize-space(text())='Tomorrow']//following::div[contains(@class, 'BookingForm-module__Time--Tag')][1]    
    #${time_slot}=     Get WebElement    xpath=//p[contains(@class, 'BookingForm-module__Tag__Text') and contains(text(), '12:40pm') and preceding::text()='Tomorrow']
    #Click Element    ${time_slot}
    Sleep    5s
    Click Element    xpath://*[text()='Verify Session']
    Sleep    5s
    Wait Until Element Is Visible  xpath://*[text()='Book Session']
    Click Element    xpath://*[text()='Book Session']
    Sleep    10s
    Wait Until Element Is Visible    xpath://*[text()='Got it!']
    Click Element    xpath://*[text()='Got it!']
    Sleep    6s
    Close Browser
Open the browser and login as Provider
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Wait Until Element Is Visible    id:field-:r0:    10s
    Sleep    5s
    Input Text    id:field-:r0:    ${email2}
    Input Text    id:field-:r1:    ${Password2}
    Click Element    xpath://button[@value='submit']
    Sleep    5s
To validate if bookings are visible to provider
    Go To    https://app-dev.taskhuman.com/provider/availability
    Sleep    2s
    Page Should Contain Element    xpath=//div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--Appointments')]/div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--AppointmentCard')]
    Sleep    5s
   # Find the specific appointment card containing '1045'
    ${appointment_element}=    Get WebElement    xpath=//div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--AppointmentCard')]//*[text()='AK skill']/ancestor::div[contains(@class, 'AvailabilityCard-module__AvailabilityCard')]

    # Verify the text 'Delete' exists within the specific appointment card
    Element Should Contain    ${appointment_element}    Delete

    # Find the 'Delete' text within the specific appointment card
    ${delete_text}=    Get WebElement    xpath=//div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--AppointmentCard')]//*[text()='AK skill']/ancestor::div[contains(@class, 'AvailabilityCard-module__AvailabilityCard')]//div[contains(@class, 'AvailabilityCard-module__AvailabilityCard--Future__Button')]//p[text()='Delete']

    # Click on the 'Delete' text within the specific appointment card
    Click Element    ${delete_text}

    # Click on the 'Delete' button in the confirmation dialog
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'chakra-button') and contains(@class, 'DeleteForm-module__deleteButton')]
    Click Button    xpath=//button[contains(@class, 'chakra-button') and contains(@class, 'DeleteForm-module__deleteButton')]
    Sleep    3s
    Close Browser

