*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***
${MAIN_CONTAINER}    xpath=//div[contains(@class,"Welcome-module__Welcome")]
${HEADERS}           xpath=//div[contains(@class,"Welcome--Headers")]
${BLOGS_BOX}         xpath=//div[contains(@class,"Welcome--Blogs__Box")]
${CARD_LIST}         xpath=//div[contains(@class,"CardListContainer")]
${CONSUMER_EMAIL}    Replace user email whith new account only
${CONSUMER_PASSWORD}    Replace message with your password

*** Test Cases ***
Open the browser and login as New Consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    #Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    Wait Until Element Is Visible    xpath=//input[@name='password']    10s
    #Sleep    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    #Sleep    5s
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    3s
Validate Welcome Module And Sub-Modules
    Wait Until Element Is Visible    ${MAIN_CONTAINER}    10s
    Wait Until Element Is Visible    ${HEADERS}           10s
    Wait Until Element Is Visible    ${BLOGS_BOX}         10s
    Wait Until Element Is Visible    ${CARD_LIST}         10s
    #Log     All Welcome sub-modules are visible
    Close Browser
