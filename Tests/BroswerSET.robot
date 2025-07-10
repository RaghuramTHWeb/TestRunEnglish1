*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Open and Position Browsers
    [Documentation]    Opens two browsers and positions them side by side.

    #normal mode
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=NORM
    Set Window Size    650    1200
    Set Window Position    0    0

    # incognito mode
    Open Browser    https://app-dev.taskhuman.com/login    Chrome    alias=INC    options=add_argument("--incognito")
    Set Window Size    650    1200
    Set Window Position    650    0
