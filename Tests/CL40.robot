*** Settings ***
Library    SeleniumLibrary
Documentation    To validate if provider has bookings  #should have exisiting bookings or can be modified by booking one from consumer end in future and checking its avilability

*** Variables ***
${email}    raghuram.m+rp1@taskhuman.com
${Password}    asdfgh@12345A

*** Test Cases ***
Open the browser and login as Provider
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
To validate if bookings are visible to provider
    Go To    https://app-dev.taskhuman.com/provider/availability
    Wait Until Element Is Visible    xpath=//div[contains(@class,'AvailabilityCard-module__AvailabilityCard--AppointmentCard')]
    Sleep    5s
