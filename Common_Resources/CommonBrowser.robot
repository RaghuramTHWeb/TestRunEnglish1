*** Settings ***
Library    SeleniumLibrary
Library    String
Library    OperatingSystem

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${profile_path}=    Set Variable    ${OUTPUT DIR}/${alias}_profile_${uuid}
    Create Directory    ${profile_path}

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

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