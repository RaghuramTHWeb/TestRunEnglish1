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

    ${timestamp}=    Get Time    epoch
    ${random}=       Generate Random String    5
    ${profile_dir}=  Set Variable    ${PROFILE_ROOT_DIR}/${alias}_${timestamp}_${random}

    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${PROFILE_ROOT_DIR}
    Run Keyword Unless    ${exists}    Create Directory    ${PROFILE_ROOT_DIR}
    Create Directory    ${profile_dir}

    ${args}=    Create List
    FOR    ${arg}    IN    @{CHROME_BASE_ARGS}
        Append To List    ${args}    --add-argument=${arg}
    END
    Run Keyword If    '${alias}' == 'INC'    Append To List    ${args}    --add-argument=--incognito
    Append To List    ${args}    --add-argument=--user-data-dir=${profile_dir}

    Open Browser    ${url}    chrome    ${EMPTY}    alias=${alias}    ${args}
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    ${profile_dir}


Join Chrome Args
    [Arguments]    @{args}
    ${joined}=    Set Variable    ${EMPTY}
    FOR    ${item}    IN    @{args}
        ${joined}=    Set Variable    ${joined} ${item}
    END
    [Return]    ${joined}

Close And Clean All Browsers
    Close All Browsers
    ${profile}=    Set Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}
    ${exists}=    Run Keyword And Return Status    Directory Should Exist    ${profile}
    Run Keyword If    '${profile}' != 'NONE' and ${exists}    Remove Directory    ${profile}    recursive=True
    Set Suite Variable    ${_CURRENT_BROWSER_USER_DATA_DIR}    NONE
