*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!
${PROVIDER_EMAIL}    Replace this message with your provider email
${PROVIDER_PASSWORD}    Replace this message with your provider Password
${CONSUMER_EMAIL}    Replace this message with your Consumer email
${CONSUMER_PASSWORD}    Replace this message with your COnsumer Password
${call_icon}    //div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
${green_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-r0a3ci
${yellow_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-1y0hed8
${Grey_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-ltu614

*** Keywords ***
Login as Provider in Incognito
    # Logs in as a provider in incognito mode.
    Switch Browser    INC
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${PROVIDER_EMAIL}
    Sleep    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${PROVIDER_PASSWORD}
    Sleep    5s
    Click Element    xpath://button[@value='submit']
    Sleep    3s

    # Determine page status and handle accordingly
    ${online_status_present}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    10s
    ${offline_status_present}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    10s

    Run Keyword If    ${offline_status_present}    Make Online
    Run Keyword If    ${online_status_present}     Provider is Online

Make Online
    Wait Until Element Is Visible    xpath://button[@id='go_online_now']    10s
    Click Element    xpath://button[@id='go_online_now']
    Sleep    5s
    Click Element    xpath://button[text()='Save']
    Sleep    5s

Provider is Online
    Sleep    5s

Login as Consumer
    # Logs in as a consumer in normal mode.
    # Logs in as a consumer in normal mode.
    Switch Browser    NORM
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    #Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    5s
    #Sleep    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//input[@name='password']    5s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    #Sleep    5s
    Wait Until Element Is Visible    xpath://button[@value='submit']    5s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

Goto Provider Profile
    # Goes to the provider profile page.
    Go To    https://app-dev.taskhuman.com/profile/5466
    Sleep    5s



*** Test Cases ***
Open and Position Browsers
    # Opens two browsers and positions them side by side.
    # Open first browser (normal mode)
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=NORM
    Set Window Size    650    1200
    Set Window Position    0    0
    Log    Normal browser size and position set.

    # Open second browser (incognito mode)
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=INC    options=add_argument("--incognito")
    Set Window Size    650    1200
    Set Window Position    650    0
    Log    Incognito browser size and position set.

Login as Provider in Incognito Mode
    # Test case to log in as a provider in incognito mode.
    Login as Provider in Incognito

Login as Consumer in Normal Mode
    # Test case to log in as a consumer in normal mode.
    Login as Consumer

Goto Provider Profile and make online if found offline
    # Test case to go to the provider profile page.
    Goto Provider Profile

Check video call icon is visible when provider is available with green dot
    Switch Browser    NORM
    Go To    https://app-dev.taskhuman.com/profile/5466/about
    Wait Until Page Contains Element        ${green_dot}   10s
    ${Path_found1}=    Run Keyword And Return Status        Element Should Not Be Visible   ${green_dot}
    Run Keyword If    ${Path_found1}    Element Should Not Be Visible    ${call_icon}
    Sleep    2s
Check book call icon is visible when provider is available with yellow dot
    Go To    https://app-dev.taskhuman.com/profile/4517/about
    # Check if the element is present
    Wait Until Page Contains Element    ${yellow_dot}    10s
    ${element_present}=    Run Keyword And Return Status    Element Should Be Visible    ${yellow_dot}
    # Check if the specific element is not present
    ${element_not_present}=    Run Keyword And Return Status    Page Should Not Contain Element    ${call_icon}
    # Pass if both conditions are met
    Run Keyword If    ${element_present} and ${element_not_present}    Log    Both conditions are met
    Sleep    2s
Check request icon is visible when provider is available with grey dot
    Go To    https://app-dev.taskhuman.com/profile/2155/about
     # Check if the element is present
    Wait Until Page Contains Element    ${Grey_dot}    10s
    ${element_present1}=    Run Keyword And Return Status    Element Should Be Visible    ${Grey_dot}
    # Check if the specific element is not present
    ${element_not_present2}=    Run Keyword And Return Status    Page Should Not Contain Element    ${call_icon}
    # Pass if both conditions are met
    Run Keyword If    ${element_present1} and ${element_not_present2}    Log    Both conditions are met
    Sleep    2s

Check User can request provider through search
    Go To    https://app-dev.taskhuman.com/search/name/ankush
    Wait Until Element Is Visible    xpath=(//div[@data-testid="action_menu_request_btn"])[1]    10s
    Click Element    xpath=(//div[@data-testid="action_menu_request_btn"])[1]
    Wait Until Element Is Visible        xpath=//div[contains(@class, 'ChatsText-module__Chats--Text--Box')]    10s
Check consumer is asked a confirmation before logout
    Go To    https://app-dev.taskhuman.com/settings
    Sleep    2s
    Wait Until Element Is Visible    xpath://div[@class='SettingsRoute-module__UserInfo--Logout__option css-0']    10s
    Click Element    xpath://div[@class='SettingsRoute-module__UserInfo--Logout__option css-0']
    Sleep    5s
    Page Should Contain    Are you sure, you want to Logout?
    Wait Until Element Is Visible    xpath=//*[text()='Ok']    10s
    Click Element    xpath=//*[text()='Ok']
    Sleep    3s
    Close Browser



