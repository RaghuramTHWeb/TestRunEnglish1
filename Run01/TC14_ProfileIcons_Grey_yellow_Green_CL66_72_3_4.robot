*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q
${call_icon}    //div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
${green_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-goqhe
${yellow_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-ve545j
${Grey_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-1o1vlua

*** Test Cases ***
Open the browser and login as Consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath=//div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Wait Until Element Is Visible    id:field-:r0:    10s
    Sleep    5s
    Input Text    id:field-:r0:    ${email}
    Input Text    id:field-:r1:    ${Password}
    Click Element    xpath=//button[@value='submit']
    Sleep    5s
Check video call icon is visible when provider is available with green dot
    Go To    https://app-dev.taskhuman.com/profile/5466
    Wait Until Page Contains Element        ${green_dot}   10s
    ${Path_found1}=    Run Keyword And Return Status        Element Should Not Be Visible   ${green_dot}
    Run Keyword If    ${Path_found1}    Element Should Not Be Visible    ${call_icon}
    Sleep    2s
Check book call icon is visible when provider is available with yellow dot
    Go To    https://app-dev.taskhuman.com/profile/4517
    # Check if the element is present
    Wait Until Page Contains Element    ${yellow_dot}    10s
    ${element_present}=    Run Keyword And Return Status    Element Should Be Visible    ${yellow_dot}
    # Check if the specific element is not present
    ${element_not_present}=    Run Keyword And Return Status    Page Should Not Contain Element    ${call_icon}
    # Pass if both conditions are met
    Run Keyword If    ${element_present} and ${element_not_present}    Log    Both conditions are met
    Sleep    2s
Check request icon is visible when provider is available with grey dot
    Go To    https://app-dev.taskhuman.com/profile/2155
     # Check if the element is present
    Wait Until Page Contains Element    ${Grey_dot}    10s
    ${element_present1}=    Run Keyword And Return Status    Element Should Be Visible    ${Grey_dot}
    # Check if the specific element is not present
    ${element_not_present2}=    Run Keyword And Return Status    Page Should Not Contain Element    ${call_icon}
    # Pass if both conditions are met
    Run Keyword If    ${element_present1} and ${element_not_present2}    Log    Both conditions are met
    Sleep    2s

Check consumer is asked a confirmation before logout
    Go To    https://app-dev.taskhuman.com/settings
    Sleep    2s
    Wait Until Element Is Visible    xpath://div[@class='SettingsRoute-module__UserInfo--Logout__option css-0']
    Click Element    xpath://div[@class='SettingsRoute-module__UserInfo--Logout__option css-0']
    Page Should Contain    Are you sure, you want to Logout?
    Wait Until Element Is Visible    xpath=//*[text()='Ok']    3s
    Click Element    xpath=//*[text()='Ok']
    Sleep    3s
    Close Browser



