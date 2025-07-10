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
    
Goto settings and validate terms and conditions page redirection and content
        #Wait Until Element Is Visible    xpath://a[@href='/settings']    10s
        #Click Element    xpath://a[@href='/settings']
#        sleep    3s
        Wait Until Element Is Visible    xpath=//a[@test-dataid="Settings"]    10s
        Sleep    5s
        Click Element    xpath=//a[@test-dataid="Settings"] 
        Go To        https://app-dev.taskhuman.com/settings/terms-conditions
        Wait Until Element Is Visible    xpath://a[normalize-space()='Terms and Conditions']    10s
        Click Element    xpath://a[normalize-space()='Terms and Conditions']
        Switch Window    NEW
        Wait Until Location Is    https://taskhuman.com/terms-conditions/    10s
        Location Should Be    https://taskhuman.com/terms-conditions/
#        Sleep    3s
        Go To    url=https://app-dev.taskhuman.com/settings
        Sleep    3s
To validate Privacy policy section
        Wait Until Page Contains    Privacy Policy    10s
        Click Element    xpath=//*[contains(text(), 'Privacy Policy')]
#        Sleep    3s
        Wait Until Element Is Visible    xpath://a[normalize-space()='Privacy Policy']    10s
        Click Element    xpath://a[normalize-space()='Privacy Policy']
#        Sleep    3s
        Switch Window    NEW
        Wait Until Location Is    https://taskhuman.com/privacy-policy/    10s
        Location Should Be    https://taskhuman.com/privacy-policy/
        Sleep    3s
To Validate Preferences section
        Go To    https://app-dev.taskhuman.com/settings/preferences
        Sleep    3s
        Wait Until Element Is Visible    xpath=//div[@class='SettingComponents-module__Preferences--DeactivateBtn css-0']
        #Sleep    3s
To validate Payment method
        Go To    https://app-dev.taskhuman.com/settings/payment-method
        Wait Until Element Is Visible    xpath://button[normalize-space()='Add Payment Method']
       # Sleep    3s
To validate Invite section
        Go To    https://app-dev.taskhuman.com/settings/invite
        Wait Until Element Is Visible    xpath://img[@class='SettingComponents-module__QrImage css-0']    10s
        #Sleep    3s
To validate join a program screen
        Go To    https://app-dev.taskhuman.com/settings/join-program
        Wait Until Element Is Visible    xpath://div[@class='SettingComponents-module__Discount--Coupons__Icon css-0']    10s
       # Sleep    3s
To validate FAQ section
        Go To    https://app-dev.taskhuman.com/settings/faq
        Wait Until Element Is Visible    xpath://a[normalize-space()='FAQ']    10s
        Click Element    xpath://a[normalize-space()='FAQ']
        #Sleep    3s
        Switch Window    NEW
        Wait Until Location Is    https://taskhuman.com/faq/    10s
        Location Should Be    https://taskhuman.com/faq/
        #Sleep    3s
To validate App feedback section
        Go To    https://app-dev.taskhuman.com/settings/feedback
        #Sleep    3s
        Wait Until Element Is Visible    xpath://*[text()='ask@taskhuman.com']    10s
        #Sleep    3s
To validate Notification settings section
        Go To    https://app-dev.taskhuman.com/settings/notification-settings
        Wait Until Element Is Visible    xpath://p[@class='chakra-text SettingComponents-module__How--Notification--Work--Text css-0']    10s
        Sleep    3s
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
