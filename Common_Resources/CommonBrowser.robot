*** Settings ***
Library    SeleniumLibrary
Library    String
Library    OperatingSystem
Library    Collections

*** Keywords ***

Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${profile_dir}=    Set Variable    /tmp/${alias}_profile_${uuid}
    Create Directory    ${profile_dir}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --user-data-dir=${profile_dir}
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-blink-features
    Call Method    ${options}    add_argument    --disable-blink-features=AutomationControlled
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-extensions
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}
    Set Window Size    1920    1080

Open Incognito Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${profile_dir}=    Set Variable    /tmp/${alias}_profile_${uuid}
    Create Directory    ${profile_dir}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --user-data-dir=${profile_dir}
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-blink-features
    Call Method    ${options}    add_argument    --disable-blink-features=AutomationControlled
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-extensions
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}
    Set Window Size    1920    1080