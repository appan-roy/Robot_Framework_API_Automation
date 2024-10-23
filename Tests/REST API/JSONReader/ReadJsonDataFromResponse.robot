*** Settings ***
Library    JSONLibrary    
Library    OperatingSystem    
Library    Collections  
Library    RequestsLibrary     

*** Variables ***
${base_URI}    https://restcountries.eu 

*** Test Cases ***
Read Json Data From Response
    #create session before the call
    Create Session    mySession    ${base_URI}
    
    #GET call
    ${response}    Get Request    mySession    /rest/v2/alpha/IN
    
    #convert to json
    ${json_object}    To Json    ${response.content}    
    
    #single data validation
    ${country_name}    Get Value From Json    ${json_object}    $.name
    Log To Console    ${country_name[0]}    
    Should Be Equal    ${country_name[0]}    India    
    
    #single data validation from json array
    ${borders}    Get Value From Json    ${json_object}    $.borders[0]
    Log To Console    ${borders[0]}    
    Should Be Equal    ${borders[0]}    AFG
    
    #multiple data validation from json array
    ${borders}    Get Value From Json    ${json_object}    $.borders
    Log To Console    ${borders[0]}    
    Should Contain    ${borders[0]}    AFG    BGD    BTN    MMR    
    Should Not Contain    ${borders[0]}    BRA    RSA    USA    AUS    
    