*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
test01
    Open Browser    https://app-dev.taskhuman.com/signup       chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath=//div[@class='recaptcha-checkbox-border']    timeout=10
    Click Element    xpath=//div[@class='recaptcha-checkbox-border']