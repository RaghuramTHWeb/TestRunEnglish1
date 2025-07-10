*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q

*** Test Cases ***
Open the browser and login as Consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//div[@class='Login-module__signup-text css-0']    5s
    Sleep    3s
    Click Element    xpath=//div[@class='Login-module__signup-text css-0']
    Sleep    3s
    Wait Until Element Is Visible    id:field-:r0:    5s
    Sleep    3s
    Input Text    id:field-:r0:    ${email}
    Input Text    id:field-:r1:    ${Password}
    Click Element    xpath=//button[@value='submit']
    Sleep    2s
Check Request provider flow & when user tapped on request button it should redirect to concierge chat
    #pop is displayed at present
    Go To    https://app-dev.taskhuman.com/profile/5466
    Sleep    2s
    Wait Until Element Is Visible    xpath://img[4]    3s
    Click Element    xpath://img[4]
    Sleep    2s
    Wait Until Element Is Visible    xpath://*[text()='Feature Coming Soon!']
    Wait Until Element Is Visible    xpath://*[text()='Got It!']
    Click Element    xpath://*[text()='Got It!']
    Sleep    2s
Check chat icon if tapped taking to chat screen of provider under selected skill
    Go To    https://app-dev.taskhuman.com/profile/5466
    Sleep    2s
    Wait Until Element Is Visible    xpath://img[@src='/58fa62dcc433ef9fa89b.svg' and @class='chakra-image css-0']    3s
    Click Element    //img[@src='/58fa62dcc433ef9fa89b.svg' and @class='chakra-image css-0']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'MessageModal-module__Prase--Tag') and contains(@class, 'css-1fhfbim') and text()='Weight']    10s
    Click Element    //span[contains(@class, 'MessageModal-module__Prase--Tag') and contains(@class, 'css-1fhfbim') and text()='Weight']
    Sleep    3s
    Click Element    xpath://*[text()='Next']
    Sleep    2s
    Location Should Be    https://app-dev.taskhuman.com/messages/5466/Weight
    Sleep    2s
Check if message sent by consumer showing the time of sent
    Wait Until Element Is Visible    xpath://input[@class='chakra-input InputField-module__Message--Input css-1mh8t8j' and @maxlength='300']    3s
    Click Element    xpath://input[@class='chakra-input InputField-module__Message--Input css-1mh8t8j' and @maxlength='300']
    Sleep    2s
    Input Text    xpath://input[@class='chakra-input InputField-module__Message--Input css-1mh8t8j' and @maxlength='300']    test
    Wait Until Element Is Visible    xpath://button[@type='submit']    3s
    Click Element    xpath://button[@type='submit']
    Sleep    2s
    Wait Until Element Is Visible    css:div.Message-module__Message__Date--Tag.Message-module__small.css-0    3s
    Sleep    2s

