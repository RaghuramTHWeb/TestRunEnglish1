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

${PROFILE_ROOT_DIR}    /tmp/chrome_profiles
${_CURRENT_BROWSER_USER_DATA_DIR}    NONE

*** Keywords ***
Open Browser With Unique Profile
    [Arguments]    ${url}    ${alias}

    ${is_ci}=    Run Keyword And Return Status    Environment Variable Should Be Set    GITHUB_ACTIONS
    ${timestamp}=    Get Time    epoch
    ${random}=       Generate Random String    5
    ${profile_dir}=  Set Variable    ${PROFILE_ROOT_DIR}/${timestamp}_${random}

    ${args}=    Create List
    FOR    ${arg}    IN    @{CHROME_BASE_ARGS}
        Append To List    ${args}    ${arg}
    END

    Run Keyword If    '${alias}' == 'INC'    Append To List    ${args}    --incognito
    Run Keyword Unless    ${is_ci}    Append To List    ${args}    --user-data-dir=${profile_dir}

    ${options}=    Catenate    SEPARATOR=    @{args}
    Log    Final Chrome Args: ${options}

    Open Browser    ${url}    chrome    options=${options}    alias=${alias}
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${profile_dir}

Close And Clean All Browsers
    Close All Browsers
    ${profile}=    Set Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${profile}
    Run Keyword If    '${profile}' != 'NONE' and ${exists}    Remove Directory    ${profile}    recursive=True
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    NONE
