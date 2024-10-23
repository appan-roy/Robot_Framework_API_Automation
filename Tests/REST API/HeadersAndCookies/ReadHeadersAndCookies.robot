*** Settings ***
Library    RequestsLibrary   
Library    Collections     

*** Variables ***
${baseURI}    http://jsonplaceholder.typicode.com

*** Test Cases ***
Test Headers And Cookies
    Create Session    mySession    ${baseURI}    
    
    ${response}    Get Request    mySession    /photos    
    Log To Console    ${response.content}    
    
    #Validate Headers
    ${res_content_type}    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${res_content_type}    application/json; charset=utf-8
    
    ${res_content_encoding}    Get From Dictionary    ${response.headers}    Content-Encoding
    Should Be Equal    ${res_content_encoding}    gzip
    
    #Log Cookies
    Log To Console    ${response.cookies}    
    ${cookie_value}    Get From Dictionary    ${response.cookies}    __cfduid
    