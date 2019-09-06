*** Settings ***
Documentation     Brand testing under Shop Menu
Library           Selenium2Library  run_on_failure=Capture Page Screenshot

*** Variables ***
${HomePageURL}      https://www.emersonecologics.com/
${BROWSER}       Chrome
${shopXpath}   xpath=//*[@id="shopMenuDropdownToggle"]/span/span[1]
${BrandXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[3]
${BrandSubmenuXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[3]/a
${BrandSubmenuItemsXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[3]/div/div/div/div[1]/div/div/div[2]/p/a/span
${BrandSubmenuItemXpathIndexLeftPortion}  //*[@id="mega-menu-shop-by"]/li[3]/div/div/div/div[1]/div
${BrandSubmenuItemXpathIndexRightPortion}  /div/div[2]/p/a/span
${Brand1LogoXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[3]/div/div/div/div[1]/div[1]/div/div[1]/img
${Brand1ShopIconXpath}  xpath=//*[@id="mega-menu-shop-by"]/li[3]/div/div/div/div[1]/div[1]/div/div[2]/p/a/span

${Brand1ProductNavigationXpath}  xpath=//*[@id="main"]/div/div/div/div[3]/div[2]/div/ul/li[1]/div/product-card/div/div/div[1]/div[2]/h3/a
${BrandProductLoginXpath}  xpath=//*[@id="main"]/div/div[2]/div/div[1]/div[2]/div[2]/div/div[1]/div/div[2]/p/a[1]
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

TC_Br_001 & TC_Br_002: Check for Category submenu to be visible under Shop menu
  Click Shop and Click Brand

TC_Br_004 & TC_Br_006: Verify the number of Shop icon items under Brand and check if they are clickable
  Click all links and count elements  ${BrandXpath}  ${brandsubmenuitemxpathindexleftportion}  ${BrandSubmenuItemXpathIndexRightPortion}

TC_Br_007 Verify Content Image
  Click Shop and Click Brand
  Page should contain image  ${Brand1LogoXpath}

TC_Br_007 Verify first item under first shop Brand is clickable and navigates to its corresponding page
  Click Shop and Click Brand
  Click Icon  ${Brand1ShopIconXpath}
  Click Icon  ${Brand1ProductNavigationXpath}
  Click Icon  ${BrandProductLoginXpath}

TC_Br_008-12 Verify Login options from Brand subitem pages
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

Click Shop and Click Brand
   Wait Until Element is Visible  ${Shopxpath}
   click element  ${Shopxpath}
   Wait Until Element is Visible  ${BrandXpath}
   click element  ${BrandXpath}

Click all links and count elements
   [Arguments]  ${xpath1}  ${xpath2}  ${xpath3}
   Wait Until Element is Visible  ${xpath1}
   ${AllLinksCount}=    Get Element Count    ${BrandSubmenuItemsXpath}
   Log    ${AllLinksCount}
   :FOR    ${INDEX}    IN RANGE    1    ${AllLinksCount}
   \    Log    ${INDEX}
   \    ${currUrl}    get location
   \    click element    xpath=(${xpath2})[${INDEX}]${xpath3}
   \    go to    ${currUrl}
   \    Click Shop and Click Brand
   END

Click Icon
    [Arguments]  ${Xpath}
    Wait Until Element is Visible  ${Xpath}
    click element  ${Xpath}

Get HTML Text
    [Arguments]  ${body}
    ${text}=  Get Text  ${body}
    Log  ${text}

