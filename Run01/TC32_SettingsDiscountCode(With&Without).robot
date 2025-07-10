*** Settings ***
Documentation    To validate Menu section
Library    SeleniumLibrary

*** Test Cases ***
Validate Menu Section Based on User Type
    Goto login page
    Enter valid credentials and click on login
Goto settings and check for Discount code section
    Goto settings and check for Discount code section
Validate user lands on discovery page after login
    Validate user lands on discovery page after login

*** Keywords ***
Goto login page
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    sleep    5s
    Wait Until Element Is Visible    id:field-:r0:
    sleep    5s

Enter valid credentials and click on login
    Input Text    id:field-:r0:    raghuram.m+rc1@taskhuman.com
    Input Text    id:field-:r1:    asdfgh@12345Q
    Wait Until Element Is Visible    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']    10s
    Click Element    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']
    sleep    5s

Goto settings and check for Discount code section
        Go To    https://app-dev.taskhuman.com/settings
        Sleep    5s
        Run Keyword And Ignore Error    Page Should Not Contain    Check for Discounts
    ${status} =    Run Keyword And Return Status    Page Should Contain    Check for Discounts
    Run Keyword If    '${status}' == 'False'    Evaluate User Type
    Sleep    10s

Evaluate User Type
    Wait Until Element Is Visible    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']    8s
    Click Element    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']
    Sleep    5s
    ${internal_user} =    Run Keyword And Return Status    Page Should Contain    Free!
    Run Keyword If    '${internal_user}' == 'True'    Log To Console    Internal user identified
    Run Keyword If    '${internal_user}' == 'False'    Check for Reboot User

Check for Reboot User
    Wait Until Page Contains    Buy Minutes    5s
    Log To Console    Reboot user identified
Validate user lands on discovery page after login
    Wait Until Page Contains    How Programs Work    6s