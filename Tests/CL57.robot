*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q

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
    Wait Until Element Is Visible    xpath=//span[@class='chakra-checkbox__control css-1ydjfm6']    5s
    Click Element    xpath=//span[@class='chakra-checkbox__control css-1ydjfm6']
    Sleep    3s
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
