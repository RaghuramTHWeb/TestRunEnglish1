*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}    raghuram.m+rp1@taskhuman.com
${Password}    asdfgh@12345A

*** Test Cases ***
Open the browser and login as Provider
    Open Browser    https://app-dev.taskhuman.com/login    chrome
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

Validate Multiple Availabilities (Precondition: Availability should be added)
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    3s
    ${availabilities}=    Get WebElements    css:.AvailabilityCard-module__AvailabilityCard
    ${availability_count}=    Get Length    ${availabilities}
    Should Be True    ${availability_count} > 1
    Sleep    10s
