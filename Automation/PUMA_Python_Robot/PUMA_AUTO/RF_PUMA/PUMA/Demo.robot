*** Settings ***
Library           PUMA_DatabaseLibrary
Library           PUMA_HoldTimeLibrary

*** Test Cases ***
001
    [Tags]    demo    Smoke    Spark
    Log    hello
    HoldTime Get By Accn    123
