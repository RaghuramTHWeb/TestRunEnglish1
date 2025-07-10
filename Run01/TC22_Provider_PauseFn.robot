*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}         raghuram.m+rp1@taskhuman.com
${Password}      asdfgh@12345A
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!

*** Test Cases ***
Check Pause Functionality
    # Check if status is offline or Online
         #If Offline, make Online and run :Verify Pause functionality
         #If Online, directly run: Verify Pause functionality
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

    # Determine page status and handle accordingly
    ${online_status_present}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    5s
    ${offline_status_present}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    5s

    Run Keyword If    ${offline_status_present}    Make Online And Verify Pause Functionality
    Run Keyword If    ${online_status_present}    Verify Pause Functionality

*** Keywords ***
Make Online And Verify Pause Functionality
    Wait Until Element Is Visible    xpath=//button[@id='go_online_now']    10s
    Click Element    xpath=//button[@id='go_online_now']
    Sleep    5s
    Wait Until Element Is Visible    xpath=//*[text()='Save']    10s
    Click Element    xpath=//*[text()='Save']
    Sleep    5s
    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    10s
    Verify Pause Functionality

Verify Pause Functionality
    Wait Until Element Is Visible    xpath=//*[text()="Pause"]    10s
    Click Element    xpath=//*[text()="Pause"]
    Sleep    5s
    Wait Until Page Contains Element    xpath=//*[text()="Take a break. You deserve it!"]    10s
    Sleep    5s
    Wait Until Element Is Visible    xpath=//*[text()="Continue"]    10s
    Click Element    xpath=//*[text()="Continue"]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//*[text()="Continue"]    10s
    Click Element    xpath=//*[text()="Continue"]
    Sleep    5s
    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    10s
    Close Browser
