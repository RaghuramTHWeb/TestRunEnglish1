*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Login with Google Account
    Open Browser    https://app-dev.taskhuman.com/login    Chrome
    Maximize Browser Window
    Sleep    3s
    Click Element    xpath://div[@id='googleOauthButton']
    Switch Window    locator=NEW
    Sleep    3s
    Input Text    xpath=//input[@id='identifierId']    raghuram.m@taskhuman.com
    Click Element    xpath://span[text()='Next']
    Sleep    2s
    Input Text    xpath=//input[@name='Passwd']    qwertyuiop@123Q
    Click Element    xpath://span[text()='Next']
    # Handle 2-step verification manually
    Sleep    30s
    ${handles} =    Get Window Handles
    Close Window    ${handles}[1]    # Close the Google login window
    Switch Window    ${handles}[0]    # Switch back to the original window
    Wait Until Page Contains    Human Guidance At Your Fingertips    timeout=30s
