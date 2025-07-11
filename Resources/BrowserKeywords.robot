*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    BuiltIn
Library    Collections

*** Variables ***
@{CHROME_BASE_ARGS}
...    --disable-popup-blocking
...    --disable-extensions
...    --disable-gpu
...    --no-sandbox
...    --window-size=1920,1080
...    --remote-debugging-port=0
...    --disable-dev-shm-usage
...    --single-process
...    --disable-background-networking

${PROFILE_ROOT_DIR}    /tmp/chrome_profiles
${_CURRENT_BROWSER_USER_DATA_DIR}    NONE

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}

    ${uuid}=    Evaluate    __import__('uuid').uuid4().hex
    ${profile_dir}=    Set Variable    ${PROFILE_ROOT_DIR}/${alias}_${uuid}

    Run Keyword Unless    Directory Should Exist    ${PROFILE_ROOT_DIR}    Create Directory    ${PROFILE_ROOT_DIR}
    Create Directory    ${profile_dir}

    ${args}=    Create List
    FOR    ${arg}    IN    @{CHROME_BASE_ARGS}
        Append To List    ${args}    ${arg}
    Run Keyword If    '${alias}' == 'INC'    Append To List    ${args}    --incognito
    Append To List    ${args}    --user-data-dir=${profile_dir}

    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    # ✅ Use ROBOT_HEADLESS if defined (in CI), to avoid headless issues locally
    ${headless}=    Get Environment Variable    ROBOT_HEADLESS    default=None
    Run Keyword If    '${headless}' != 'None'    Call Method    ${chrome options}    add_argument    ${headless}

    FOR    ${arg}    IN    @{args}
        Call Method    ${chrome options}    add_argument    ${arg}

    Open Browser    url=${url}    browser=chrome    options=${chrome options}    alias=${alias}
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${profile_dir}

Close And Clean All Browsers
    Close All Browsers
    ${profile}=    Set Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${profile}
    Run Keyword If    '${profile}' != 'NONE' and ${exists}    Remove Directory    ${profile}    recursive=True
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    NONE
