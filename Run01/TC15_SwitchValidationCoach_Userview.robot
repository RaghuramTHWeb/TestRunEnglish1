*** Settings ***
Library    SeleniumLibrary
Documentation    MiscCases validation

*** Test Cases ***
Validate if user can switch to coach view and user view
    Login as provider
    validate Switch to coach view
    Switch To User View and validate if switched correctly
Validate tile in discovery section
    Check if tile is visible in discovery section by switching to user view

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
    Input Text    id:field-:r0:    raghuram.m+s01@taskhuman.com
    Input Text    id:field-:r1:    asdfgh@12345A
    Click Element    xpath://button[@value='submit']
    Sleep    3s
validate Switch to coach view
    #Wait Until Element Is Visible    css:button[class='chakra-button TopBar-module__Topbar--Switch__Button css-i857na']
    #Click Element    css:button[class='chakra-button TopBar-module__Topbar--Switch__Button css-i857na']
    Wait Until Element Is Visible  xpath=//*[text()='Switch to Coach View']    3s
    Click Element  xpath=//*[text()='Switch to Coach View']
Switch To User View and validate if switched correctly
    Sleep    3s
    Reload Page
    Wait Until Element Is Visible  xpath=//*[text()='Switch to User View']    3s
    Click Element  xpath=//*[text()='Switch to User View']
#Validate if switched correctly and discovery section is visible
    Sleep    3s
    Wait Until Element Is Visible    css=a.MenuBar-module__NavItem.MenuBar-module__active div.MenuBar-module__NavItem--link__lable.css-0    3s
    Click Element   css=a.MenuBar-module__NavItem.MenuBar-module__active div.MenuBar-module__NavItem--link__lable.css-0
    Sleep    6s
    Reload Page
   # Wait Until Page Contains    Section 1
    #Sleep    3s

Check if tile is visible in discovery section by switching to user view
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'DiscoverProgram-module__Program--Card__Flex')]  5s
    Sleep    3s
    Close Browser