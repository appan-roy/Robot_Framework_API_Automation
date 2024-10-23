*** Settings ***
Library    JSONLibrary    
Library    OperatingSystem    
Library    Collections    

*** Test Cases ***
Read Json Data From File
    #parse json file
    ${json_object}    Load JSON From File    ./JSON Files/db.json
    
    #get student data
    ${students_fname}    Get Value From Json    ${json_object}    $.students[2].firstName
    Log To Console    ${students_fname[0]}
        
    ${students_lname}    Get Value From Json    ${json_object}    $.students[2].lastName
    Log To Console    ${students_lname[0]}
    
    ${subjects}    Get Value From Json    ${json_object}    $.students[2].subjects
    ${subject1}    Set Variable    ${subjects[0][0]}
    Log To Console    ${subject1}
    ${subject2}    Set Variable    ${subjects[0][1]}
    Log To Console    ${subject2}
    ${subject3}    Set Variable    ${subjects[0][2]}
    Log To Console    ${subject3}    
    
    #validation
    Should Be Equal    ${students_fname[0]}    Divyangana    
    Should Be Equal    ${students_lname[0]}    Sarkar
    Should Be Equal    ${subject1}    Chemistry
    Should Be Equal    ${subject2}    Biology
    Should Be Equal    ${subject3}    Maths
        