*** Settings ***
Library               OperatingSystem
Library               SchemathesisLibrary    flask_app/swagger.json
Resource              resource.robot

*** Variables ***
&{KWARGS}       base-url=http://127.0.0.1:5000/
...             cassette-path=cassette.yaml
...             hypothesis-max-examples=200
# ...             data-generation-method=negative


*** Test Cases ***
Schemathesis API Fuzz
    ${output}=    Run Fuzzing       &{KWARGS}   
    Create File    report.txt    ${output}
    &{dict}=    Get Failed Interactions
    Set Global Variable    &{FAILED_INT}    &{dict}
    

Schemathesis Replay Failed Testcases
    FOR    ${endpoint}    IN    @{FAILED_INT.keys()}
        FOR    ${id}    IN    @{FAILED_INT["${endpoint}"]}
            Replay Testcase    id=${id}
            Run Keyword And Continue On Failure    Verify Impact
        END 
    END

*** Keywords ***
Verify Impact
    Verify Home Page Loads
    Verify Background Color Is Default
    Verify System Year Is Correct
    Verify Secret File Contents
    No Error In Logs