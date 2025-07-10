*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    BuiltIn

*** Variables ***
${CHROME_BASE_ARGS}    --headless    --disable-gpu    --no-sandbox    --disable-dev-shm-usage    --window-size=1920,1080    --remote-debugging-port=9222    --disable-setuid-sandbox    --disable-features=UtilityProcessSandbox    --disable-background-networking    --disable-default-apps    --disable-extensions    --disable-sync    --disable-translate    --hide-scrollbars    --metrics-recording-only    --mute-audio    --no-first-run    --no-default-browser-check    --no-zygote    --single-process    --ignore-certificate-errors    --disable-popup-blocking    --disable-infobars

${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${browser_alias}=${NONE}

    ${TIMESTAMP}=    Get Time    epoch
    ${RANDOM_STRING}=    Generate Random String    8    [LETTERS]
    ${USER_PROFILE_PARENT_DIR}=    Set Variable    ${CURDIR}${/}chrome_profiles
    ${USER_DATA_DIR}=    Set Variable    ${USER_PROFILE_PARENT_DIR}${/}${TIMESTAMP}_${RANDOM_STRING}

    # Create parent directory if it doesn't exist
    ${parent_exists}=    Directory Should Exist    ${USER_PROFILE_PARENT_DIR}    False
    Run Keyword Unless    ${parent_exists}    Create Directory    ${USER_PROFILE_PARENT_DIR}

    ${data_dir_exists}=    Directory Should Exist    ${USER_DATA_DIR}    False
    Run Keyword Unless    ${data_dir_exists}    Create Directory    ${USER_DATA_DIR}

    # Combine arguments
    ${ALL_OPTIONS_LIST}=    Create List    @{CHROME_BASE_ARGS}
    Append To List    ${ALL_OPTIONS_LIST}    --user-data-dir=${USER_DATA_DIR}
    ${OPTIONS_STRING}=    Combine To String    ${ALL_OPTIONS_LIST}

    Open Browser    ${url}    chrome    options=${OPTIONS_STRING}    alias=${browser_alias}
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${USER_DATA_DIR}

Close And Clean All Browsers
    Close All Browsers
    ${USER_DATA_DIR_TO_CLEAN}=    Get Variable Value    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}
    Run Keyword If    '${USER_DATA_DIR_TO_CLEAN}' != '${NONE}' and    Directory Should Exist    ${USER_DATA_DIR_TO_CLEAN}    False
    ...    Remove Directory    ${USER_DATA_DIR_TO_CLEAN}    recursive=True
    Set Test Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${NONE}

*** Keywords ***
Combine To String
    [Arguments]    @{list}
    ${joined}=    Evaluate    " ".join("""@{list}""")    modules=robot.libraries.BuiltIn
    [Return]    ${joined}
