*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q

*** Test Cases ***
Open the browser and login as Consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath=//div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Wait Until Element Is Visible    id:field-:r0:    10s
    Sleep    5s
    Input Text    id:field-:r0:    ${email}
    Input Text    id:field-:r1:    ${Password}
    Click Element    xpath=//button[@value='submit']
    Sleep    5s

Check if different providers are listed
    Go To    https://app-dev.taskhuman.com/chats
    Wait Until Element Is Visible    xpath=//*[text()='Raghu']    10s
    Sleep    2s
    Wait Until Element Is Visible    xpath=//*[text()='Paul Provider']    10s
    Wait Until Element Is Visible    xpath=//*[text()='Ankush']    10s
    Sleep    2s

Check if any tile or provider name tapped by consumer should open a chat screen
    Wait Until Element Is Visible    xpath=(//p[contains(text(), 'Raghu')])[1]    20s
    Click Element    xpath=(//p[contains(text(), 'Raghu')])[1]
    Sleep    2s

Check call duration for the calls are shown
    Wait Until Element Is Visible    xpath=//img[@class='BackButton-module__BackButton css-0']   # back to chats
    Click Element    xpath=//img[@class='BackButton-module__BackButton css-0']
    Sleep    3s
    ${text_present}=    Execute JavaScript    return document.body.innerText.includes('Session Duration:')
    Should Be True    ${text_present}    The text 'Session Duration:' was not found on the page.
    Sleep    2s
Check last chat time is shown along with date
    Wait Until Element Is Visible    xpath=(//p[contains(text(), 'Raghu')])[1]    20s
    Click Element    xpath=(//p[contains(text(), 'Raghu')])[1]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Message-module__Message__Date--Tag')]    10s
    Sleep    2s
