*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${consumer_email}    raghuram.m+rc1@taskhuman.com
${consumer_password}    asdfgh@12345Q
${PROVIDER_EMAIL}    raghuram.m+rp1@taskhuman.com
${PROVIDER_PASSWORD}    asdfgh@12345A
${Internal_user_email}    raghuram.m+01@taskhuman.com
${Internal_user_Password}    asdfgh@12345A
${Internal_provider_email}
${Internal_provider_Password}
${NoAmbassador_email}    raghuram.m+newuserwth@taskhuman.com
${NoAmbassador_password}    asd@123Q

*** Keywords ***

Login As Consumer
    [Arguments]  ${email}  ${password}
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Input Text    xpath=//input[@name='email']   ${email}
    Input Text    xpath=//input[@name='password']   ${password}
    #Wait Until Element Is Visible    id:field-:r0:    10s
    #Input Text    id:field-:r0:    ${email}
    #Input Text    id:field-:r1:    ${password}
    Click Element    xpath://button[@value='submit']
    Sleep    5s
Login as Provider
    [Arguments]  ${email}  ${password}
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible   xpath=//input[@name='email']    10s
    Input Text    xpath=//input[@name='email']    ${PROVIDER_EMAIL}
    Input Text    xpath=//input[@name='password']    ${PROVIDER_PASSWORD}
    Click Element    xpath://button[@value='submit']
    Sleep    5s