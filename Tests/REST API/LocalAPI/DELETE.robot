*** Settings ***
Library    RequestsLibrary   
Library    Collections     

*** Variables ***
${base_URI}    http://localhost:3000

*** Test Cases ***
DeleteUser
    #create session before the call
    Create Session    mySession    ${base_URI}
    
    #DELETE call
    ${response}    Delete Request    mySession    /users/26
    
    #log response info
    Log To Console    ${response.status_code}
    Log To Console    ${response.headers}
    Log To Console    ${response.content}       
    
    #validate status code
    ${res_status_code}    Convert To String    ${response.status_code}    
    Should Be Equal    ${res_status_code}    200    

    