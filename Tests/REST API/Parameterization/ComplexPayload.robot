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
    ${id}    Convert To Integer    ${id}
    ${mobile}    Convert To Integer    ${mobile}    
    ${req_body}     Create Dictionary    firstName=${fname}    lastName=${lname}    mobileNo=${mobile}    id=${id}    subjects=@{subjects}
    ${req_header}    Create Dictionary    Content-Type=application/json

    #POST call
    ${response}    Post Request    mySession    /students    data=${req_body}    headers=${req_header}
    
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
    ${id}    Convert To String    ${id}
    ${mobile}    Convert To String    ${mobile}
    Should Contain    ${res_body}    ${fname}
    Should Contain    ${res_body}    ${lname}
    Should Contain    ${res_body}    ${mobile}
    Should Contain    ${res_body}    ${id}
    Should Contain    ${res_body}    @{subjects}[0]    @{subjects}[1]    @{subjects}[2]
    
    #convert to json
    ${json_object}    To Json    ${response.content}
    
    # #validate response data   
    ${first_name}    Get Value From Json    ${json_object}    $.firstName       
    Should Be Equal    ${first_name[0]}    ${fname}
    
    ${last_name}    Get Value From Json    ${json_object}    $.lastName   
    Should Be Equal    ${last_name[0]}    ${lname} 
    
    ${mobile_no}    Get Value From Json    ${json_object}    $.mobileNo   
    Should Be Equal As Integers    ${mobile_no[0]}    ${mobile}
    
    ${id_num}    Get Value From Json    ${json_object}    $.id   
    Should Be Equal As Integers    ${id_num[0]}    ${id}
    
    ${subjects_list}    Get Value From Json    ${json_object}    $.subjects
    
    ${subject1}    Set Variable    ${subjects_list[0][0]}
    ${subject2}    Set Variable    ${subjects_list[0][1]}
    ${subject3}    Set Variable    ${subjects_list[0][2]}
    
    ${firstSubject}    Set Variable    @{subjects}[0]
    ${secondSubject}    Set Variable    @{subjects}[1]
    ${thirdSubject}    Set Variable    @{subjects}[2]  
      
    Should Be Equal    ${subject1}    ${firstSubject}
    Should Be Equal    ${subject1}    ${firstSubject}
    Should Be Equal    ${subject1}    ${firstSubject}    
    