*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    BuiltIn

*** Variables ***
@{CHROME_BASE_ARGS}
...    --headless
...    --disable-gpu
...    --no-sandbox
...    --disable-dev-shm-usage
...    --window-size=1920,1080
...    --remote-debugging-port=9222
...    --disable-setuid-sandbox
...    --disable-features=UtilityProcessSandbox
...    --disable-background-networking
...    --disable-default-apps
...    --disable-extensions
...    --disable-sync
...    --disable-translate
...    --hide-scrollbars
...    --metrics-recording-only
...    --mute-audio
...    --no-first-run
...    --no-default-browser-check
...    --no-zygote
...    --single-process
...    --ignore-certificate-errors
...    --disable-popup-blocking
...    --disable-infobars

${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${browser_alias}=${NONE}

    ${timestamp}           Get Time    epoch
    ${random}              Generate Random String    6    [LETTERS]
    ${user_data_dir}       Set Variable    ${CURDIR}${/}chrome_profiles${/}${timestamp}_${random}

    Create Directory    ${user_data_dir}

    @{options}=    Create List
    ...    --user-data-dir=${user_data_dir}
    ...    @{CHROME_BASE_ARGS}

    Open Browser    ${url}    chrome    options=${options}    alias=${browser_alias}

    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${user_data_dir}

Close And Clean All Browsers
    Close All Browsers
    ${dir}    Get Variable Value    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
    ${exists}    Evaluate    os.path.isdir(r'''${dir}''')    modules=os
    Run Keyword If    '${dir}' != '${NONE}' and ${exists}    Remove Directory    ${dir}    recursive=True
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
