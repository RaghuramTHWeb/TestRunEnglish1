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
${CONCIERGE_MENU_LABEL}    xpath=//a[@href="/concierge"]

# 1. Container for actor/user info (e.g., avatar, name, category)
${CHAT_ACTOR_INFO_BOX}              xpath=//div[contains(@class, 'ChatsText-module__Actor--Info')]

# 2. Container for the actor's name and chat category
${CHAT_ACTOR_NAME_CATEGORY_BOX}     xpath=//div[contains(@class, 'ChatsText-module__Actor--Name--Box')]

# 3. Container for all the chat messages/text
${CHAT_TEXT_MESSAGES_BOX}           xpath=//div[contains(@class, 'ChatsText-module__Chats--Text--Box')]

# --- Input Field and Send Button Form ---
# 4. The entire form containing the message input and send button
${CHAT_INPUT_FORM}                  xpath=//form[contains(@class, 'InputField-module__Input--Box')]

*** Test Cases ***
Open the browser and login as Consumer
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
Validate that clicking on concierge in menu redirects user to concierge page
    Wait Until Element Is Visible    ${CONCIERGE_MENU_LABEL}    10s
    Sleep    5s
    Click Element    ${CONCIERGE_MENU_LABEL}
    Location Should Be    https://app-dev.taskhuman.com/concierge
Validate Concierge page details
    Wait Until Element Is Visible    ${CHAT_ACTOR_INFO_BOX}    10s
    Wait Until Element Is Visible    ${CHAT_ACTOR_NAME_CATEGORY_BOX}    10s
    Wait Until Element Is Visible    ${CHAT_TEXT_MESSAGES_BOX}    10s
    Wait Until Element Is Visible    ${CHAT_INPUT_FORM}    10s
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
