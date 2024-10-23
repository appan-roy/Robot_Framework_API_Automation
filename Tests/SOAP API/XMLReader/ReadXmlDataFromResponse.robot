*** Settings ***
Library    RequestsLibrary    
Library    Collections  
Library    XML    
Library    OperatingSystem     

*** Variables ***
${baseURI}    https://certtransaction.elementexpress.com

*** Test Cases ***
Read Xml Data From Response
    Create Session    mySession    ${baseURI}    
    
    ${response}    Get Request    mySession    /
    ${res_body}    Convert To String    ${response.content}
    ${xml_object}    Parse Xml    ${res_body}    
    
    #Check Single Element Value
    ${child_elements}    Get Child Elements    ${xml_object}    
    Should Not Be Empty    ${child_elements}    
    
    ${exp_res_code}    Get Element Text    ${child_elements[0][0]}
    Should Be Equal    ${exp_res_code}    103
    
    ${exp_res_msg}    Get Element Text    ${child_elements[0][1]}
    Should Be Equal    ${exp_res_msg}    Invalid Request    
    