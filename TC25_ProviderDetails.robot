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
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
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


*** Test Cases ***

Login as Consumer in Normal Mode
    # Test case to log in as a consumer in normal mode.
    Login as Consumer
Validate Icons, Name Languages Are visible
    Go To    https://app-dev.taskhuman.com/profile/5466/about
    Wait Until Element Is Visible    css=div.Profile-module__ProviderProfile--UserInfo__AvtarContainer    10s
    Wait Until Element Is Visible    css=span.chakra-avatar.UserAvatar-module__xxl--Avatar    10s
    Wait Until Element Is Visible    css=div.Profile-module__ProviderProfile--UserInfo__NameContainer    10s
    Wait Until Element Is Visible    css=div.Profile-module__ProviderProfile--UserInfo__Name    10s
    Wait Until Element Is Visible    css=div.Profile-module__ProviderProfile--UserInfo__Languages    10s
    Wait Until Element Is Visible    css=div.ActionMenu-module__ActionMenu--List    10s
Validate Availability and About me visible or not
    Wait Until Element Is Visible    css=div[data-testid="about"]    10s
    Wait Until Element Is Visible    css=div[data-testid="availability"]    10s
Validate if My coaching area is visible with skills
    Wait Until Element Is Visible    css=div.AboutMeTab-module__User--CoachingAreas    10s
    Wait Until Element Is Visible    css=div[data-testid="skill-name"]    10s
Validate if TaskHuman Highlights visible
   Scroll Element Into View    xpath=//p[normalize-space()='TaskHuman Highlights']

    Wait Until Element Is Visible    xpath=//div[contains(@class, 'User--Highlights__Body__Card') and .//div[normalize-space()='Time Coached']]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'User--Highlights__Body__Card') and .//div[normalize-space()='Coaching Sessions Delivered']]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'User--Highlights__Body__Card') and .//div[normalize-space()='Users Engaged']]    10s

   # Wait Until Element Is Visible    xpath=//div[contains(@class, 'User--Highlights__Count') and contains(text(), '50+ hrs')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'User--Highlights__Count') and contains(text(), '1000+')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'User--Highlights__Count') and contains(text(), '50+')]    10s
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
