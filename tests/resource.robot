*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    OperatingSystem


*** Variables ***
${APP_URL}          http://localhost:5000
${EXPECTED_BACKGROUND_COLOR}    rgb(255, 240, 255)
${EXPECTED_YEAR}    2024
${EXPECTED_SECRET_CONTENT}    42
${BROWSER}        Chrome

*** Keywords ***
Verify Home Page Loads
    Open Browser    ${APP_URL}    ${BROWSER}
    Page Should Contain Element    xpath=//h1[contains(text(),'My Flask App')]
    Close Browser

Verify Background Color Is Default
    Open Browser    ${APP_URL}    ${BROWSER}
    ${background_color}=    Execute Javascript    return document.body.style.backgroundColor
    Should Be Equal As Strings    ${background_color}    ${EXPECTED_BACKGROUND_COLOR}
    Close Browser

Verify System Year Is Correct
    ${output}=    Run    date
    Should Contain  ${output}  ${EXPECTED_YEAR} 

Verify Secret File Contents
    ${response}=    GET    ${APP_URL}/api/file/secret
    Should Be Equal As Strings    ${response.json()['content']}    ${EXPECTED_SECRET_CONTENT}

No Error In Logs
    ${output}=    Run    tail flask_app/app.log | grep Error
    Should Be Empty     ${output}