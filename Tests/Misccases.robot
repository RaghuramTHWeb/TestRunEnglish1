*** Settings ***
Library    SeleniumLibrary
Documentation    MiscCases validation
#coachview and consumer view, search by provider name and topic, discover tile

*** Test Cases ***
Validate if user can switch to coach view and user view
    Login as provider
    validate Switch to coach view
    Switch To User View and validate if switched correctly
Validate tile in discovery section
    Check if tile is visible in discovery section by switching to user view
To check if results are populated though search by topic and by provider name
    search by yoga
    search by name
Validate Concierge redireciton in all sections
    Validate Concierge icon redirection on all sections


*** Keywords ***
Login as provider
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    5s
    sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    sleep    5s
    Wait Until Element Is Visible    id:field-:r0:
    sleep    5s
    Input Text    id:field-:r0:    raghuram.m+rp1@taskhuman.com
    Input Text    id:field-:r1:    asdfgh@12345A
    Click Element    xpath://button[@value='submit']
    Sleep    3s
validate Switch to coach view
    #Wait Until Element Is Visible    css:button[class='chakra-button TopBar-module__Topbar--Switch__Button css-i857na']
    #Click Element    css:button[class='chakra-button TopBar-module__Topbar--Switch__Button css-i857na']
    Wait Until Element Is Visible  xpath=//*[text()='Switch to Coach View']
    Click Element  xpath=//*[text()='Switch to Coach View']
Switch To User View and validate if switched correctly
    Sleep    3s
    Wait Until Element Is Visible  xpath=//*[text()='Switch to User View']
    Click Element  xpath=//*[text()='Switch to User View']
#Validate if switched correctly and discovery section is visible
    Sleep    3s
    Wait Until Element Is Visible    css=a.MenuBar-module__NavItem.MenuBar-module__active div.MenuBar-module__NavItem--link__lable.css-0
    Click Element   css=a.MenuBar-module__NavItem.MenuBar-module__active div.MenuBar-module__NavItem--link__lable.css-0
    Sleep    6s
    Reload Page
    Wait Until Page Contains    Section 1
    Sleep    3s
Check if tile is visible in discovery section by switching to user view
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'DiscoverProgram-module__Program--Card__Flex')]  5s
    Sleep    3s
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
Validate Concierge icon redirection on all sections
    #update from newly created file of concere
    Sleep    5s