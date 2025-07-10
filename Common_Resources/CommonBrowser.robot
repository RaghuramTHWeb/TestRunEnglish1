*** Settings ***
Library    SeleniumLibrary
Library    String

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${profile_path}=    Set Variable    C:/temp/profile_${uuid}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    "--user-data-dir=${profile_path}"
    Call Method    ${options}    add_argument    "--no-sandbox"
    Call Method    ${options}    add_argument    "--disable-dev-shm-usage"
    Call Method    ${options}    add_argument    "--headless=new"
    Call Method    ${options}    add_argument    "--window-size=1920,1080"
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}

Open Incognito Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${profile_path}=    Set Variable    C:/temp/incog_${uuid}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    "--user-data-dir=${profile_path}"
    Call Method    ${options}    add_argument    "--incognito"
    Call Method    ${options}    add_argument    "--no-sandbox"
    Call Method    ${options}    add_argument    "--disable-dev-shm-usage"
    Call Method    ${options}    add_argument    "--headless=new"
    Call Method    ${options}    add_argument    "--window-size=1920,1080"
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}
