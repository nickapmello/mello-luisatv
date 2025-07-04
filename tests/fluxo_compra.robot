*** Settings ***
Documentation     Teste automatizado do fluxo de login e compra
Library           SeleniumLibrary
Library           Collections
Library           OperatingSystem
Library           BuiltIn
Library           String
Library           Process
Library           Random

*** Variables ***
${URL_LOGIN}     http://localhost:8000/home.html
${URL_LOJA}      http://localhost:8000/loja.html
${BROWSER}       Chrome

*** Test Cases ***

Login com Sucesso e Acesso à Loja
    ${RANDOM_DIR}=    Evaluate    "/tmp/chrome-profile-%d" % __import__('random').randint(1000,9999)
    ${ARGS}=    Set Variable    --headless --no-sandbox --disable-dev-shm-usage --user-data-dir=${RANDOM_DIR}
    Open Browser    ${URL_LOGIN}    ${BROWSER}    chrome_options=${ARGS}
    Input Text      id=campoUsuario    admin
    Input Text      id=campoSenha      1234
    Click Button    xpath=//button[@type='submit']
    Wait Until Location Is    ${URL_LOJA}
    Page Should Contain Element    id=listaProdutos
    Close Browser

Adicionar Item e Finalizar Compra
    ${RANDOM_DIR}=    Evaluate    "/tmp/chrome-profile-%d" % __import__('random').randint(1000,9999)
    ${ARGS}=    Set Variable    --headless --no-sandbox --disable-dev-shm-usage --user-data-dir=${RANDOM_DIR}
    Open Browser    ${URL_LOGIN}    ${BROWSER}    chrome_options=${ARGS}
    Input Text      id=campoUsuario    admin
    Input Text      id=campoSenha      1234
    Click Button    xpath=//button[@type='submit']
    Wait Until Location Is    ${URL_LOJA}
    Click Button    xpath=//button[contains(text(),'Colocar no carrinho')]
    Click Button    xpath=//button[contains(text(),'Finalizar')]
    Close Browser

Finalizar Compra com Carrinho Vazio
    ${RANDOM_DIR}=    Evaluate    "/tmp/chrome-profile-%d" % __import__('random').randint(1000,9999)
    ${ARGS}=    Set Variable    --headless --no-sandbox --disable-dev-shm-usage --user-data-dir=${RANDOM_DIR}
    Open Browser    ${URL_LOGIN}    ${BROWSER}    chrome_options=${ARGS}
    Input Text      id=campoUsuario    admin
    Input Text      id=campoSenha      1234
    Click Button    xpath=//button[@type='submit']
    Wait Until Location Is    ${URL_LOJA}
    Click Button    xpath=//button[contains(text(),'Limpar')]
    Click Button    xpath=//button[contains(text(),'Finalizar')]
    Close Browser
