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
...    --remote-debugging-port=0    # ✅ Add this line
...    --disable-dev-shm-usage    # ✅ This line solves container-level shared memory conflicts

${PROFILE_ROOT_DIR}    /tmp/chrome_profiles
${_CURRENT_BROWSER_USER_DATA_DIR}    NONE

*** Keywords ***

Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}

    ${uuid}=    Evaluate    __import__('uuid').uuid4().hex
    ${profile_dir}=    Set Variable    ${PROFILE_ROOT_DIR}/${alias}_${uuid}

    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${PROFILE_ROOT_DIR}
    Run Keyword Unless    ${exists}    Create Directory    ${PROFILE_ROOT_DIR}
    Create Directory    ${profile_dir}

    ${args}=    Create List
    FOR    ${arg}    IN    @{CHROME_BASE_ARGS}
        Append To List    ${args}    ${arg}
    END
    Run Keyword If    '${alias}' == 'INC'    Append To List    ${args}    --incognito
    Append To List    ${args}    --user-data-dir=${profile_dir}

    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    FOR    ${arg}    IN    @{args}
        Call Method    ${chrome options}    add_argument    ${arg}
    END

    # ✅ Fixed: Use all named arguments to avoid mixing positional + named
    Open Browser    url=${url}    browser=chrome    options=${chrome options}    alias=${alias}
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${profile_dir}


Join Chrome Args
    [Arguments]    @{args}
    ${joined}=    Set Variable    ${EMPTY}
    FOR    ${item}    IN    @{args}
        ${joined}=    Set Variable    ${joined} ${item}
    END
    RETURN    ${joined}    # ✅ Fixed deprecated [Return]

Close And Clean All Browsers
    Close All Browsers
    ${profile}=    Set Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${profile}
    Run Keyword If    '${profile}' != 'NONE' and ${exists}    Remove Directory    ${profile}    recursive=True
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    NONE
