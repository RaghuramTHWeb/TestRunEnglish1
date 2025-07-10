*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/Reboot_Consumer_login.robot

*** Variables ***
${CARD_CONTAINER}    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[4]

*** Test Cases ***
Search Module_ Validate discount code section in settings (with and without discount code)
    Login As Consumer    ${consumer_email}    ${consumer_password}
Library_Module Validate content and UI in library page
    Library_Module Validate content and UI in library page
Library_Module validate blogs visibility and if user can access blog
    Library_Module validate blogs visibility and if user can access blog
Library_module Validate back button in blog details
    Library_module Validate back button in blog details
Validate Container UI(Title, Time, providers featuring, description)
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[4]    10s
    Validate Card Title
    Validate Card Time
    Validate Card Featuring
    Validate Card Description
Validate user is redirected to provider profile from blog
    Validate user is redirected to provider profile from blog
    Close Browser

    
*** Keywords ***
Library_Module Validate content and UI in library page
    Wait Until Element Is Visible    xpath=//div[text()='Library']    10s
    Click Element    xpath=//div[text()='Library']
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Library-module__Library--Header__timezone')]    10s
Library_Module validate blogs visibility and if user can access blog
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Library-module__Library--Container__Card')]    10s
    Click Element    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[1]
Library_module Validate back button in blog details
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'BackButton-module__BackButton')]    10s
    Click Element    xpath=//div[contains(@class, 'BackButton-module__BackButton')]
Validate Card Title
    ${title}=    Get Text    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[4]//div[contains(@class, 'Library-module__Card--Title__Text')]
    Should Not Be Empty    ${title}
    Log    Card title is valid: ${title}

Validate Card Time
    ${time}=    Get Text    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[4]//div[contains(@class, 'Library-module__Card--Time__Text')]
    Should Not Be Empty    ${time}
    Log    Card time is valid: ${time}

Validate Card Featuring
    ${featuring}=    Get WebElements    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[4]//div[contains(@class, 'Library-module__Card--Avatar__Label')]
    Should Not Be Empty    ${featuring}    message=No featuring avatars found
    FOR    ${avatar}    IN    @{featuring}
        ${name}=    Get Text    ${avatar}
        Should Not Be Empty    ${name}
        Log    Featuring avatar: ${name}
    END

Validate Card Description
    ${description}=    Get Text    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[4]//div[contains(@class, 'Library-module__Library--Card__Desc')]
    Should Not Be Empty    ${description}
    Log    Card description is valid: ${description}
    
Validate user is redirected to provider profile from blog
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[4]//div[contains(@class, 'Library-module__Card--Avatar__Container')][1]    10s
    Click Element    xpath=(//div[contains(@class, 'Library-module__Library--Container__Card')])[4]//div[contains(@class, 'Library-module__Card--Avatar__Container')][1]
    Wait Until Element Is Visible    xpath=//div[@class='Profile-module__ProviderProfile--UserInfo css-0']    10s
    Click Element    xpath=//div[@class='Profile-module__ProviderProfile--BackBtn__container css-0']