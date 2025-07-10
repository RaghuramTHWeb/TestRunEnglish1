*** Settings ***
Documentation    To validate Menu section
Library    SeleniumLibrary

*** Test Cases ***
Search__ Check redirection to provider's profile from search
    Goto login page
    Enter valid credentials and click on login
    search by Provider Name


*** Keywords ***
Goto login page
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    sleep    5s
    Wait Until Element Is Visible    id:field-:r0:
    sleep    5s

Enter valid credentials and click on login
    Input Text    id:field-:r0:    raghuram.m+rc1@taskhuman.com
    Input Text    id:field-:r1:    asdfgh@12345Q
    Wait Until Element Is Visible    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']    10s
    Click Element    xpath://div[@class='LoginForm-module__LoginFormButtons css-0']
    sleep    5s

search by Provider Name
    Go To    https://app-dev.taskhuman.com/discover
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[text()='Search topics & coaches']    timeout=10s
    Click Element    xpath=//*[text()='Search topics & coaches']
    Sleep    3s
    Wait Until Page Contains    Name
    Click Element    xpath://*[text()='Name']
    Sleep    3s
    
    Wait Until Element Is Visible    xpath=//input[@id='input-field']    timeout=10s
    Scroll Element Into View    xpath=//input[@id='input-field']
   # Click on the input field using JavaScript
    Execute JavaScript    document.querySelector("input#input-field").click();
    # Input text 'yoga' into the field
    Input Text    xpath=//input[@id='input-field']    ankush
    # Submit the form or simulate Enter key press using JavaScript
    Sleep    5s
    Click Element    xpath=//img[contains(@class, 'Search-module__search--icon')]
    #Execute JavaScript    document.querySelector("input#input-field").dispatchEvent(new KeyboardEvent('keydown', {key: 'Enter'}));
    Wait Until Page Contains       Ankush bunny
    Click Element    xpath=//div[contains(text(), 'Ankush bunny')]
    Sleep    5s
    Page Should Contain    Ankush bunny
    Sleep    5s
    

