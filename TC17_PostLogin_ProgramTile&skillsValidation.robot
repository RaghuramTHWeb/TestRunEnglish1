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
${SKILL_DETAILS_TITLE}              xpath=//div[contains(@class, 'SkillDetails-module__SkillDetails--header__title')]
${SKILL_DETAILS_PROVIDER_LIST}      xpath=//div[contains(@class, 'SkillDetails-module__SkillDetails--provider__list')]
${SKILL_DETAILS_CALENDAR}           xpath=//div[contains(@class, 'SkillDetails-module__Provider--Availaibility__calendar')]

*** Keywords ***

Login as Consumer
    # Logs in as a consumer in normal mode.
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
Validate Programs Visibility
    Wait Until Element Is Visible    css=.DiscoverTab-module__Header--tab:first-child    5s    
Validate on click behavior of each tile under every program/dictionary
    Go To    https://app-dev.taskhuman.com/discover/Explore%201:1%20Coaching/sub-skill/Leadership%20Coaching
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'SkillCard-module__card')])[1]    10s
    Click Element    xpath=(//div[contains(@class, 'SkillCard-module__card')])[1]
Validate skill details page and redirection after click
    Wait Until Element Is Visible    ${SKILL_DETAILS_TITLE}    10s
    Wait Until Element Is Visible    ${SKILL_DETAILS_PROVIDER_LIST}    10s
    Wait Until Element Is Visible    ${SKILL_DETAILS_CALENDAR}    10s
                

*** Test Cases ***

Login as Consumer in Normal Mode
    # Test case to log in as a consumer in normal mode.
    Login as Consumer
Validate Programs Visibility
    Validate Programs Visibility
Validate on click behavior of each tile under every program/dictionary
    Validate on click behavior of each tile under every program/dictionary
Validate skill details page and redirection after click
    Validate skill details page and redirection after click
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
