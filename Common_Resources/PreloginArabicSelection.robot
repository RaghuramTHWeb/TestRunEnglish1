*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Ensure Arabic Language Selected

    #Open Browser   https://app-dev.taskhuman.com/login    chrome
    #Maximize Browser Window
    ${is_arabic}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//div[contains(@class,'css-cb61nx-singleValue') and normalize-space(.)='العربية']
    Run Keyword Unless    ${is_arabic}    Select Arabic Language

Select Arabic Language
    Wait Until Element Is Visible    xpath=//div[contains(@class,'css-vjv190-indicatorContainer')]    10s
    Click Element    xpath=//div[contains(@class,'css-vjv190-indicatorContainer')]
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'css-9lrrh2-menu')]//p[text()='العربية']    10s
    Click Element    xpath=//div[contains(@class, 'css-9lrrh2-menu')]//p[text()='العربية']
