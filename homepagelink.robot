*** Settings ***
Library           Selenium2Library
Library           Collections

*** Variables ***
${HomePageURL}      https://www.emersonecologics.com/
${BROWSER}       Chrome

*** Test Cases ***
Get All Links
    [Tags]    Links
    Open Browser    ${HomePageURL}    ${BROWSER}
    Maximize Browser Window
    Comment    Count Number Of Linkds on the Page
    ${AllLinksCount}=    Get Element Count    //a
    Comment    Log links count
    Log    ${AllLinksCount}
    Comment    Create a list to store link texts
    @{LinkItems}    Create List
    Comment    Loop through all links and store links value that has length more than 1 character
    : FOR    ${INDEX}    IN RANGE    1    ${AllLinksCount}
    \    Log    ${INDEX}
    \    ${lintext}=    Get Text    xpath=(//a)[${INDEX}]
    \    Log    ${lintext}
    \    ${linklength}    Get Length    ${lintext}
    \    Run Keyword If    ${linklength}>1    Append To List    ${LinkItems}    ${lintext}
    ${LinkSize}=    Get Length    ${LinkItems}
    Log    ${LinkSize}
    Comment    Print all links
    : FOR    ${ELEMENT}    IN    @{LinkItems}
    \    Log    ${ELEMENT}
    Close Browser