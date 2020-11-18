*** Settings ***
Library           SeleniumLibrary   run_on_failure=Nothing

*** Variables ***
${URL}         https://www.saucedemo.com/
${BROWSER}        Chrome
${DRIVER}         rf-env/WebDriverManager/chrome/86.0.4240.22/chromedriver_win32/chromedriver.exe
${DELAY}          0

*** Test Cases ***
Ostotapahtuma
    Prepare Browser
    Kirjaudu  standard_user   secret_sauce
    Tuote  Jacket
    Ostoskori
    Checkout
    Tiedot
    Lopeta

   



*** Keywords ***
Prepare Browser
    Open Browser    ${URL}  ${BROWSER}  executable_path=${DRIVER}
    Set Selenium Speed  ${DELAY}

Kirjaudu
    [Arguments]  ${username}   ${password}
    Wait Until Page Contains Element   id=user-name
    Input Text  id=user-name    ${username}
    Input Text  id=password     ${password}
    Click Element   id=login-button
    Wait Until Page Contains   Products

Tuote
    [Arguments]  ${product}
    Wait Until Page Contains Element    xpath=//div[@class='inventory_item' and contains(.,'Jacket')]//button
    Click Element   xpath=//div[@class='inventory_item' and contains(.,'${product}')]//button

Ostoskori
    Wait Until Page Contains Element    xpath=//div[@id='shopping_cart_container']//a
    Click Element   xpath=//div[@id='shopping_cart_container']//a

Checkout
    Wait Until Page Contains Element    xpath=//div[@id='cart_contents_container']//a[contains(.,'CHECKOUT')]
    Click Element   xpath=//div[@id='cart_contents_container']//a[contains(.,'CHECKOUT')]

Tiedot
    Wait Until Page Contains Element    id=first-name
    Input Text  id=first-name   Marko
    Input Text  id=last-name    Melkone
    Input Text  id=postal-code  4200
    Submit Form

Lopeta
    Wait Until Page Contains Element    xpath=//div[@id='checkout_summary_container']//a[contains(.,'FINISH')]
    Click Element   xpath=//div[@id='checkout_summary_container']//a[contains(.,'FINISH')]

    

