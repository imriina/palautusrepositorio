*** Settings ***
Resource  resource.robot
Suite Setup     Open And Configure Browser
Suite Teardown  Close Browser
Test Setup      Reset Application Create User And Go To Register Page

*** Test Cases ***

Register With Valid Username And Password
    Set Username  santtu
    Set Password  santtu123
    Set Password Confirmation  santtu123
    Submit Credentials
    Register Should Succeed

Register With Too Short Username And Valid Password
    Set Username  sa
    Set Password  santtu123
    Set Password Confirmation  santtu123
    Submit Credentials
    Register Should Fail With Message  Username too short

Register With Valid Username And Too Short Password
    Set Username  santtu
    Set Password  santtu1
    Set Password Confirmation  santtu1
    Submit Credentials
    Register Should Fail With Message  Password too short

Register With Valid Username And Invalid Password
    Set Username  santtu
    Set Password  santtulaa
    Set Password Confirmation  santtulaa
    Submit Credentials
    Register Should Fail With Message  Password can't be only letters

Register With Nonmatching Password And Password Confirmation
    Set Username  santtu
    Set Password  santtu123
    Set Password Confirmation  santtu124
    Submit Credentials
    Register Should Fail With Message  Passwords don't match

Register With Username That Is Already In Use
    Set Username  kalle
    Set Password  kalle123
    Set Password Confirmation  kalle123
    Submit Credentials
    Register Should Fail With Message  User with username kalle already exists

*** Keywords ***

Register Should Fail With Message
    [Arguments]  ${message}
    Register Page Should Be Open
    Page Should Contain  ${message}    

Register Should Succeed
    Welcome Page Should Be Open

Reset Application Create User And Go To Register Page
    Reset Application
    Create User  kalle  kalle123
    Go To Register Page

Submit Credentials
    Click Button  Register

Set Username
    [Arguments]  ${username}
    Input Text  username  ${username}

Set Password
    [Arguments]  ${password}
    Input Password  password  ${password}

Set Password Confirmation
    [Arguments]  ${password}
    Input Password  password_confirmation  ${password}

Login With Correct Credentials
    Set Username  santtu
    Set Password  santtu123
    Click Button  Login

