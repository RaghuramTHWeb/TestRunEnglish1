*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/Reboot_Consumer_login.robot


*** Test Cases ***
Login as consumer
    Login As Consumer    ${consumer_email}    ${consumer_password}
Messages__ Validate that user can scroll to bottom
    Messages__ Validate that user can scroll to bottom
Messages__ Validate that recent messages are listed on top
    Validate that recent messages are listed on top
Messages__ Validate user can send message to provider
    Validate user can send message to provider

Message__ Validate Content in message card(Name, Image, recent message)
    Validate Content in message card(Name, Image, recent message)

Concierge_ Validate user is able to navigate to concierge section    
    Validate user is able to navigate to concierge section
Concierge_ Validate content visible in Concierge(Date of messages, chat box)
    Validate content visible in Concierge(Date of messages, chat box)
close browser
    Close Browser

*** Keywords ***
Messages__ Validate that user can scroll to bottom
    Wait Until Element Is Visible    xpath=//a[@href='/chats']    10s
    Click Element    xpath=//a[@href='/chats']
    Location Should Be    https://app-dev.taskhuman.com/chats    10s
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'index-module__NotificationCard')])[last()]    10s
    Click Element    xpath=(//div[contains(@class, 'index-module__NotificationCard')])[last()]

Validate that recent messages are listed on top
    Go To    https://app-dev.taskhuman.com/profile/2731
    Reload Page
    Wait Until Element Is Visible    css=img[src='/60be4485a05d399292d8.svg']    10s
    Click Element    css=img[src='/60be4485a05d399292d8.svg']
    Wait Until Element Is Visible    css=div.MessageModal-module__Phrases--Box.css-0 > span:first-child    10s
    Click Element    css=div.MessageModal-module__Phrases--Box.css-0 > span:first-child
    Wait Until Element Is Visible    css=button.MessageModal-module__NextButton.MessageModal-module__ActiveButton    10s
    Click Element    css=button.MessageModal-module__NextButton.MessageModal-module__ActiveButton
Validate user can send message to provider
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'chakra-input')]    10s
    Input Text    xpath=//input[contains(@class, 'chakra-input')]    Hello,This is test Message Please ignore
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'InputField-module__Send--Button')]    10s
    Click Element   xpath=//button[contains(@class, 'InputField-module__Send--Button')]
    Wait Until Element Is Visible    xpath=//a[@href='/chats']    10s
    Click Element    xpath=//a[@href='/chats']
    Wait Until Element Is Visible    xpath=//div[text()='Today']    10s

Validate Content in message card(Name, Image, recent message)
    Wait Until Element Is Visible    xpath=//img[@src='https://images-dev.taskhuman.com/profileImages/2731_1708333402071.jpg']    10s
    Wait Until Element Is Visible    xpath=//p[contains(@class, 'index-module__Actor--Name')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'index-module__Notification--Text')]    10s
    
Validate user is able to navigate to concierge section    
    Wait Until Element Is Visible    xpath://div[normalize-space()='Concierge']    10s
    Click Element    xpath://div[normalize-space()='Concierge']
Validate content visible in Concierge(Date of messages, chat box)
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Message-module__Message__Date--Tag')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ChatsText-module__Chats--Text--Box')]    10s
Validate user can send message in Concierge
    Wait Until Element Is Visible    xpath=//input[contains(@class, 'chakra-input')]    10s
    Input Text    xpath=//input[contains(@class, 'chakra-input')]    Hello,This is test Message Please ignore
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button InputField-module__Send--Button InputField-module__Active--Button css-i857na']    10s
    Click Element    xpath=//button[@class='chakra-button InputField-module__Send--Button InputField-module__Active--Button css-i857na']
