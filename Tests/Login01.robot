*** Settings ***
Documentation    To validate the login on Production
Library    SeleniumLibrary

*** Test Cases ***
Login with valid credentials
    goto taskhuman.com/login
#    goto already have account and click on login
    Enter valid credentails and click on login

*** Keywords ***
goto taskhuman.com/login
    Open Browser    https://app.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    sleep    5s
    Wait Until Element Is Visible    id:field-:r0:
    sleep    5s
Enter valid credentails and click on login
    Input Text    id:field-:r0:    raghuramvvsp@gmail.com
    Input Text    id:field-:r1:    JOBSlogin@123
    Wait Until Element Is Visible    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']    10s
    Click Element    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']
    sleep    5s
    Wait Until Element Is Visible    xpath://div[normalize-space()='Settings']
    sleep    30s