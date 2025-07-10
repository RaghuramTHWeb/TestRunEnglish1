*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${Url}    https://app-dev.taskhuman.com/login
${BROWSER}    Chrome

*** Test Cases ***
Validate Page content/UI on Login page
    Validate Title,Text,TH image,TH logo visibility
    Validate signup,login, Footer content are visible on login page

Validate login modules(Facebook, google, Apple, Microsoft) are available on login page
    Validate login options visible on login page
    
Validate 'signup' redirection till user navigated to Mobile number verification
    Validate 'signup' redirection till user navigated to Mobile number verification

Before login_ Validate redirection of terms and conditions, Privacy Policy on Pre-login page
   Validate 'Terms & Conditions' link and content on login page
   Validate 'Privacy Policy' link and content on login page
#Login with Google Account
    #Login with Google Account

*** Keywords ***
Validate Title,Text,TH image,TH logo visibility
   Open Browser    ${Url}    ${BROWSER}
   Maximize Browser Window
   Wait Until Element Is Visible    xpath=//div[contains(@class, "Login-module__login__img--Title")]    5s
   Element Should Be Visible    xpath=//div[contains(@class, "Login-module__login__img--Title")]
   Wait Until Element Is Visible    xpath=//div[contains(@class, "Login-module__login__img--Header") and contains(., "Human Guidance At Your Fingertips")]    5s
   Element Text Should Be    xpath=//div[contains(@class, "Login-module__login__img--Header") and contains(., "Human Guidance At Your Fingertips")]    Human Guidance At Your Fingertips
   Wait Until Element Is Visible    xpath=//img[@src="/d5190f396ac40361f44a.svg"]    5s
   Element Should Be Visible    xpath=//img[@src="/d5190f396ac40361f44a.svg"]
   Wait Until Element Is Visible    xpath=//img[@src="/d3c98eb31fd89ce7a99d.svg" and contains(@class, "Login-module__login__logo")]    5s
   Element Should Be Visible    xpath=//img[@src="/d3c98eb31fd89ce7a99d.svg" and contains(@class, "Login-module__login__logo")]
   Sleep    2s
Validate login options visible on login page
   Wait Until Element Is Visible    id=googleOauthButton    5s
   Element Should Be Visible    id=googleOauthButton
   Wait Until Element Is Visible    xpath=//div[contains(@class, "Oauth-module__facebook-btn")]    5s
   Element Should Be Visible    xpath=//div[contains(@class, "Oauth-module__facebook-btn")]
   Wait Until Element Is Visible    xpath=//div[contains(@class, "Oauth-module__apple-btn")]    5s
   Element Should Be Visible    xpath=//div[contains(@class, "Oauth-module__apple-btn")] 
   Sleep    2s
Validate signup,login, Footer content are visible on login page
   Wait Until Element Is Visible    xpath=//button[contains(@class, "Login-module__email_signin_btn")]    5s
   Element Should Be Visible    xpath=//button[contains(@class, "Login-module__email_signin_btn")]
   Wait Until Element Is Visible    xpath=//div[contains(@class, "Login-module__signin__option--text") and contains(., "Already have an account?") and .//div[text()="Login"]]    5s
   Element Should Be Visible    xpath=//div[contains(@class, "Login-module__signin__option--text") and contains(., "Already have an account?") and .//div[text()="Login"]]
   Wait Until Element Is Visible    xpath=//div[contains(@class, "Login-module__login__condition--text") and contains(., "By continuing, I agree to TaskHuman’s") and .//a[contains(@href, "terms-conditions") and contains(text(), "Terms & Conditions")] and .//a[contains(@href, "privacy-policy") and contains(text(), "Privacy Policy")]]    5s
   Element Should Be Visible    xpath=//div[contains(@class, "Login-module__login__condition--text") and contains(., "By continuing, I agree to TaskHuman’s") and .//a[contains(@href, "terms-conditions") and contains(text(), "Terms & Conditions")] and .//a[contains(@href, "privacy-policy") and contains(text(), "Privacy Policy")]]
   Sleep    2s
Validate 'Terms & Conditions' link and content on login page
   Wait Until Element Is Visible    xpath=//a[contains(@href, "terms-conditions")]    5s
   Click Element    xpath=//a[contains(@href, "terms-conditions")]
   Sleep    3s
   Switch Window    NEW
   Sleep    3s
   Wait Until Location Is    https://taskhuman.com/terms-conditions/    5s
   Location Should Be    https://taskhuman.com/terms-conditions/
Validate 'Privacy Policy' link and content on login page
   Go To    ${Url}
   Maximize Browser Window
   Wait Until Element Is Visible    xpath=//a[contains(@href, "privacy-policy")]    5s
   Click Element    xpath=//a[contains(@href, "privacy-policy")]
   Sleep    3s
   Switch Window    NEW
   Sleep    3s
   Wait Until Location Is    https://taskhuman.com/privacy-policy/    5s
   Location Should Be    https://taskhuman.com/privacy-policy/
   Sleep    3s
Validate 'signup' redirection till user navigated to Mobile number verification
    Go To    ${Url}
    Wait Until Element Is Visible    xpath=//button[contains(@class, "Login-module__email_signin_btn")]    5s
    Click Element    xpath=//button[contains(@class, "Login-module__email_signin_btn")]
    Wait Until Location Is    https://app-dev.taskhuman.com/signup    5s
    Location Should Be    https://app-dev.taskhuman.com/signup
    Wait Until Element Is Visible    id=firstName    10s
    Input Text    id=firstName    Test
    Wait Until Element Is Visible    id=lastName    10s
    Input Text    id=lastName    Automation
    Wait Until Element Is Visible    id=email    10s
    Clear Element Text    id=email
    Input Text    id=email    testautomation@taskhuman.com
    Wait Until Element Is Visible    id=password    10s
    Clear Element Text    id=password
    Input Text    id=password    asd@123Q
    Sleep    2s
    Wait Until Element Is Visible    xpath=//button[contains(@class, "SignupForm-module__SignupForm__button--continue")]    10s
    #Click Element    xpath=//button[contains(@class, "SignupForm-module__SignupForm__button--continue")]
    #Wait Until Element Is Visible    xpath=//div[contains(@class, "Verification-module__Verification_form_field")]//div[contains(@class, "css-h57wz8-control")]    10s
    Wait Until Element Is Visible    xpath=//button[contains(@class, "SignupForm-module__SignupForm__button--cancel") and text()="Cancel"]    10s
    Click Element    xpath=//button[contains(@class, "SignupForm-module__SignupForm__button--cancel") and text()="Cancel"]
    Sleep    3s
        
Login with Google Account
    Open Browser    ${Url}    ${BROWSER}
    Maximize Browser Window
    Sleep    3s
    Click Element    xpath://div[@id='googleOauthButton']
    Switch Window    locator=NEW
    Sleep    3s
    Input Text    xpath=//input[@id='identifierId']    raghuram.m@taskhuman.com
    Click Element    xpath://span[text()='Next']
    Sleep    2s
    Input Text    xpath=//input[@name='Passwd']    qwertyuiop@123A
    Click Element    xpath://span[text()='Next']
    # Handle 2-step verification manually
    Sleep    30s
    ${handles} =    Get Window Handles
    #Close Window    ${handles}[1]    # Close the Google login window
    Switch Window    ${handles}[0]    # Switch back to the original window
    Wait Until Page Contains    Human Guidance At Your Fingertips    timeout=30s




