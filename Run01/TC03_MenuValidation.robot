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
Validating Minutes Section and check if content is loaded
        Wait Until Element Is Visible    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']
        Click Element   xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']
        Sleep    3s
        Wait Until Page Contains    Time Well Spent!
        Sleep    2s
Validate Discover section and check if content is loaded
        Reload Page
        Sleep    3s
        Wait Until Element Is Visible    css=a.MenuBar-module__NavItem.MenuBar-module__active div.MenuBar-module__NavItem--link__lable.css-0
        Click Element   css=a.MenuBar-module__NavItem.MenuBar-module__active div.MenuBar-module__NavItem--link__lable.css-0
        Sleep    3s
        Wait Until Page Contains    How Programs Work    5s
        Sleep    3s
Validate Bookings Section and check if content is loaded
        Wait Until Element Is Visible    xpath://div[normalize-space()='Bookings']
        Click Element   xpath://div[normalize-space()='Bookings']
        Sleep    3s
        Wait Until Page Contains    1:1 Sessions
        Sleep    3s
Validate Messages Section and check if content is loaded
        Wait Until Element Is Visible    xpath://div[normalize-space()='Messages']
        Click Element    xpath://div[normalize-space()='Messages']
        Sleep    3s
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    //div[contains(@class, 'index-module__NotificationCard')]    6s    OR    Wait Until Element Is Visible    xpath=//*[text()='Yesterday']    6s
        Run Keyword If    ${status}    Log    Element Found
        Sleep    2s
validate Library section and check if content is loaded
        Wait Until Element Is Visible    xpath://a[@href='/library']
        Click Element    xpath://a[@href='/library']
        Sleep    3s
        Wait Until Page Contains    Coaching
        Sleep    2s
validate Concierge section and check if content is loaded
        Wait Until Element Is Visible    xpath://div[normalize-space()='Concierge']
        Click Element    xpath://div[normalize-space()='Concierge']
        Sleep    3s
        Wait Until Page Contains    Team TaskHuman
        Sleep    2s
validate settings section and check if content is loaded
        Wait Until Element Is Visible    xpath://a[@href='/settings']
        Click Element    xpath://a[@href='/settings']
        Sleep    3s
Menu Section is working fine
        Sleep    2s

        Close Browser

