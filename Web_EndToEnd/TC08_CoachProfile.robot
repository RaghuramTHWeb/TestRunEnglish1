*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/Reboot_Consumer_login.robot

*** Test Cases ***
Login as consumer
        Login As Consumer    ${consumer_email}    ${consumer_password}
Coach profile___Validate content in provider profile page
    Validate content in provider profile page
    Close Browser



*** Keywords ***
Validate content in provider profile page
    Go To    https://app-dev.taskhuman.com/profile/7001
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Profile-module__ProviderProfile--UserInfo')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Profile-module__ProviderProfile--UserInfo__AvtarContainer')]//img    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Profile-module__ProviderProfile--UserInfo__NameContainer')]//div[contains(@class, 'Profile-module__ProviderProfile--UserInfo__Name')]    10s
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ActionMenu-module__ActionMenu--List')]//img    10s


    
    