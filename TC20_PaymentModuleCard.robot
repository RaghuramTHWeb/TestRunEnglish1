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

Check that error message is displayed or redirected to available payment option if purchasing mins
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'MenuBar-module__Menubar--Credit__Label') and normalize-space()='Minutes']/preceding-sibling::div    10s
    Click Element    xpath=//div[contains(@class, 'MenuBar-module__Menubar--Credit__Label') and normalize-space()='Minutes']/preceding-sibling::div
    Execute JavaScript    var el = document.evaluate("//div[normalize-space(text())='$240']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; if (el) { el.scrollIntoView(); el.click(); }
    Element Should Be Disabled    xpath=//button[normalize-space()='Pay Now & Add Time']


Check consumer is able to add cards under payment methods
    Go To    https://app-dev.taskhuman.com/settings/payment-method
    Wait Until Element Is Visible    xpath=//*[text()='Add Payment Method']    10s
    Click Element    xpath=//*[text()='Add Payment Method']
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[text()='Payment Methods']    10s
    Click Element    xpath=//*[text()='Payment Methods']
    Sleep    3s

    # Input Card Number
    Wait Until Element Is Visible    css=iframe[src*='stripe']    10s
    Select Frame    css=iframe[src*='stripe']
    Wait Until Element Is Visible    css=input[placeholder='Card Number']    15s
    Click Element    css=input[placeholder='Card Number']
    Input Text    css=input[placeholder='Card Number']    4242424242424242
    Unselect Frame
    Sleep    2s
 # Click the element at coordinates
    Execute JavaScript    document.elementFromPoint(352, 387).click()
    Sleep    2s
    Press Keys    none    1
    Press Keys    none    2
    Press Keys    none    2
    Press Keys    none    8
    Sleep    5s
    Execute JavaScript    document.elementFromPoint(354, 435).click()
    Sleep    2s
    Press Keys    none    1
    Press Keys    none    2
    Press Keys    none    3
    Sleep    5s


validate if on adding card it can be made default
   # Wait Until Element Is Visible    xpath=//span[@class='chakra-checkbox__control css-1ydjfm6']    5s
   # Click Element    xpath=//span[@class='chakra-checkbox__control css-1ydjfm6']
    #Sleep    3s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'PaymentCard-module__Deault--CheckBox')]//span[contains(@class, 'chakra-checkbox__control')]    10S
    Click Element    xpath=//div[contains(@class, 'PaymentCard-module__Deault--CheckBox')]//span[contains(@class, 'chakra-checkbox__control')]
    Wait Until Element Is Visible    xpath=//*[text()='Save']    10s
    Click Element    xpath=//*[text()='Save']
    Sleep    3s
    #can verify redirected URL if need

Validate if added card can be deleted
    Wait Until Element Is Visible    xpath://p[@class='chakra-text SettingComponents-module__Card--Number css-0']    10s
    Click Element    xpath://p[@class='chakra-text SettingComponents-module__Card--Number css-0']
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[text()='Delete']    10s
    Click Element    xpath=//*[text()='Delete']
    Sleep    5s

Validate if deleted card is not visible
    Element Should Not Be Visible    xpath://p[@class='chakra-text SettingComponents-module__Card--Number css-0']    10s
    Sleep    3s
Goto Settings and logout as consumer
    Go To    https://app-dev.taskhuman.com/settings
     Wait Until Page Contains Element    xpath=//div[@data-testid="logout_btn"]    10s
    Click Element                       xpath=//div[@data-testid="logout_btn"]
    Sleep    3s
    Wait Until Page Contains Element    xpath=//div[@data-testid='confirm_btn']    10s
    Click Element                       xpath=//div[@data-testid='confirm_btn']
    Close Browser
