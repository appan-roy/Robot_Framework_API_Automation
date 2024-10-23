*** Settings ***
Library    RequestsLibrary   
Library    Collections     
Library    JSONLibrary    

*** Variables ***
${base_URI}    http://localhost:3000
${expectedFirstName}    Divyangana
${expectedLastName}    Sarkar
${fide_rating}    1648

*** Test Cases ***
Validate Request Response Chaining
    #create session before the call
    Create Session    mySession    ${base_URI}
    
    #REQUEST 1
    #GET call
    ${GET_response}    Get Request    mySession    /students/3      
    
    #validate status code
    ${res_status_code}    Convert To String    ${GET_response.status_code}    
    Should Be Equal    ${res_status_code}    200    
    
    #validate header
    ${res_content_type}    Get From Dictionary    ${GET_response.headers}    Content-Type
    Should Be Equal    ${res_content_type}    application/json; charset=utf-8    
    
    #validate response body
    ${res_body}    Convert To String    ${GET_response.content}
    Should Contain    ${res_body}    ${expectedFirstName}
    Should Contain    ${res_body}    ${expectedLastName}
    
    #convert to json
    ${json_object_GET}    To Json    ${GET_response.content}
    
    #validate response data   
    ${first_name}    Get Value From Json    ${json_object_GET}    $.firstName       
    Should Be Equal    ${first_name[0]}    ${expectedFirstName}
    
    ${last_name}    Get Value From Json    ${json_object_GET}    $.lastName   
    Should Be Equal    ${last_name[0]}    ${expectedLastName} 
    
    #REQUEST 2
    #prepare request body for POST
    ${fide_rating}    Convert To Integer    ${fide_rating}    
    ${req_body}     Create Dictionary    firstName=${first_name[0]}    lastName=${last_name[0]}    fideRating=${fide_rating}    
    ${req_header}    Create Dictionary    Content-Type=application/json
    
    #POST call
    ${POST_response}    Post Request    mySession    /users    data=${req_body}    headers=${req_header}     
    
    #validate status code
    ${res_status_code}    Convert To String    ${POST_response.status_code}    
    Should Be Equal    ${res_status_code}    201    
    
    #validate header
    ${res_content_type}    Get From Dictionary    ${POST_response.headers}    Content-Type
    Should Be Equal    ${res_content_type}    application/json; charset=utf-8    
    
    #validate response body
    ${res_body}    Convert To String    ${POST_response.content}
    ${fide_rating}    Convert To String    ${fide_rating}
    Should Contain    ${res_body}    ${first_name[0]}
    Should Contain    ${res_body}    ${last_name[0]}
    Should Contain    ${res_body}    ${fide_rating[0]}
    
    #convert to json
    ${json_object_POST}    To Json    ${POST_response.content}
    
    #validate response data
    ${firstName}    Get Value From Json    ${json_object_POST}    $.firstName   
    Should Be Equal    ${firstName[0]}    ${first_name[0]}
    
    ${lastName}    Get Value From Json    ${json_object_POST}    $.lastName   
    Should Be Equal    ${lastName[0]}    ${last_name[0]} 
    
    ${fideRating}    Get Value From Json    ${json_object_POST}    $.fideRating   
    Should Be Equal    ${fideRating[0]}    ${fide_rating[0]}
    