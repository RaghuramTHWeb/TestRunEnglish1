*** Settings ***
Library    SikuliLibrary

*** Test Cases ***
Compare Figma Image With Web UI
    Open Application    chrome.exe    https://your-webpage.com
    Capture Region    web_screenshot.png    100    200    300    400
    Compare Images    figma_reference.png    web_screenshot.png
