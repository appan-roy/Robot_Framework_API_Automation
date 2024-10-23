*** Settings ***
Library    RequestsLibrary   
Library    Collections     
Library    JSONLibrary    
Resource    ../../../Test Data/PayloadData.robot

*** Variables ***
${base_URI}    http://localhost:3000

*** Test Cases ***
CreateUser
    #create session before the call 
    Create Session    mySession    ${base_URI}
    
    #prepare request body
    ${fideRating}    Convert To Integer    ${fideRating}    
    ${req_body}     Create Dictionary    firstName=${firstName}    lastName=${lastName}    fideRating=${fideRating}    
    ${req_header}    Create Dictionary    Content-Type=application/json

    #POST call
    ${response}    Post Request    mySession    /users    data=${req_body}    headers=${req_header}
    
    #log response info
    Log To Console    ${response.status_code}
    Log To Console    ${response.headers}
    Log To Console    ${response.content}       
    
    #validate status code
    ${res_status_code}    Convert To String    ${response.status_code}    
    Should Be Equal    ${res_status_code}    201    
    
    #validate header
    ${res_content_type}    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${res_content_type}    application/json; charset=utf-8    
    
    #validate response body
    ${res_body}    Convert To String    ${response.content}
    ${fideRating}    Convert To String    ${fideRating}
    Should Contain    ${res_body}    ${firstName}
    Should Contain    ${res_body}    ${lastName}
    Should Contain    ${res_body}    ${fideRating}
    
    #convert to json
    ${json_object}    To Json    ${response.content}
    
    #validate response data
    ${first_name}    Get Value From Json    ${json_object}    $.firstName   
    Should Be Equal    ${first_name[0]}    ${firstName[0]}
    
    ${last_name}    Get Value From Json    ${json_object}    $.lastName   
    Should Be Equal    ${last_name[0]}    ${lastName[0]} 
    
    ${fide_rating}    Get Value From Json    ${json_object}    $.fideRating   
    Should Be Equal    ${fide_rating[0]}    ${fideRating[0]}
    