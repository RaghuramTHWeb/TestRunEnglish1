*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CONSUMER_EMAIL}    raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}    asdfgh@12345Q

*** Test Cases ***
Login as Consumer
    # Logs in as a consumer in normal mode.
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:
    Sleep    8s
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    ${CONSUMER_EMAIL}
    Sleep    5s
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    ${CONSUMER_PASSWORD}
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

Goto Provider Profile
    # Goes to the provider profile page.
    Go To    https://app-dev.taskhuman.com/profile/5466
    Sleep    5s

Call Provider
    # Calls the provider and clicks through the steps.
    Wait Until Element Is Visible    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Click Element    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Sleep    5s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'CallForm-module__CallForm--ContinueCall__Skill') and contains(@class, 'css-0') and text()='1045']    20s
    Click Element    xpath=//div[contains(@class, 'CallForm-module__CallForm--ContinueCall__Skill') and contains(@class, 'css-0') and text()='1045']
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Click Element    xpath://*[text()='Connect Now']
    Sleep    5s
    Wait Until Element Is Visible    xpath://*[text()='Got It!']    10s
    Click Element    xpath://*[text()='Got It!']
    sleep    5s
Check if 3 dots is visible
    Wait Until Element Is Visible    xpath=//img[@src='https://app-dev.taskhuman.com/zoom/17049a068482122f25e2.svg' and @class='chakra-image css-0']    10s
    Click Element    xpath=//img[@src='https://app-dev.taskhuman.com/zoom/17049a068482122f25e2.svg' and @class='chakra-image css-0']
Check if Noise reduciton option is visible
    Wait Until Element Is Visible    xpath://*[text()='Noise Reduction']    10s
    Click Element    xpath://*[text()='Noise Reduction']
Turn switch On and Off
    Wait Until Element Is Visible    //span[@class='chakra-switch__track css-u5xmy1']    10s
    Click Element    //span[@class='chakra-switch__track css-u5xmy1']
    Wait Until Element Is Visible    //span[@class='chakra-switch__thumb css-7roig']    10s
    Click Element    //span[@class='chakra-switch__thumb css-7roig']
        Wait Until Element Is Visible    //span[@class='chakra-switch__track css-u5xmy1']    10s
    Click Element    //span[@class='chakra-switch__track css-u5xmy1']
    Wait Until Element Is Visible    //span[@class='chakra-switch__thumb css-7roig']    10s
    Click Element    //span[@class='chakra-switch__thumb css-7roig']
    Sleep    30s
