*** Settings ***
Library    SeleniumLibrary
Library    String

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${profile_path}=    Set Variable    /tmp/${alias}_profile_${uuid}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    # Pass Chrome arguments as single strings
    ${arg1}=    Set Variable    --user-data-dir=${profile_path}
    ${arg2}=    Set Variable    --no-sandbox
    ${arg3}=    Set Variable    --disable-dev-shm-usage
    ${arg4}=    Set Variable    --disable-blink-features=AutomationControlled

    Call Method    ${options}    add_argument    ${arg1}
    Call Method    ${options}    add_argument    ${arg2}
    Call Method    ${options}    add_argument    ${arg3}
    Call Method    ${options}    add_argument    ${arg4}

    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}

Open Incognito Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${profile_path}=    Set Variable    /tmp/${alias}_profile_${uuid}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    ${arg1}=    Set Variable    --incognito
    ${arg2}=    Set Variable    --user-data-dir=${profile_path}
    ${arg3}=    Set Variable    --no-sandbox
    ${arg4}=    Set Variable    --disable-dev-shm-usage
    ${arg5}=    Set Variable    --disable-blink-features=AutomationControlled

    Call Method    ${options}    add_argument    ${arg1}
    Call Method    ${options}    add_argument    ${arg2}
    Call Method    ${options}    add_argument    ${arg3}
    Call Method    ${options}    add_argument    ${arg4}
    Call Method    ${options}    add_argument    ${arg5}

    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}
