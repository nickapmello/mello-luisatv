*** Settings ***
Documentation     Teste automatizado do fluxo de login e compra
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Abrir Navegador
Suite Teardown    Encerrar Sessao
Test Setup        Fazer Login e Ir Para a Loja

*** Variables ***
${URL_LOGIN}      http://localhost:8000/home.html
${URL_LOJA}       http://localhost:8000/loja.html
${BROWSER}        Chrome

*** Keywords ***
Abrir Navegador
    ${RANDOM_DIR}=    Evaluate    "/tmp/chrome-profile-%d" % __import__('random').randint(1000,9999)    # Apenas um diretório por execução
    ${ARGS}=          Set Variable    --headless --no-sandbox --disable-dev-shm-usage --user-data-dir=${RANDOM_DIR}
    Open Browser      ${URL_LOGIN}    ${BROWSER}    chrome_options=${ARGS}
    Maximize Browser Window

Fazer Login e Ir Para a Loja
    Go To             ${URL_LOGIN}
    Input Text        id=campoUsuario      admin
    Input Text        id=campoSenha        1234
    Click Button      xpath=//button[@type='submit']
    Wait Until Location Is    ${URL_LOJA}
    Page Should Contain Element    id=listaProdutos

Encerrar Sessao
    Close Browser

*** Test Cases ***
Adicionar Item e Finalizar Compra
    Click Button      xpath=//button[contains(text(),'Colocar no carrinho')]
    Click Button      xpath=//button[contains(text(),'Finalizar')]
    # Adicione uma verificação de sucesso aqui, se aplicável
    Page Should Contain    Compra finalizada com sucesso    # Exemplo de verificação

Finalizar Compra com Carrinho Vazio
    Click Button      xpath=//button[contains(text(),'Limpar')]
    Click Button      xpath=//button[contains(text(),'Finalizar')]
    # Adicione uma verificação de erro/alerta aqui
    Page Should Contain    Seu carrinho está vazio    # Exemplo de verificação