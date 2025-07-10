*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}    raghuram.m+01@taskhuman.com
${Password}    asdfgh@12345A

*** Test Cases ***
Open the browser and login as Internal consumer
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
validate if user has unlimited credits
    Wait Until Element Is Visible    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']
    Click Element    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']
    Sleep    5s
    Wait Until Page Contains    Free!    5s
    Sleep    5s