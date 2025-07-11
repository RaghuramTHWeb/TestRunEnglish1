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
    [Documentation]    Opens Chrome with a unique user profile to avoid conflicts in CI.
    [Arguments]    ${url}    ${browser_alias}=${NONE}

    ${timestamp}=    Get Time    epoch
    ${random}=       Generate Random String    8    [LETTERS]
    ${profile_root}=    Set Variable    /tmp/chrome_profiles
    ${user_data_dir}=    Set Variable    ${profile_root}/${timestamp}_${random}

    Run Keyword Unless    Directory Exists    ${profile_root}    Create Directory    ${profile_root}
    Create Directory    ${user_data_dir}

    ${args}=    Split String    ${CHROME_BASE_ARGS_STRING}
    Append To List    ${args}    --user-data-dir=${user_data_dir}

    ${chrome_opts}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    FOR    ${arg}    IN    @{args}
        Call Method    ${chrome_opts}    add_argument    ${arg}
    END

    Open Browser    ${url}    browser=chrome    options=${chrome_opts}    alias=${browser_alias}
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${user_data_dir}

Close And Clean All Browsers
    [Documentation]    Closes all browsers and removes temp profile.
    Close All Browsers

    ${user_data_dir}=    Get Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
    Run Keyword If    '${user_data_dir}' != '${NONE}' and Directory Exists    ${user_data_dir}    Remove Directory    ${user_data_dir}    recursive=True
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
