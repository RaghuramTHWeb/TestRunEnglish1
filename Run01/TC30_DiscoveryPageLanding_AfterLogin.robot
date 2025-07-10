*** Settings ***
Documentation    To validate Menu section
Library    SeleniumLibrary

*** Test Cases ***
Goto login page
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    sleep    5s
    Wait Until Element Is Visible    id:field-:r0:
    sleep    5s
Enter valid credentails and click on login
    Input Text    id:field-:r0:    raghuram.m+rc1@taskhuman.com
    Input Text    id:field-:r1:    asdfgh@12345Q
    Wait Until Element Is Visible    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']    10s
    Click Element    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']
    sleep    5s
Validate user lands on discovery page after login
    Wait Until Page Contains    How Programs Work    6s
    Page Should Contain    How Programs Work
    Sleep    5s
