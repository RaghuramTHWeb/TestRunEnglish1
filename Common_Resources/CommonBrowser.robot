*** Settings ***
Library    SeleniumLibrary
Library    String

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${arg1}=    Set Variable    --user-data-dir=C:/temp/profile_${uuid}
    Call Method    ${options}    add_argument    ${arg1}
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}

Open Incognito Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${arg1}=    Set Variable    --user-data-dir=C:/temp/incog_${uuid}
    ${arg2}=    Set Variable    --incognito
    Call Method    ${options}    add_argument    ${arg1}
    Call Method    ${options}    add_argument    ${arg2}
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}
