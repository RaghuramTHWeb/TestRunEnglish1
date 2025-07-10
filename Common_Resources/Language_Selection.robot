*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${DROPDOWN}         xpath=//div[@class='css-1wy0on6']
${ARABIC_OPTION}    xpath=//p[text()='العربية']
${LANGUAGE_MENU}    xpath=//div[@class='css-9lrrh2-menu']
${SELECTED_LANG}    xpath=//div[@class='css-cb61nx-singleValue']

*** Keywords ***
Ensure Arabic Language Selected
    [Documentation]    Checks if Arabic is selected, if not, selects it.

    Go To    https://app-dev.taskhuman.com/settings
    Wait Until Element Is Visible    ${DROPDOWN}    timeout=5s

    # Try to locate Arabic in the visible list without clicking the dropdown
    ${is_arabic_visible} =  Run Keyword And Return Status  Element Should Be Visible  ${ARABIC_OPTION}

    # If Arabic is not visible, open the dropdown and select Arabic
    Run Keyword Unless    ${is_arabic_visible}    Select Arabic Language

Select Arabic Language
    Click Element    ${DROPDOWN}   # Opens the dropdown
    Wait Until Element Is Visible    ${LANGUAGE_MENU}    timeout=5s
    Click Element    ${ARABIC_OPTION}   # Select Arabic
    Sleep  2s   # Allow selection to take effect
