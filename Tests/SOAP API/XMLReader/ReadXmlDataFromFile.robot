*** Settings ***
Library    XML    
Library    OperatingSystem    
Library    Collections    

*** Test Cases ***
Read Xml Data From File
    #parse xml file
    ${xml_object}    Parse Xml    ./XML Files/Employees.xml
    
    #Validations
    #Single Element Value - Approach 1    
    ${emp_firstname}    Get Element Text    ${xml_object}    .//employee[1]/firstname
    Log To Console     ${emp_firstname}    
    Should Be Equal    ${emp_firstname}    Ayshee
    
    #Single Element Value - Approach 2    
    ${emp_firstname}    Get Element    ${xml_object}    .//employee[2]/firstname
    Log To Console     ${emp_firstname.text}    
    Should Be Equal    ${emp_firstname.text}    Pousali
    
    #Single Element Value - Approach 3    
    Element Text Should Be    ${xml_object}    Annwesha    .//employee[3]/firstname
    
    #Check number of elements
    ${count}    Get Element Count    ${xml_object}    .//employee
    Should Be Equal As Integers    ${count}    5    
    
    #Check attubute present
    Element Attribute Should Be    ${xml_object}    id    444444    .//employee[4]    
    
    #Check values of child elements
    ${child_elements}    Get Child Elements    ${xml_object}    .//employee[5]    
    Should Not Be Empty    ${child_elements}    
    ${fname}    Get Element Text    ${child_elements[0]}    
    ${room}    Get Element Text    ${child_elements[5]}
    Log To Console    ${fname}    
    Log To Console    ${room}
    Should Be Equal    ${fname}    Shreyasee
    Should Be Equal As Numbers    ${room}    07        
    