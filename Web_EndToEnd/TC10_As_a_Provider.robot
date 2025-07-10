*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/Reboot_Consumer_login.robot
*** Variables ***
${ONLINE_TEXT}   You're now online!
${OFFLINE_TEXT}  You're offline now!

*** Test Cases ***
Login as consumer
        Login as Provider    ${PROVIDER_EMAIL}    ${PROVIDER_PASSWORD}
        
As a Provider__validate provider landing page
    validate provider landing page

As a Provider__Check provider is able to add availability tapping + icon and "go Online Button"
    ${online_status_present}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    2s
    ${offline_status_present}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    2s

    # Execute the appropriate handler based on the page status
    Run Keyword If    ${online_status_present}    Handle Online Status
    Run Keyword If    ${offline_status_present}    Handle Offline Status
As a Provider__ Validate menu section of the provider: Timer in decreasing order
    Validate menu section of the provider: Timer in decreasing order
Validate Menu Items
    Validate Menu Items
Validate provider history functionality
    Validate provider history functionality
validate provider chat through history
    validate provider chat through history

Validate message module of provider
    Validate message module of provider

Validate settings page of provider
    Validate settings page of provider

validate concierge section
    validate concierge section
    
    
*** Keywords ***
validate provider landing page
    Location Should Be    https://app-dev.taskhuman.com/provider/availability


Handle Online Status
    Wait Until Element Is Visible    xpath=//div[@class='AvailabilityCard-module__AvailabilityCard--Online__ButtonGroup css-0']//div[2]//img[1]    10s
    Click Element    //div[@class='AvailabilityCard-module__AvailabilityCard--Online__ButtonGroup css-0']//div[2]//img[1]
    Wait Until Element Is Visible    xpath=//button[@class='chakra-button DeleteForm-module__deleteButton css-s88bex' and text()='Delete']    10s
    Click Element    xpath=//button[@class='chakra-button DeleteForm-module__deleteButton css-s88bex' and text()='Delete']
    Wait Until Page Contains Element    xpath=//*[text()="${OFFLINE_TEXT}"]    10s
    Wait Until Element Is Visible    xpath=//button[@id='add_availability_icon']    10s
    Click Element    xpath=//button[@id='add_availability_icon']
    Wait Until Page Contains Element    xpath=//*[text()='Save']    10s
    Click Element    xpath=//*[text()='Save']

Handle Offline Status
    Wait Until Element Is Visible    xpath=//button[@id='add_availability_icon']    10s
    Click Element    xpath=//button[@id='add_availability_icon']
    Wait Until Page Contains Element    xpath=//*[text()='Save']    10s
    Click Element    xpath=//*[text()='Save']
    Wait Until Page Contains Element    xpath=//*[text()="${ONLINE_TEXT}"]    10s

Validate menu section of the provider: Timer in decreasing order
    Wait Until Element Is Visible    xpath=//p[@class='MenuBar-module__Menubar--Availability__Timer']    10s
    ${initial_timer}=    Get Text    xpath=//p[@class='MenuBar-module__Menubar--Availability__Timer']
    Sleep    3s
    ${subsequent_timer}=    Get Text    xpath=//p[@class='MenuBar-module__Menubar--Availability__Timer']
    Should Not Be Equal    ${initial_timer}    ${subsequent_timer}
    

Validate Menu Items
    # Wait for Menu Bar container to be visible
    Wait Until Element Is Visible    xpath=//div[@id='menu-bar']    10s

    # Wait for Availability Nav Item
    Wait Until Element Is Visible    xpath=//a[@href='/provider/availability']    10s
    Wait Until Element Is Visible    xpath=//a[@href='/provider/availability']//div[contains(@class, 'MenuBar-module__NavItem--link__lable')]    10s

    # Wait for History Nav Item
    Wait Until Element Is Visible    xpath=//a[@href='/provider/history']    10s
    Wait Until Element Is Visible    xpath=//a[@href='/provider/history']//div[contains(@class, 'MenuBar-module__NavItem--link__lable')]    10s

    # Wait for Messages Nav Item
    Wait Until Element Is Visible    xpath=//a[@href='/provider/messages']    10s
    Wait Until Element Is Visible    xpath=//a[@href='/provider/messages']//div[contains(@class, 'MenuBar-module__NavItem--link__lable')]    10s

    # Wait for Settings Nav Item
    Wait Until Element Is Visible    xpath=//a[@href='/provider/settings']    10s
    Wait Until Element Is Visible    xpath=//a[@href='/provider/settings']//div[contains(@class, 'MenuBar-module__NavItem--link__lable')]    10s

    # Wait for Concierge Nav Item
    Wait Until Element Is Visible    xpath=//a[@href='/provider/concierge']    10s
    Wait Until Element Is Visible    xpath=//a[@href='/provider/concierge']//div[contains(@class, 'MenuBar-module__NavItem--link__lable')]    10s

Validate provider history functionality
    Click Element    xpath=//a[@href='/provider/history']
    #Wait Until Element Is Visible    xpath=//p[@class='chakra-text HistoryRoute-module__Time--Label--Text css-0']    10s
validate provider chat through history
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'HistoryRoute-module__HistoryDetails--Card')])[1]    10s
    Click Element    xpath=(//div[contains(@class, 'HistoryRoute-module__HistoryDetails--Card')])[1]
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'BackButton-module__BackButton')]    10s
    Click Element    xpath=//div[contains(@class, 'BackButton-module__BackButton')]
Validate message module of provider
    Wait Until Element Is Visible    xpath=//a[@href='/provider/messages']    10s
    Click Element    xpath=//a[@href='/provider/messages']
Validate settings page of provider
    Click Element    xpath=//a[@href='/provider/settings']

validate concierge section
    Wait Until Element Is Visible    xpath=//a[@href='/provider/concierge']    10s
    Click Element    xpath=//a[@href='/provider/concierge']
    Close Browser

    
    
