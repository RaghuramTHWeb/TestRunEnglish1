*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/Reboot_Consumer_login.robot

*** Variables ***
${Reboot_user}   xpath=(//div[contains(@class, "PaymentModal-module__PaymentModal--CreditOption")])    10s
${Internal_user}  Free!

*** Test Cases ***
Open the browser and login as Consumer
    Login As Consumer    ${consumer_email}    ${consumer_password}
    
AfterLogin_ Validate user lands on discovery page after login
    Validate Discover section and check if content is loaded

AfterLogin_ Validate if all the registered programs visibility and horizontal scroll
    Validate if all the registered programs visibility and horizontal scroll

AfterLogin_ Validate on click behavior of each tile under every program/dictionary
    Validate on click behavior of each tile under every program/dictionary
    
AfterLogin_ Validate based on type of ambassador, Free/Paid mins info should be displayed
    Validate based on type of ambassador, Free/Paid mins info should be displayed

AfterLogin_ Check Blog on Discover screen
    Check Blog on Discover screen

AfterLogin_ Validate on click behavior of "How Programs Work" which is listed below Programs
    Validate on click behavior of "How Programs Work"
    Close Browser
AfterLogin_ Validate if new user is landed on Discover page with "Welcome to Taskhuman" category selected
    Validate if new user is landed on Discover page with "Welcome to Taskhuman" category selected
    Close Browser

*** Keywords ***
Validate Discover section and check if content is loaded
        Reload Page
        Wait Until Element Is Visible    css=a.MenuBar-module__NavItem.MenuBar-module__active div.MenuBar-module__NavItem--link__lable.css-0    10s
        Click Element   css=a.MenuBar-module__NavItem.MenuBar-module__active div.MenuBar-module__NavItem--link__lable.css-0
        Wait Until Page Contains    How Programs Work    5s
Validate if all the registered programs visibility and horizontal scroll
        Wait Until Element Is Visible    xpath=(//div[contains(@class, "DiscoverTab-module__Header--tab")])[1]    10s
        Click Element    xpath=(//div[contains(@class, "DiscoverTab-module__Header--tab")])[1]
        Wait Until Element Is Visible    xpath=(//div[contains(@class, "DiscoverTab-module__Header--tab")])[last()]    10s
        Click Element    xpath=(//div[contains(@class, "DiscoverTab-module__Header--tab")])[last()]
        Wait Until Element Is Visible    xpath=(//div[contains(@class, "DiscoverTab-module__Header--tab")])[1]    10s
        Click Element    xpath=(//div[contains(@class, "DiscoverTab-module__Header--tab")])[1]
Validate on click behavior of each tile under every program/dictionary
        Wait Until Element Is Visible    xpath=(//div[contains(@class, "DiscoverTab-module__Header--tab")])[last()]    10s
        Click Element    xpath=(//div[contains(@class, "DiscoverTab-module__Header--tab")])[last()]
        Wait Until Element Is Visible    xpath=(//div[contains(@class, "index-module__SessionType--Tab--Box")]/p)[1]    10s
        Click Element                   xpath=(//div[contains(@class, "index-module__SessionType--Tab--Box")]/p)[1]
        Wait Until Element Is Visible    xpath=(//div[contains(@class, "index-module__SessionType--Tab--Box")]/p)[2]    10s
        Click Element                   xpath=(//div[contains(@class, "index-module__SessionType--Tab--Box")]/p)[2]
Validate based on type of ambassador, Free/Paid mins info should be displayed
        Wait Until Element Is Visible    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']    10s
        Click Element    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']
        ${status1}=    Run Keyword And Return Status    ${Reboot_user}
        ${status2}=   Run Keyword And Return Status    ${Internal_user}
        Run Keyword If    ${status1}    Log    User is Reboot
        Run Keyword If    ${status2}    Log    User is Internal
Check Blog on Discover screen
        Go To    https://app-dev.taskhuman.com/discover/66d99d3082098164d315705d
        Wait Until Element Is Visible    xpath=//p[contains(@class, 'DiscoverProgram-module__DiscoverProgram--title__text') and contains(text(), 'BLOG')]    10s
Validate on click behavior of "How Programs Work"
        Wait Until Page Contains    How Programs Work    10s
Validate if new user is landed on Discover page with "Welcome to Taskhuman" category selected
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:    10s
    Input Text    id:field-:r0:    raghuram.m+newuserwth@taskhuman.com
    Input Text    id:field-:r1:    asd@123Q
    Click Element    xpath://button[@value='submit']
    Sleep    2s
    Reload Page
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Welcome-module__Welcome--Headers')]    10s
    Sleep    2s
