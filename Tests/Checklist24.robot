*** Settings ***
Library         SeleniumLibrary
Test Setup          Open the browser and login as consumer
Test Teardown    Close Browser
Resource        resource.robot

*** Test Cases ***
Minutes screen validation
    Sleep    5s
    Wait Until Element Is Visible    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']    10s
    Click Element    xpath://div[@class='MenuBar-module__Menubar--Credit__Label css-0']
    Sleep    5s

