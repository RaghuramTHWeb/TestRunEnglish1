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
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!

*** Keywords ***

Login as Provider
    # Logs in as a consumer in normal mode.
    Open Browser    https://app-dev.taskhuman.com/login    Chrome
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    8s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${PROVIDER_EMAIL}
    Wait Until Element Is Visible   xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${PROVIDER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    4s

*** Test Cases ***

Login as Provider
    # Test case to log in as a consumer in normal mode.
    Login As Provider
Validate History Menu
    Wait Until Element Is Visible    css=a.MenuBar-module__NavItem[href='/provider/history']    10s
    Click Element    css=a.MenuBar-module__NavItem[href='/provider/history']
    Location Should Be    https://app-dev.taskhuman.com/provider/history
Validate Message Section
    Wait Until Element Is Visible    css=a.MenuBar-module__NavItem[href='/provider/messages']    10s
    Click Element    css=a.MenuBar-module__NavItem[href='/provider/messages']
    Location Should Be    https://app-dev.taskhuman.com/provider/messages
Validate If Provider can send message
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'index-module__NotificationCard')])[1]    10s
    Click Element    xpath=(//div[contains(@class, 'index-module__NotificationCard')])[1]
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'ChatsText-module__Back--Button')]    10s     #backbutton
    Wait Until Element Is Visible    xpath=//input[@maxlength='300']    10s
    Input Text                       xpath=//input[@maxlength='300']    Provider Sending Message
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(., 'Send')]    10s
    Click Button                     xpath=//button[@type='submit' and contains(., 'Send')]
    #Wait Until Element Contains      xpath=//div[contains(@class, 'Message__Date--Tag')]    Today
Validate settings module
    Wait Until Element Is Visible    xpath=//a[contains(@class, 'MenuBar-module__NavItem') and .//div[text()='Settings']]    10s
    Click Element    xpath=//a[contains(@class, 'MenuBar-module__NavItem') and .//div[text()='Settings']]
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'Preferences')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'Your Profile')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'Refer a Coach')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'Invite a Client')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'Handling Difficult Situations')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'FAQ')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'App Feedback')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'Terms and Conditions')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'ProviderSettings--MenuItem')]//p[contains(normalize-space(),'Privacy Policy')]    10s
Validate Concierge Module and send message
    Wait Until Element Is Visible    xpath=//a[contains(@class,'MenuBar-module__NavItem') and .//div[text()='Concierge']]    10s
    Click Element    xpath=//a[contains(@class,'MenuBar-module__NavItem') and .//div[text()='Concierge']]
    Location Should Be    https://app-dev.taskhuman.com/provider/concierge
    Wait Until Element Is Visible    xpath=//input[contains(@class,'InputField-module__Message--Input')]    10s
    Input Text    xpath=//input[contains(@class,'InputField-module__Message--Input')]    Provider sends message in concierge
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(@class,'InputField-module__Send--Button')]    10s
    Click Button    xpath=//button[@type='submit' and contains(@class,'InputField-module__Send--Button')]
    #Wait Until Element Contains    css=div.Message-module__Message__Date--Tag    Today    timeout=10s
Validate Each module in settings
    Go To    https://app-dev.taskhuman.com/provider/settings/referCoach
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ReferCoach-module__ReferCoach')]//a[contains(text(), 'Refer a Coach')]    10s
    Click Element    xpath=//div[contains(@class, 'ReferCoach-module__ReferCoach')]//a[contains(text(), 'Refer a Coach')]
    Switch Window    NEW
    Wait Until Location Is    https://taskhuman.com/community-referral/    10s
    Location Should Be    https://taskhuman.com/community-referral/

    #Go To    https://app-dev.taskhuman.com/provider/settings/inviteClient
    ##Wait Until Element Is Visible    xpath=//div[contains(@class,'InviteClient-module__InviteClient')]//a[contains(text(), 'TaskHuman Mobile App')]    10s
    #Click Element    xpath=//div[contains(@class,'InviteClient-module__InviteClient')]//a[contains(text(), 'TaskHuman Mobile App')]
    #Switch Window    NEW
    #Wait Until Location Is    https://taskhuman.com/download/    10s
    #Location Should Be  https://taskhuman.com/download/

    Go To    https://app-dev.taskhuman.com/provider/settings/hds
    Wait Until Element Is Visible    xpath=//div[contains(@class,'HandlingSituation-module__HandlingSituation')]//a[contains(text(), 'Handling Difficult Situations')]    10s
    Click Element    xpath=//div[contains(@class,'HandlingSituation-module__HandlingSituation')]//a[contains(text(), 'Handling Difficult Situations')]
    Switch Window    NEW
    Wait Until Location Is    https://taskhuman.zendesk.com/hc/en-us/articles/1500002217502-What-Should-I-Do-in-a-Difficult-Situation    10s
    Location Should Be    https://taskhuman.zendesk.com/hc/en-us/articles/1500002217502-What-Should-I-Do-in-a-Difficult-Situation

    Go To    https://app-dev.taskhuman.com/provider/settings/faq
    Wait Until Element Is Visible    xpath=//div[contains(@class,'SettingComponents-module__Faq')]//a[contains(text(),'FAQ')]    10s
    Click Element    xpath=//div[contains(@class,'SettingComponents-module__Faq')]//a[contains(text(),'FAQ')]
    Switch Window    NEW
    Wait Until Location Is    https://taskhuman.com/faq/    10s
    Location Should Be    https://taskhuman.com/faq/

    Go To    https://app-dev.taskhuman.com/provider/settings/feedback
    Wait Until Element Is Visible    xpath=//div[contains(@class,'SettingComponents-module__Feedback')]//a[contains(@href,'mailto:ask@taskhuman.com')]    10s

    Go To    https://app-dev.taskhuman.com/provider/settings/terms-conditions
    Wait Until Element Is Visible    xpath=//div[contains(@class,'SettingComponents-module__TermsAndCondition')]//a[contains(text(),'Terms and Conditions')]    10s
    Click Element    xpath=//div[contains(@class,'SettingComponents-module__TermsAndCondition')]//a[contains(text(),'Terms and Conditions')]
    Switch Window    NEW
    Wait Until Location Is    https://taskhuman.com/terms-conditions/    10s
    Location Should Be    https://taskhuman.com/terms-conditions/

    Go To    https://app-dev.taskhuman.com/provider/settings/privacy-policy
    Wait Until Element Is Visible    xpath=//div[contains(@class,'SettingComponents-module__PrivacyPolicy')]//a[contains(text(),'Privacy Policy')]    10s
    Click Element    xpath=//div[contains(@class,'SettingComponents-module__PrivacyPolicy')]//a[contains(text(),'Privacy Policy')]
    Switch Window    NEW
    Wait Until Location Is    https://taskhuman.com/privacy-policy/    10s
    Location Should Be    https://taskhuman.com/privacy-policy/

Provider Logout
        Go To    https://app-dev.taskhuman.com/provider/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
