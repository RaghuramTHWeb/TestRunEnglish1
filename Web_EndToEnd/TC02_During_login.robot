*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***
${Url}    https://app-dev.taskhuman.com/login
${BROWSER}    Chrome

*** Test Cases ***
During Login_ Validate Back and Login (With Email and Password) functionality
    During Login_ Validate Back and Login (With Email and Password) functionality
During Login_ Validate Forget Password functionality (Change and login) and then cancel when trying to request password
    validate if user is able to click on forget password and then cancel

*** Keywords ***
During Login_ Validate Back and Login (With Email and Password) functionality
    Go To    https://app-dev.taskhuman.com/login?type=form
    Wait Until Element Is Visible    css=button.LoginForm-module__FormButtons--cancel    10s
    Click Element    css=button.LoginForm-module__FormButtons--cancel
    Wait Until Location Is    https://app-dev.taskhuman.com/login    10s
    Location Should Be    https://app-dev.taskhuman.com/login 
    Sleep    2s
validate if user is able to click on forget password and then cancel
    Go To    https://app-dev.taskhuman.com/login?type=form
    Wait Until Element Is Visible    css=p.chakra-text.css-0    10s
    Click Element    css=p.chakra-text.css-0
    Wait Until Element Is Visible    xpath=//button[contains(@class, "EmailVerification-module__VerificationForm__button--cancel")]    10s
    Click Element    xpath=//button[contains(@class, "EmailVerification-module__VerificationForm__button--cancel")]
    Sleep    2s
