*** Settings ***
Library    SeleniumLibrary
#book_reschedule_DElete booking case
*** Variables ***
${email}    raghuram.m+rc1@taskhuman.com
${Password}    asdfgh@12345Q

*** Test Cases ***
Open the browser and login as consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Sleep    5s
    Wait Until Element Is Visible    id:field-:r0:    10s
    Sleep    5s
    Input Text    id:field-:r0:    ${email}
    Input Text    id:field-:r1:    ${Password}
    Click Element    xpath://button[@value='submit']
    Sleep    5s
search by yoga
    Go To    https://app-dev.taskhuman.com/discover
    Sleep    3s
    Wait Until Element Is Visible    xpath=//*[text()='Search topics & coaches']    timeout=10s
    Click Element    xpath=//*[text()='Search topics & coaches']
    Sleep    3s
    # Reload the page to ensure clean state
    Reload Page
    # Wait for the input field to be visible and interactable
    Wait Until Element Is Visible    xpath=//input[@id='input-field']    timeout=10s
    Scroll Element Into View    xpath=//input[@id='input-field']
   # Click on the input field using JavaScript
    Execute JavaScript    document.querySelector("input#input-field").click();
    # Input text 'yoga' into the field
    Input Text    xpath=//input[@id='input-field']    yoga
    # Submit the form or simulate Enter key press using JavaScript
    Execute JavaScript    document.querySelector("input#input-field").dispatchEvent(new KeyboardEvent('keydown', {key: 'Enter'}));
    Go To    https://app-dev.taskhuman.com/search/topic/yoga
    # Wait for results to load
    Sleep    5s
search by name     #Need search icon element name after giving input
    Go To    https://app-dev.taskhuman.com/search/name
    # Wait for the input field to be visible and interactable
    Wait Until Element Is Visible    xpath=//input[@id='input-field']    timeout=10s
    Scroll Element Into View    xpath=//input[@id='input-field']
   # Click on the input field using JavaScript
    Execute JavaScript    document.querySelector("input#input-field").click();
    # Input text 'Raghu' into the field
    Input Text    xpath=//input[@id='input-field']    Raghu
    Execute JavaScript    document.querySelector("input#input-field").dispatchEvent(new KeyboardEvent('keydown', {key: 'Enter'}));
    Sleep    5s
    Close Browser