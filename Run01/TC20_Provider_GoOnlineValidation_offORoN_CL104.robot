
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}         raghuram.m+rp1@taskhuman.com
${Password}      asdfgh@12345A
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!

*** Test Cases ***
Check provider is able to add availability for right now by tapping "go online now " button in orange color
#Open the browser and login as Provider
#Check page status and then execute
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

    # Determine page status
    ${online_status_present}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    5s
    ${offline_status_present}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    5s

    # Execute the appropriate handler based on the page status
    Run Keyword If    ${online_status_present}    Handle Online Status
    Run Keyword If    ${offline_status_present}    Handle Offline Status

*** Keywords ***
Handle Online Status
    Sleep    2s
    Execute JavaScript    document.elementFromPoint(1211, 115).click();
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button DeleteForm-module__deleteButton css-s88bex' and text()='Delete']    5s
    Click Element    xpath=//button[@class='chakra-button DeleteForm-module__deleteButton css-s88bex' and text()='Delete']
    Sleep    2s
    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    5s
    Sleep    2s
    Wait Until Element Is Visible    //button[@id='go_online_now']    timeout=10s
    Click Element    //button[@id='go_online_now']
    Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Save']    5s
    Click Element    xpath://*[text()='Save']
    Sleep    2s
    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    5s
    Sleep    2s

Handle Offline Status
    Wait Until Element Is Visible    //button[@id='go_online_now']    timeout=10s
    Click Element    //button[@id='go_online_now']
    Sleep    2s
    Wait Until Page Contains Element    xpath://*[text()='Save']    5s
    Click Element    xpath://*[text()='Save']
    Sleep    2s
    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    5s
    Sleep    2s
    Close Browser