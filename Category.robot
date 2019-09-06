*** Settings ***
Documentation     Category testing under Shop Menu
Library           String
Library           Selenium2Library  run_on_failure=Capture Page Screenshot

*** Variables ***
${HomePageURL}      https://www.emersonecologics.com/
${BROWSER}       Chrome
${ShopXpath}  xpath=//*[@id="shopMenuDropdownToggle"]/span/span[1]
${CategoryXpath}  xpath=//ul[@id="mega-menu-shop-by"]/li[2]
${CatSubmenuXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[2]/div/div

${CatNutriSuppliXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[2]/div/div/div[1]/ul/li/a
${CatNutriSuppliListXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[2]/div/div/div[1]/ul/li/ul//li/a

${CatAdditionalXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[2]/div/div/div[2]/div/div/div/div/ul
${CatAdditionalListXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[2]/div/div/div[2]/div/div/div/div/ul/li[1]

${CatNutriSearchBarXpath}  xpath=//*[@id="searchAutocomplete"]
${CatNutriSearchXIconXpath}  xpath=//*[@id="navbar-main"]/search-box/div/div/div/div/ee-autocomplete/div/form/button
${Negativekeyword}  ILoveUSA
${SearchIconXpath}  xpath=//*[@id="searchIconBtn"]

${SearchResultMsgXpath}  xpath=//*[@id="main"]/div/div/div/div[1]/div/h4
${ExpectedKeyword}  Nutritional Supplements

${CatNutriSuppliProd1NavigationXpath}  xpath=//*[@id="main"]/div/div/div/div[3]/div[2]/div/ul/li[1]/div/product-card/div/div/div[1]/div[2]/h3/a
${CatNutriProductPageLoginXpath}  xpath=//*[@id="main"]/div/div[2]/div/div[1]/div[2]/div[2]/div/div[1]/div/div[2]/p/a[1]
${EmailXpath}  xpath=//*[@id="EmailAddress"]
${PasswordXpath}  xpath=//*[@id="Password"]
${SubmitButtnXpath}  xpath=/html/body/div/main/div/form/div[2]/button/span

${forgotpasswrdXpath}  xpath=/html/body/div/main/div/form/div[1]/div[3]/a
${ForgotErrorMsgXpath}  xpath=/html/body/div/main/div/div/p
${ForGotPassEmailXpath}  xpath=//input[@id="EmailAddress"]
${ForgotpassSubmitXpath}  xpath=/html/body/div/main/div/div/form/div[2]/button/span
${ForgotpassErrorMsgXpath}  xpath=/html/body/div/main/div/div[1]/p

${HomePageLogoXpathOnForGotPassPg}  xpath=/html/body/header/div/a/img


*** Test Cases ***
TC_1 Open Broswer
  [Setup]
   Open EmersonEcologics Website in Chrome

TC_Cat_001 & TC_Cat_002: Check for Category submenu to be visible under Shop menu
   Click Shop and Click Category

TC_Cat_004-5: Verify the number of items under Nutritional Suppliments under Category and check if they are clickable
   Click all links and count elements

TC_Cat_008 verify invalid keyword in search icon
   Click Shop and Click Category
   Click Icon  ${CatNutriSuppliXpath}
   Click Icon  ${CatNutriSearchBarXpath}
   Click Icon  ${catnutrisearchxiconxpath}
   Input text  ${CatNutriSearchBarXpath}  ${Negativekeyword}
   Click Icon  ${SearchIconXpath}
   Wait Until Element is Visible  ${SearchResultMsgXpath}
   Element Should Contain    ${SearchResultMsgXpath}  ${ExpectedKeyword}

TC_Cat_007 Verify first item under Category is clickable and navigates to its corresponding page
  Click Shop and Click Category
  Click Icon  ${CatNutriSuppliXpath}
  Click Icon  ${CatNutriSuppliProd1NavigationXpath}
  Click Icon  ${CatNutriProductPageLoginXpath}

TC_Cat_009-10 Verify Login options from Category subitem pages
  Click Icon  ${EmailXpath}
  Input text  ${EmailXpath}   kjfkdsncdsc@gmail.com
  Click Icon  ${PasswordXpath}
  Input Text  ${PasswordXpath}   kjkjk$%%gg&&
  Click Icon  ${SubmitButtnXpath}
  Get HTML Text  ${ForgotErrorMsgXpath}
  click icon  ${forgotpasswrdXpath}
  Click Icon  ${ForgotpassSubmitXpath}
  Get HTML Text  ${ForgotpassErrorMsgXpath}
  Click Icon  ${ForGotPassEmailXpath}
  Input text  ${ForGotPassEmailXpath}   jhsjdhsj@gmail.com
  Click Icon  ${ForgotpassSubmitXpath}
  Get HTML Text  ${ForgotpassErrorMsgXpath}
  Click Icon  ${HomePageLogoXpathOnForGotPassPg}

  [Teardown]  Close Browser

*** Keywords ***
Open EmersonEcologics Website in Chrome
  Open Browser    ${HomePageURL}    ${BROWSER}
  Maximize Browser Window
  Log to console  Website navigated successfully

Click Shop and Click Category
   Wait Until Element is Visible  ${Shopxpath}
   click element  ${Shopxpath}
   Wait Until Element is Visible  ${CategoryXpath}
   click element  ${Categoryxpath}


Click all links and count elements
   Wait Until Element is Visible  ${Catsubmenuxpath}
   ${AllLinksCount}=    Get Element Count    ${Catnutrisupplilistxpath}
   Log    ${AllLinksCount}
   :FOR    ${INDEX}    IN RANGE    1    ${AllLinksCount}
   \    Log    ${INDEX}
   \    ${currUrl}    get location
   \    click element    xpath=(//*[@id="mega-menu-shop-by"]/li[2]/div/div/div[1]/ul/li/ul//li)[${INDEX}]/a
   \    go to    ${currUrl}
   \    Click Shop and Click Category
   END

Click Icon
    [Arguments]  ${Xpath}
    Wait Until Element is Visible  ${Xpath}
    click element  ${Xpath}

Get HTML Text
    [Arguments]  ${body}
    ${text}=  Get Text  ${body}
    Log  ${text}
