*** Settings ***
Library    SeleniumLibrary
Library    String
Library    OperatingSystem

*** Keywords ***

Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${is_ci}=    Get Environment Variable    GITHUB_ACTIONS
    Run Keyword If    '${is_ci}' == 'true'
    ...    Open Browser In CI Mode    ${url}    ${alias}
    ...    ELSE
    ...    Open Browser Locally With Unique Profile    ${url}    ${alias}

Open Incognito Browser With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${is_ci}=    Get Environment Variable    GITHUB_ACTIONS
    Run Keyword If    '${is_ci}' == 'true'
    ...    Open Browser In CI Mode    ${url}    ${alias}    --incognito
    ...    ELSE
    ...    Open Incognito Browser Locally With Unique Profile    ${url}    ${alias}

Open Browser In CI Mode
    [Arguments]    ${url}    ${alias}    @{extra_args}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    '--headless=new'
    Call Method    ${options}    add_argument    '--no-sandbox'
    Call Method    ${options}    add_argument    '--disable-dev-shm-usage'
    FOR    ${arg}    IN    @{extra_args}
        Call Method    ${options}    add_argument    '${arg}'
    END
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}

Open Browser Locally With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${arg1}=    Set Variable    --user-data-dir=C:/temp/profile_${uuid}
    Call Method    ${options}    add_argument    '${arg1}'
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}

Open Incognito Browser Locally With Unique Profile
    [Arguments]    ${url}    ${alias}
    ${uuid}=    Generate Random String    8
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${arg1}=    Set Variable    --user-data-dir=C:/temp/incog_${uuid}
    ${arg2}=    Set Variable    --incognito
    Call Method    ${options}    add_argument    '${arg1}'
    Call Method    ${options}    add_argument    '${arg2}'
    Create WebDriver    Chrome    options=${options}    alias=${alias}
    Go To    ${url}
