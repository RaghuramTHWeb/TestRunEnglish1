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

    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${PROFILE_ROOT_DIR}
    IF    not ${exists}
        Create Directory    ${PROFILE_ROOT_DIR}
    END
    Create Directory    ${profile_dir}

    ${args}=    Create List
    FOR    ${arg}    IN    @{CHROME_BASE_ARGS}
        Append To List    ${args}    ${arg}
    END

    IF    '${alias}' == 'INC'
        Append To List    ${args}    --incognito
    END
    Append To List    ${args}    --user-data-dir=${profile_dir}

    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    ${headless}=    Get Environment Variable    ROBOT_HEADLESS    default=None
    IF    '${headless}' != 'None'
        Call Method    ${chrome options}    add_argument    ${headless}
    END

    FOR    ${arg}    IN    @{args}
        Call Method    ${chrome options}    add_argument    ${arg}
    END

    Open Browser    url=${url}    browser=chrome    options=${chrome options}    alias=${alias}
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${profile_dir}


Close And Clean All Browsers
    Close All Browsers
    ${profile}=    Set Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${profile}
    IF    '${profile}' != 'NONE' and ${exists}
        Remove Directory    ${profile}    recursive=True
    END
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    NONE
