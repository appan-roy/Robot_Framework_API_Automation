*** Settings ***
Library    RequestsLibrary   
Library    Collections     

*** Variables ***
${base_URI}    http://localhost:3000
${fideRating}    2579

*** Test Cases ***
PartialUpdateUser
    #create session before the call 
    Create Session    mySession    ${base_URI}
    
    #prepare request body
    ${fideRating}    Convert To Integer    ${fideRating}    
    ${req_body}     Create Dictionary    fideRating=${fideRating}    
    ${req_header}    Create Dictionary    Content-Type=application/json

    #PATCH call
    ${response}    Patch Request    mySession    /users/26    data=${req_body}    headers=${req_header}
    
    #log response info
    Log To Console    ${response.status_code}
    Log To Console    ${response.headers}
    Log To Console    ${response.content}       
    
    #validate status code
    ${res_status_code}    Convert To String    ${response.status_code}    
    Should Be Equal    ${res_status_code}    200    
    
    #validate header
    ${res_content_type}    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${res_content_type}    application/json; charset=utf-8    
    
    #validate response body
    ${res_body}    Convert To String    ${response.content}
    ${fideRating}    Convert To String    ${fideRating}
    Should Contain    ${res_body}    ${fideRating}
    