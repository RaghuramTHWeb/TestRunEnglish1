*** Settings ***
Library    SeleniumLibrary
Library    SeleniumLibrary
Resource    ../Common_Resources/PreloginArabicSelection.robot


*** Variables ***
${CONSUMER_EMAIL}    raghuram.m+rc1@taskhuman.com
${CONSUMER_PASSWORD}    asdfgh@12345Q
${HOW_BOOKINGS_WORK_TEXT}    xpath=//p[text()='كيف تعمل الحجوزات']
${Expected Inst01}    افتح التطبيق في وقت جلستك للاتصال بمدربك.
${Expected Inst02}    يمكنك إلغاء الحجز في أي وقت دون أي عقوبة قبل بدء الجلسة.
${Expected Inst03}    إذا لم يقم المدرب بالرد على المكالمة، فسيتم إعادة الدقائق إلى حسابك.
${GOT_IT_BUTTON}           xpath=//div[text()='فهمتها!']



*** Test Cases ***
Open the browser and login as Consumer
    Open Browser   https://app-dev.taskhuman.com/login    chrome
    Maximize Browser Window
    Ensure Arabic Language Selected
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
Check How Booking work is clickable
    Go To    https://app-dev.taskhuman.com/bookings/session
    Wait Until Element Is Visible    ${HOW_BOOKINGS_WORK_TEXT}    10s
    Click Element    ${HOW_BOOKINGS_WORK_TEXT}
    #Sleep    5s
Validate if 3 instructions are visible
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'افتح التطبيق في وقت جلستك للاتصال بمدربك.')]    10s
    ${actual_text}=    Get Text    xpath=//div[contains(text(), 'افتح التطبيق في وقت جلستك للاتصال بمدربك.')]
    Should Be Equal    ${actual_text}    ${Expected Inst01}
   # Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'يمكنك إلغاء الحجز في أي وقت دون أي عقوبة قبل بدء الجلسة.')]    10s
    ${actual_text}=    Get Text    xpath=//div[contains(text(), 'يمكنك إلغاء الحجز في أي وقت دون أي عقوبة قبل بدء الجلسة.')]
    Should Be Equal    ${actual_text}    ${Expected Inst02}
    #Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(text(), 'إذا لم يقم المدرب بالرد على المكالمة، فسيتم إعادة الدقائق إلى حسابك.')]    10s
    ${actual_text}=    Get Text    xpath=//div[contains(text(), 'إذا لم يقم المدرب بالرد على المكالمة، فسيتم إعادة الدقائق إلى حسابك.')]
    Should Be Equal    ${actual_text}    ${Expected Inst03}
    #Sleep    2s
    Wait Until Element Is Visible    ${GOT_IT_BUTTON}    10s
    Click Element    ${GOT_IT_BUTTON}
    Close Browser