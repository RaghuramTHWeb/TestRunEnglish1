*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    BuiltIn

*** Variables ***
# Common Chrome options for headless mode in CI
# The --user-data-dir will be added dynamically per browser instance to avoid conflicts.
${CHROME_BASE_OPTIONS}    --headless --disable-gpu --no-sandbox --disable-dev-shm-usage --window-size=1920,1080 --remote-debugging-port=9222 --disable-setuid-sandbox --disable-features=UtilityProcessSandbox --disable-background-networking --disable-default-apps --disable-extensions --disable-sync --disable-translate --hide-scrollbars --metrics-recording-only --mute-audio --no-first-run --no-default-browser-check --no-zygote --single-process --ignore-certificate-errors --disable-popup-blocking --disable-infobars

# Initialize the variable to prevent "Variable definition not found" if accessed before being set
${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}

*** Keywords ***
Open Browser With Unique Profile
    [Documentation]    Opens a Chrome browser with a unique user data directory for CI environments.
    [Arguments]    ${url}    ${browser_alias}=${NONE}

    # Generate a unique path for the user data directory using forward slashes
    ${TIMESTAMP}=    Get Time    epoch
    ${RANDOM_STRING}=    Generate Random String    length=8    chars=[ALPHANUMERIC]
    ${USER_PROFILE_PARENT_DIR}=    Set Variable    ${CURDIR}/chrome_profiles
    ${USER_DATA_DIR}=              Set Variable    ${USER_PROFILE_PARENT_DIR}/${TIMESTAMP}_${RANDOM_STRING}

    # Ensure the parent directory for profiles exists, then create the unique profile directory
    # --- CRITICAL MODIFICATION START ---
    ${parent_exists}=    Run Keyword And Return Status    Directory Exists    ${USER_PROFILE_PARENT_DIR}
    Run Keyword Unless    ${parent_exists}    Create Directory    ${USER_PROFILE_PARENT_DIR}

    ${data_dir_exists}=  Run Keyword And Return Status    Directory Exists    ${USER_DATA_DIR}
    Run Keyword Unless    ${data_dir_exists}    Create Directory    ${USER_DATA_DIR}
    # --- CRITICAL MODIFICATION END ---

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
    ${USER_DATA_DIR_TO_CLEAN}=    Get Variable Value       ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}

    # If a user data directory was set and exists, try to remove it recursively
    ${data_dir_to_clean_exists}=    Run Keyword And Return Status    Directory Exists    ${USER_DATA_DIR_TO_CLEAN}
    Run Keyword If    ${data_dir_to_clean_exists}    Remove Directory    ${USER_DATA_DIR_TO_CLEAN}    recursive=True

    # Reset the variable after cleanup to ensure clean state for next test
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}