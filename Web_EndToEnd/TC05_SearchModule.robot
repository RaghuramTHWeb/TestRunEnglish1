*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/Reboot_Consumer_login.robot

*** Variables ***
${call_icon}    //div[@class='ActionMenu-module__ActionMenu--List css-0']//img[1]
${green_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-goqhe
${yellow_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-ve545j
${Grey_dot}    css:div.chakra-avatar__badge.UserAvatar-module__xxl--StatusBadge.css-1o1vlua

*** Test Cases ***
Search Module_ Validate discount code section in settings (with and without discount code)
    Login As Consumer    ${consumer_email}    ${consumer_password}
Search Module_ Search by topic
    Search by topic
Search Module_ Validate if topic search results can be discarded by clicking on "x" icon
    Validate if topic search results can be discarded by clicking on "x" icon
Search Module_Search by name
    Search by name
Search Module_ Validate if Name search results can be discarded by clicking on "x" icon
    Validate if Name search results can be discarded by clicking on "x" icon
Search Module_Validate random search result through provider not found
    Validate random search result through provider not found
Search Module_ Check redirection to provider's profile from search
    Check redirection to provider's profile from search
Search Module_Validate accessibility of chat section from provider search
    Validate accessibility of chat section from provider search
Search Module_Validate on click behavior of "view schedule" when user searches with provider name
     Validate on click behavior of "view schedule" when user searches with provider name
Search Module_Validate search results are accurate when searched with first name / last name of provider
    Validate search results are accurate when searched with first name / last name of provider
Search Module_Validate user can click on displayed topics through search results which redirects to skill page 
    Validate user can click on displayed topics through search results which redirects to skill page
Search Module_Check request from search by tapping redirect on concierge
    Check request from search by tapping redirect on concierge
Search Module_Check availability of providers from search topic
    Check availability of providers from search topic
Search Module_Validate that data loads for large sets of search results as user tries to scroll
    Validate that data loads for large sets of search results as user tries to scroll

#Check video call icon is visible when provider is available with green dot
    #Check video call icon is visible when provider is available with green dot
   # Check book call icon is visible when provider is available with yellow dot
    #Check request icon is visible when provider is available with grey dot
    #Close Browser

*** Keywords ***
Search by topic
    Wait Until Element Is Visible    css=p.FloatinSearchButton-module__Sticky--Button--Text    10s
    Click Element    css=p.FloatinSearchButton-module__Sticky--Button--Text
    Input Text    //*[@id="input-field"]    Yoga    10s
    Press Key    //*[@id="input-field"]    \\13
Validate if topic search results can be discarded by clicking on "x" icon
    Wait Until Element Is Visible    xpath=(//div[@class="chakra-card DiscoverCard-module__card css-hnw95f"])[1]    10s
    Wait Until Element Is Visible    css=div.Search-module__SearchView--Input__Clear    10s
    Click Element    css=div.Search-module__SearchView--Input__Clear

Search by name
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'Search-module__search--Flex__Box') and contains(@class, 'css-0') and not(contains(@class, 'Search-module__active'))]    10s
    Click Element    xpath=//div[contains(@class, 'Search-module__search--Flex__Box') and contains(@class, 'css-0') and not(contains(@class, 'Search-module__active'))]
    Input Text    xpath=//input[@id='input-field']    ashhsha
    Press Key    //*[@id="input-field"]    \\13
Validate random search result through provider not found
    Element Should Not Be Visible    css=img[src='/60be4485a05d399292d8.svg']    5s
Validate if Name search results can be discarded by clicking on "x" icon
    Wait Until Element Is Visible    css=div.Search-module__SearchView--Input__Clear    10s
    Click Element    css=div.Search-module__SearchView--Input__Clear
    Input Text    xpath=//input[@id='input-field']    test
    Press Key    //*[@id="input-field"]    \\13
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'CoachCard-module__CoachCard--Box')]    10s

Check redirection to provider's profile from search
    Click Element    xpath=//div[contains(@class, 'CoachCard-module__CoachCard--Box')][1]
    Wait Until Element Is Visible    css=div.CoachCard-module__CoachCard--Box__UserInfo:first-of-type .CoachCard-module__UserInfo--Name    10s
    Click Element    css=div.CoachCard-module__CoachCard--Box__UserInfo:first-of-type .CoachCard-module__UserInfo--Name
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'ActionMenu-module__ActionMenu--List')]    10s
    Click Element    xpath=//div[contains(@class, 'ActionMenu-module__ActionMenu--List')]
Validate accessibility of chat section from provider search
    Go To    https://app-dev.taskhuman.com/search/name/test
    Wait Until Element Is Visible    css=img[src='/60be4485a05d399292d8.svg']    10s
    Click Element    css=img[src='/60be4485a05d399292d8.svg']
    Wait Until Element Is Visible    css=div.MessageModal-module__Phrases--Box.css-0 > span:first-child    10s
    Click Element    css=div.MessageModal-module__Phrases--Box.css-0 > span:first-child
    Wait Until Element Is Visible    css=button.MessageModal-module__NextButton.MessageModal-module__ActiveButton    10s
    Click Element    css=button.MessageModal-module__NextButton.MessageModal-module__ActiveButton
    Wait Until Element Is Visible    css=div.ChatsText-module__Chats--Box    10s
