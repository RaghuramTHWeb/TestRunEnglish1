*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections    # <-- ADD THIS LINE
Library    BuiltIn      # <-- OPTIONAL, but good for clarity/robustness for keywords like Get Test Variable

*** Variables ***
# Common Chrome options for headless mode in CI
# The --user-data-dir will be added dynamically per browser instance to avoid conflicts.
${CHROME_BASE_OPTIONS}    --headless --disable-gpu --no-sandbox --disable-dev-shm-usage --window-size=1920,1080 --remote-debugging-port=9222 --disable-setuid-sandbox --disable-features=UtilityProcessSandbox --disable-background-networking --disable-default-apps --disable-extensions --disable-sync --disable-translate --hide-scrollbars --metrics-recording-only --mute-audio --no-first-run --no-default-browser-check --no-zygote --single-process --ignore-certificate-errors --disable-popup-blocking --disable-infobars

*** Keywords ***
Open Browser With Unique Profile
    [Documentation]    Opens a Chrome browser with a unique user data directory for CI environments.
    [Arguments]    ${url}    ${browser_alias}=${NONE}

    # Generate a unique path for the user data directory
    # Combines current directory, timestamp, and a random string for robustness.
    ${TIMESTAMP}=    Get Time    epoch
    ${RANDOM_STRING}=    Generate Random String    length=8    chars=[ALPHANUMERIC]
    ${USER_DATA_DIR}=    Set Variable    ${CURDIR}${/}${OS.sep}chrome_profiles${/}${OS.sep}${TIMESTAMP}_${RANDOM_STRING}

    # Ensure the parent directory for profiles exists, then create the unique profile directory
    Create Directory    ${CURDIR}${/}${OS.sep}chrome_profiles    exist_ok=True
    Create Directory    ${USER_DATA_DIR}    exist_ok=True

    # Combine base options with the unique user data directory argument
    ${ALL_OPTIONS}=    Create List    ${CHROME_BASE_OPTIONS}
    Append To List    ${ALL_OPTIONS}    --user-data-dir=${USER_DATA_DIR}

    # Open the browser with the generated options
    Open Browser    ${url}    chrome    options=${ALL_OPTIONS}    alias=${browser_alias}

    # Store the user data directory path in a test variable for cleanup in teardown
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${USER_DATA_DIR}

Close And Clean All Browsers
    [Documentation]    Closes all open browsers and attempts to remove the last used unique user data directory.
    Close All Browsers

    # Retrieve the user data directory path stored during browser opening
    ${USER_DATA_DIR}=    Get Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}

    # If a user data directory was set, try to remove it recursively
    Run Keyword If    '${USER_DATA_DIR}' != '${NONE}' and '${USER_DATA_DIR}' != ''    Remove Directory    ${USER_DATA_DIR}    recursive=True