*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${BROWSER_OPTIONS}    add_argument(--headless)    add_argument(--no-sandbox)

*** Keywords ***
Open Chrome Browser
    [Arguments]    ${url}
    Open Browser    ${url}    chrome    options=${BROWSER_OPTIONS}