Validate on click behavior of "view schedule" when user searches with provider name
    Go To    https://app-dev.taskhuman.com/search/name/test
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'CoachCard-module__CoachCard--Box')]    10s
    Click Element    xpath=//div[contains(@class, 'CoachCard-module__CoachCard--Box')][1]
    Wait Until Element Is Visible    css=div.CoachCard-module__Accordion--Panel__Info    10s
Validate search results are accurate when searched with first name / last name of provider
    Go To    https://app-dev.taskhuman.com/search/name/offline
    Wait Until Element Is Visible    css=div.CoachCard-module__CoachCard--Box__UserInfo:first-of-type .CoachCard-module__UserInfo--Name    10s
    Click Element    css=div.CoachCard-module__CoachCard--Box__UserInfo:first-of-type .CoachCard-module__UserInfo--Name
    ${firstname_location}=    Get Location
    Go To    https://app-dev.taskhuman.com/search/name/QA
    Wait Until Element Is Visible    css=div.CoachCard-module__CoachCard--Box__UserInfo:first-of-type .CoachCard-module__UserInfo--Name    10s
    Click Element    css=div.CoachCard-module__CoachCard--Box__UserInfo:first-of-type .CoachCard-module__UserInfo--Name
    ${Secondname_location}=    Get Location
    Should Be Equal    ${firstname_location}    ${Secondname_location}
Validate user can click on displayed topics through search results which redirects to skill page 
    Go To    https://app-dev.taskhuman.com/search/topic/yoga
    Wait Until Element Is Visible    xpath=(//div[@class='chakra-card DiscoverCard-module__card css-hnw95f'])[1]    10s
    Click Element    xpath=(//div[@class='chakra-card DiscoverCard-module__card css-hnw95f'])[1]
    Location Should Be    https://app-dev.taskhuman.com/discover/skill/60bf17ca74790a59f409f1f4

Check request from search by tapping redirect on concierge
    Go To    https://app-dev.taskhuman.com/search/name/test
    Wait Until Element Is Visible     xpath=//img[@src='/bf0e4c1106cf2e397026.svg']    10s
    Click Element    xpath=//img[@src='/bf0e4c1106cf2e397026.svg']
    Wait Until Element Is Visible    xpath=//div[@class='ChatsText-module__Category css-0']    10s
Check availability of providers from search topic
    Go To    https://app-dev.taskhuman.com/search/name/offline
    Wait Until Element Is Visible    xpath=//img[@src='/7b38eccd8a9db1e9434e.svg']    10s
Validate that data loads for large sets of search results as user tries to scroll
    Go To    https://app-dev.taskhuman.com/search/topic/yoga
    Wait Until Element Is Visible    xpath=(//div[@class='chakra-card DiscoverCard-module__card css-hnw95f'])[1]    10s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    xpath=(//div[@class='chakra-card DiscoverCard-module__card css-hnw95f'])[last()]    10s
    Click Element    xpath=(//div[@class='chakra-card DiscoverCard-module__card css-hnw95f'])[last()]

Check video call icon is visible when provider is available with green dot
    Go To    https://app-dev.taskhuman.com/profile/5466
    Wait Until Page Contains Element        ${green_dot}   10s
    ${Path_found1}=    Run Keyword And Return Status        Element Should Not Be Visible   ${green_dot}
    Run Keyword If    ${Path_found1}    Element Should Not Be Visible    ${call_icon}
Check book call icon is visible when provider is available with yellow dot
    Go To    https://app-dev.taskhuman.com/profile/4517
    # Check if the element is present
    Wait Until Page Contains Element    ${yellow_dot}    10s
    ${element_present}=    Run Keyword And Return Status    Element Should Be Visible    ${yellow_dot}
    # Check if the specific element is not present
    ${element_not_present}=    Run Keyword And Return Status    Page Should Not Contain Element    ${call_icon}
    # Pass if both conditions are met
    Run Keyword If    ${element_present} and ${element_not_present}    Log    Both conditions are met
Check request icon is visible when provider is available with grey dot
    Go To    https://app-dev.taskhuman.com/profile/2155
     # Check if the element is present
    Wait Until Page Contains Element    ${Grey_dot}    10s
    ${element_present1}=    Run Keyword And Return Status    Element Should Be Visible    ${Grey_dot}
    # Check if the specific element is not present
    ${element_not_present2}=    Run Keyword And Return Status    Page Should Not Contain Element    ${call_icon}
    # Pass if both conditions are met
    Run Keyword If    ${element_present1} and ${element_not_present2}    Log    Both conditions are met


