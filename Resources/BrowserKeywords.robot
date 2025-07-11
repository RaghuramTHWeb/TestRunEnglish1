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

    ${timestamp}=    Get Time    epoch
    ${random}=       Generate Random String    5    [LETTERS]
    ${user_data_dir}=    Set Variable    /tmp/chrome_profiles/${timestamp}_${random}
    Create Directory    ${user_data_dir}

    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    FOR    ${arg}    IN
    ...    --disable-gpu
    ...    --no-sandbox
    ...    --disable-dev-shm-usage
    ...    --window-size=1280,800
    ...    --disable-extensions
    ...    --disable-popup-blocking
    ...    --disable-infobars
    ...    --user-data-dir=${user_data_dir}
        Call Method    ${chrome_options}    add_argument    ${arg}
    END

    Open Browser    ${url}    browser=chrome    options=${chrome_options}    alias=${browser_alias}
