*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Opening Chrome In Incognito Mode and login as provider
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    options=add_argument("--incognito")
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:
    sleep    8s
    Wait Until Element Is Visible    xpath://input[@id='field-:r0:']
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    raghuram.m+rp1@taskhuman.com
    Sleep    5s
    Wait Until Element Is Visible   xpath://input[@id='field-:r1:']
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    asdfgh@12345A
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    3s
Taking Provider Online and will fail if already online
    Wait Until Element Is Visible    xpath://button[@id='go_online_now']
    Click Element    xpath://button[@id='go_online_now']
    sleep    5s
    Click Element    xpath://button[text()='Save']
    Sleep    1d
Login as Consumer
    Open Browser    https://app-dev.taskhuman.com/login    Chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    id:field-:r0:
    sleep    8s
    Wait Until Element Is Visible    xpath://input[@id='field-:r0:']
    Click Element    xpath://input[@id='field-:r0:']
    Input Text    id:field-:r0:    raghuram.m+rc1@taskhuman.com
    Sleep    5s
    Wait Until Element Is Visible   xpath://input[@id='field-:r1:']
    Click Element    xpath://input[@id='field-:r1:']
    Input Text    id:field-:r1:    asdfgh@12345Q
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    4s
#Search for provider and click on profile details
#   Wait Until Element Is Visible    xpath://p[@class='chakra-text FloatinSearchButton-module__Sticky--Button--Text css-0']
#   Sleep    3s
#   Click Element    xpath://p[@class='chakra-text FloatinSearchButton-module__Sticky--Button--Text css-0']
#   Sleep    5s
##   Click Element    xpath://p[@class='chakra-text Search-module__search--box--skill__text Search-module__active css-0']
#  Sleep    3s
#   Wait Until Element Is Visible    xpath://p[normalize-space()='Name']
#   Click Element    xpath://p[normalize-space()='Name']
goto provider profile
    Go To    https://app-dev.taskhuman.com/profile/5466
    sleep    5s
> Call provider
    Wait Until Element Is Visible    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Click Element    xpath://div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
    Sleep    5s
    Wait Until Element Is Visible    css:.CallForm-module__CallForm--ContinueCall__Skill
    Click Element    css:.CallForm-module__CallForm--ContinueCall__Skill
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
    Click Element    xpath://*[text()='Next']
    Sleep    5s
     Click Element    xpath://*[text()='Connect Now']
    Sleep    5s
Accept Call as Provider
    # Switch to the incognito browser
    Switch Browser    incognito
    Wait Until Element Is Visible    xpath://*[text()='Accept']
    Click Element    xpath://*[text()='Accept']
    Sleep    50s
