*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Login
    Login As Consumer
Concierge through skill details in discovery page
    Check redirection through skill details in discovery page
#Validate Concierge when provider is fully booked
 #   goto explore coaching section and validate concierge

*** Keywords ***
Login as Consumer
    Open Browser    https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    5s
    sleep    5s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    sleep    5s
    Wait Until Element Is Visible    id:field-:r0:
    sleep    5s
    Input Text    id:field-:r0:    raghuram.m+rc1@taskhuman.com
    Input Text    id:field-:r1:    asdfgh@12345Q
    Click Element    xpath://button[@value='submit']
    Sleep    3s
Check redirection through skill details in discovery page
    Wait Until Element Is Visible    xpath://div[@class='chakra-stack DiscoverProgram-module__ProgramInfo--VStask css-owjkmg']    5s
    Click Element    xpath://div[@class='chakra-stack DiscoverProgram-module__ProgramInfo--VStask css-owjkmg']
    Sleep    3s
    Wait Until Element Is Visible    xpath://span[@class='SkillDetails-module__Contact--Concierge--Text']
    Click Element    xpath://span[@class='SkillDetails-module__Contact--Concierge--Text']
    Sleep    6s
    Location Should Be    https://app-dev.taskhuman.com/concierge
    Sleep    3s
    Close Browser
#goto explore coaching section and validate concierge
#    Go To    https://app-dev.taskhuman.com/discover
 #   Sleep    3s
 #   Wait Until Element Is Visible    xpath://div[contains(@class,'DiscoverTab-module__tab--name css-0')][normalize-space()='Explore 1:1 Coaching']    5s
  #  Click Element    xpath://div[contains(@class,'DiscoverTab-module__tab--name css-0')][normalize-space()='Explore 1:1 Coaching']
 #   Sleep    4s
  #  Wait Until Element Is Visible    xpath://body/div[@id='root']/div[contains(@class,'AppLayout-module__AppLayout css-7luvuw')]/div[contains(@class,'AppLayout-module__Container AppLayout-module__WebApp css-v2zi83')]/div[contains(@class,'DiscoverTab-module__DiscoverTab css-0')]/div[contains(@class,'DiscoverCard-module__DiscoverCards css-0')]/div[2]/div[1]    5s
   # Click Element    xpath://body/div[@id='root']/div[contains(@class,'AppLayout-module__AppLayout css-7luvuw')]/div[contains(@class,'AppLayout-module__Container AppLayout-module__WebApp css-v2zi83')]/div[contains(@class,'DiscoverTab-module__DiscoverTab css-0')]/div[contains(@class,'DiscoverCard-module__DiscoverCards css-0')]/div[2]/div[1]
   # Sleep    4s
   # Wait Until Element Is Visible    xpath://p[contains(@class,'chakra-text CoachNotFound-module__CoachNotFound--Text--Desktop css-0')]//span[contains(@class,'CoachNotFound-module__Concierge--Link')][normalize-space()='Concierge']    5s
   # Click Element    xpath://p[contains(@class,'chakra-text CoachNotFound-module__CoachNotFound--Text--Desktop css-0')]//span[contains(@class,'CoachNotFound-module__Concierge--Link')][normalize-space()='Concierge']
   # Sleep    5s
   # Location Should Be    https://app-dev.taskhuman.com/concierge
   # Sleep    3s
