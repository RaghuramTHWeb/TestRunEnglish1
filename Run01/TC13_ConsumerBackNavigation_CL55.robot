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
Validate Back Navigaiton from skills in discovery page
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'DiscoverProgram-module__Program--Card__Flex')]    10s
    Click Element                   xpath=//div[contains(@class, 'DiscoverProgram-module__Program--Card__Flex')]
    Sleep    2s
    Wait Until Element Is Visible    xpath=//img[@class='BackButton-module__BackButton css-0']   # back to chats
    Click Element    xpath=//img[@class='BackButton-module__BackButton css-0']
    Sleep    3s
Validate Back navigation from provider profile 
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'DiscoverProgram-module__Program--Card__Flex')]    10s
    Click Element                   xpath=//div[contains(@class, 'DiscoverProgram-module__Program--Card__Flex')]
    Sleep    2s
    Wait Until Element Is Visible    xpath://*[text()='Raghu']    3s
    Click Element    xpath://*[text()='Raghu']
    Wait Until Element Is Visible    xpath=//img[@class='BackButton-module__BackButton css-0']   # back to chats
    Click Element    xpath=//img[@class='BackButton-module__BackButton css-0']
    Sleep    3s
validate back navigation from library/blogs
    Go To    https://app-dev.taskhuman.com/library
    Wait Until Element Is Visible    xpath://*[text()='A Leadership Mindset']    6s
    Click Element    xpath://*[text()='A Leadership Mindset']
    Wait Until Element Is Visible    xpath=//img[@class='BackButton-module__BackButton css-0']   # back to chats
    Click Element    xpath=//img[@class='BackButton-module__BackButton css-0']
    Sleep    3s
    Location Should Be    https://app-dev.taskhuman.com/library
    Sleep    3s
    Close Browser