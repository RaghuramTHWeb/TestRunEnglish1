*** Settings ***
Library    SeleniumLibrary
Resource    ../Common_Resources/PreloginArabicSelection.robot
Suite Teardown    Close All Browsers

*** Variables ***
${CONSUMER_EMAIL}    raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}    asdfgh@12345Q

*** Test Cases ***
Check for language in Arabic and switch if needed
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Ensure Arabic Language Selected


Login as Consumer
    # Logs in as a consumer in normal mode.
    #Open Browser    https://app-dev.taskhuman.com/login    Chrome
    #Maximize Browser Window
    Wait Until Element Is Visible    xpath://div[@class='Login-module__signup-text css-0']    10s
    Click Element    xpath://div[@class='Login-module__signup-text css-0']
    Wait Until Element Is Visible    xpath=//input[@name='email']    10s
    Click Element    xpath=//input[@name='email']
    Input Text    xpath=//input[@name='email']    ${CONSUMER_EMAIL}
    Wait Until Element Is Visible    xpath=//input[@name='password']    10s
    Click Element    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${CONSUMER_PASSWORD}
    Wait Until Element Is Visible    xpath://button[@value='submit']    10s
    Click Element    xpath://button[@value='submit']
    Sleep    3s
Search for Provider and Book
    #Go To    https://app-dev.taskhuman.com/search/name/Offlineprovidertest
    #Go To    https://app-dev.taskhuman.com/search/name/%D8%B1%D8%A7%D8%BA%D9%88   offline provider qa
    Go To    https://app-dev.taskhuman.com/search/name/%D8%B1%D8%A7%D8%BA%D9%88%20%D9%83%D8%A8%D8%B4
    #Sleep    5s
    Wait Until Element Is Visible    xpath=//div[@data-testid='action_menu_book_btn']    10s
    Click Element                    xpath=//div[@data-testid='action_menu_book_btn']
    Wait Until Element Is Visible    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]    10s
    Click Element                    xpath=(//span[contains(@class, 'SkillsModalContent-module__SkillsList__Skill')])[1]
    Wait Until Element Is Visible    xpath=//button[@data-testid="next_btn"]    10s
    Click Element                    xpath=//button[@data-testid="next_btn"]
    # Wait until the booking forms are loaded
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'BookingForm-module__BookingForm--Body')])[1]    10s
    # Expand the first accordion section
    Click Element    xpath=(//div[contains(@class,'BookingForm-module__BookingForm--Body')] //button[contains(@class,'BookingForm-module__accordion--btn')])[1]
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'BookingForm-module__BookingForm--Body')] //div[contains(@class,'BookingForm-module__TimeTag--Box')])[1]    10s
    # Click the first time tag inside the expanded section
    Click Element    xpath=(//div[contains(@class,'BookingForm-module__BookingForm--Body')] //div[contains(@class,'BookingForm-module__TimeTag--Box')]//div[contains(@class,'BookingForm-module__Time--Tag')])[1]
    #Wait Until Element Is Visible    xpath=//div[contains(@class, 'ActionMenu-module__ActionMenu--Search--Box') and .//p[text()='Book']]    5s
    #Click Element    xpath=//div[contains(@class, 'ActionMenu-module__ActionMenu--Search--Box') and .//p[text()='Book']]
    Wait Until Element Is Visible    xpath=//button[@data-testid="verify_session_btn"]    10s
    Click Element                    xpath=//button[@data-testid="verify_session_btn"]
    Wait Until Element Is Visible    id=book_seesion_btn    10s
    Click Element    id=book_seesion_btn
    Wait Until Element Is Visible    css=[data-testid="got_it_btn"]    10s
    Click Element    css=[data-testid="got_it_btn"]
   
    #Sleep    5s
    #Wait Until Page Contains Element    xpath://*[text()='Select a Topic']    4s
    #Sleep    2s
    #Wait Until Element Is Visible    xpath=//span[contains(@class,'BookingForm-module__Topic--Tag') and contains(text(),'Hypnosis')]    5S
    #Click Element    xpath=//span[contains(@class,'BookingForm-module__Topic--Tag') and contains(text(),'Hypnosis')]
    #Sleep    5s
    #Click Element    xpath://*[text()='Next']
    #Sleep    5s
    #Wait Until Element Is Visible    xpath://*[text()='Tomorrow']    5s
    #Click Element    xpath://*[text()='Tomorrow']
    #Sleep    5s
    #Execute JavaScript    document.evaluate("//p[contains(@class,'BookingForm-module__Tag__Text') and contains(text(),'10:40pm')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    ##Wait Until Element Is Visible    xpath=//p[contains(@class,'BookingForm-module__Tag__Text') and starts-with(text(),'10:40pm')]    10s
    #lick Element    xpath=//p[contains(@class,'BookingForm-module__Tag__Text') and starts-with(text(),'10:40pm')]
    #Sleep    5s
    #Click Element    xpath://*[text()='Verify Session']
    #Sleep    5s
    #Wait Until Element Is Visible  xpath://*[text()='Book Session']
    #Click Element    xpath://*[text()='Book Session']
    #Sleep    10s
    ##Wait Until Element Is Visible    xpath://*[text()='Got it!']
    #Click Element    xpath://*[text()='Got it!']
    #Sleep    6s
Validate if booking can be deleted
           Go To    https://app-dev.taskhuman.com/bookings/session

    # Wait for delete icon to appear
    Wait Until Element Is Visible    xpath=//div[@data-testid="booking_delete_btn"]    10s

    # Click delete icon (get fresh element each time)
    Click Element    xpath=//div[@data-testid="booking_delete_btn"]
    Sleep    1s

    # Wait for the confirmation delete button to appear (Arabic text button)
    Wait Until Element Is Visible    xpath=//button[normalize-space(.)='يمسح']    10s

    # Click confirm delete button
    Click Element    xpath=//button[normalize-space(.)='يمسح']
    Sleep    1s

    Close Browser