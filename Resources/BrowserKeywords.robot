*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    BuiltIn

*** Variables ***
${CHROME_BASE_ARGS_STRING}    --headless --disable-gpu --no-sandbox --disable-dev-shm-usage --window-size=1920,1080 --remote-debugging-port=9222 --disable-setuid-sandbox --disable-features=UtilityProcessSandbox --disable-background-networking --disable-default-apps --disable-extensions --disable-sync --disable-translate --hide-scrollbars --metrics-recording-only --mute-audio --no-first-run --no-default-browser-check --no-zygote --single-process --ignore-certificate-errors --disable-popup-blocking --disable-infobars
${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${browser_alias}=${NONE}

    ${timestamp}=    Get Time    epoch
    ${random}=       Generate Random String    8    [LETTERS]
    ${USER_PROFILE_PARENT_DIR}=    Set Variable    /tmp/chrome_profiles
    ${USER_DATA_DIR}=    Set Variable    ${USER_PROFILE_PARENT_DIR}/${timestamp}_${random}

    ${exists}=    Evaluate    os.path.isdir("${USER_PROFILE_PARENT_DIR}")    os
    Run Keyword If    not ${exists}    Create Directory    ${USER_PROFILE_PARENT_DIR}
    Create Directory    ${USER_DATA_DIR}

    ${args}=    Split String    ${CHROME_BASE_ARGS_STRING}
    Append To List    ${args}    --user-data-dir=${USER_DATA_DIR}

    ${chrome_opts}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    FOR    ${arg}    IN    @{args}
        Call Method    ${chrome_opts}    add_argument    ${arg}
    END

    Open Browser    ${url}    chrome    options=${chrome_opts}    alias=${browser_alias}
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${USER_DATA_DIR}


Close And Clean All Browsers
    Close All Browsers

    ${user_data_dir}=    BuiltIn.Get Variable Value    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
    Run Keyword If    '${user_data_dir}' != '${NONE}' and Directory Exists    ${user_data_dir}    Remove Directory    ${user_data_dir}    recursive=True
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
