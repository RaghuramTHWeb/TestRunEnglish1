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
...    --window-size=1280,800
...    --remote-debugging-port=9222
...    --disable-setuid-sandbox
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

    ${timestamp}=     Get Time    epoch
    ${random}=        Generate Random String    5    [LETTERS]
    ${user_data_dir}=    Set Variable    ${CURDIR}${/}chrome_profiles${/}${timestamp}_${random}

    Create Directory    ${user_data_dir}

    ${chrome_args}=    Create List
    FOR    ${arg}    IN    @{CHROME_BASE_ARGS}
        Append To List    ${chrome_args}    ${arg}
    END
    Append To List    ${chrome_args}    --user-data-dir=${user_data_dir}

    ${chrome_options}=    Create Dictionary    args=${chrome_args}
    ${capabilities}=    Create Dictionary    goog:chromeOptions=${chrome_options}

    Open Browser    ${url}    chrome    desired_capabilities=${capabilities}    alias=${browser_alias}
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${user_data_dir}
