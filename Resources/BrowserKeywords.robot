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

    ${TIMESTAMP}           Get Time    epoch
    ${RANDOM_STRING}       Generate Random String    8    [LETTERS]
    ${USER_PROFILE_PARENT}    Set Variable    ${CURDIR}${/}chrome_profiles
    ${USER_DATA_DIR}          Set Variable    ${USER_PROFILE_PARENT}${/}${TIMESTAMP}_${RANDOM_STRING}

    ${exists}    Evaluate    os.path.isdir(r'''${USER_PROFILE_PARENT}''')    modules=os
    Run Keyword Unless    ${exists}    Create Directory    ${USER_PROFILE_PARENT}

    Create Directory    ${USER_DATA_DIR}

    ${ALL_OPTIONS}    Set Variable    ${CHROME_BASE_ARGS_STRING} --user-data-dir=${USER_DATA_DIR}

    Open Browser    ${url}    chrome    options=${ALL_OPTIONS}    alias=${browser_alias}

    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${USER_DATA_DIR}

Close And Clean All Browsers
    Close All Browsers
    ${dir}    Get Variable Value    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
    ${exists}    Evaluate    os.path.isdir(r'''${dir}''')    modules=os
    Run Keyword If    '${dir}' != '${NONE}' and ${exists}    Remove Directory    ${dir}    recursive=True
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
