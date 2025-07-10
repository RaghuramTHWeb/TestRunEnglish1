*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!
${PROVIDER_EMAIL}    Replace this message with your provider email
${PROVIDER_PASSWORD}    Replace this message with your provider Password
${CONSUMER_EMAIL1}   Replace this message with your Consumer email
${CONSUMER_PASSWORD1}    Replace this message with your COnsumer Password
${CONSUMER_EMAIL}    Replace this message with your Consumer email
${CONSUMER_PASSWORD}    Replace this message with your COnsumer Password
*** Test Cases ***
#Validate if user can switch to coach view and user view
 #   Login as provider1
  #  validate Switch to coach view
   # Switch To User View and validate if switched correctly
    #Check if tile is visible in discovery section by switching to user view
Validate Language filter
    Login as Provider
    Validate Language filter

*** Keywords ***
Login as provider1
     # Logs in as a consumer in normal mode.
    Open Browser    https://app-dev.taskhuman.com/login    Chrome
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL1}
    Wait Until Element Is Visible   xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD1}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

validate Switch to coach view
    #Wait Until Element Is Visible    css:button[class='chakra-button TopBar-module__Topbar--Switch__Button css-i857na']
    #Click Element    css:button[class='chakra-button TopBar-module__Topbar--Switch__Button css-i857na']
    Wait Until Element Is Visible  xpath=//*[text()='Switch to Coach View']    10s
    Click Element  xpath=//*[text()='Switch to Coach View']
Switch To User View and validate if switched correctly
    #Sleep    3s
    #Reload Page
    Wait Until Element Is Visible  xpath=//*[text()='Switch to User View']    10s
    Click Element  xpath=//*[text()='Switch to User View']
Check if tile is visible in discovery section by switching to user view
    Wait Until Element Is Visible    css=.DiscoverTab-module__Header--tab:first-child    10s
Login as Provider
    Open Browser    https://app-dev.taskhuman.com/login    Chrome
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    Wait Until Element Is Visible   xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    4s
Validate Language filter
    Go To    https://app-dev.taskhuman.com/discover/skill/60bf98904001875ded7ca5ad
    Wait Until Element Is Visible    css=div.LanguageFilter-module__Filter--Header    10s
    Sleep    2S
    #Execute JavaScript    document.querySelectorAll("span.chakra-checkbox__control")[1].click()
    #Execute JavaScript    document.querySelectorAll("span.chakra-checkbox__control")[2].click()
    Execute JavaScript    document.querySelector("span.chakra-checkbox__label").click()
    Sleep    1s
    Page Should Contain Element    xpath=//span[contains(@class, 'LanguageFilter-module__Applied--Count--Badge')]//div
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
