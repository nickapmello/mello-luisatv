*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL_LOGIN}     http://localhost:8000/home.html
${URL_LOJA}      http://localhost:8000/loja.html
${BROWSER}       Chrome
${ARGS}          --headless --disable-gpu --no-sandbox --disable-dev-shm-usage --user-data-dir=/tmp/chrome-profile

*** Test Cases ***

Login com Sucesso e Acesso à Loja
    Open Browser    ${URL_LOGIN}    ${BROWSER}    chrome_options=${ARGS}
    Input Text      id=campoUsuario    admin
    Input Text      id=campoSenha      1234
    Click Button    xpath=//button[@type='submit']
    Wait Until Location Is    ${URL_LOJA}
    Page Should Contain Element    id=listaProdutos
    Close Browser

Adicionar Item e Finalizar Compra
    Open Browser    ${URL_LOGIN}    ${BROWSER}    chrome_options=${ARGS}
    Input Text      id=campoUsuario    admin
    Input Text      id=campoSenha      1234
    Click Button    xpath=//button[@type='submit']
    Wait Until Location Is    ${URL_LOJA}
    Click Button    xpath=//button[contains(text(),'Colocar no carrinho')]
    Click Button    xpath=//button[contains(text(),'Finalizar')]
    Close Browser

Finalizar Compra com Carrinho Vazio
    Open Browser    ${URL_LOGIN}    ${BROWSER}    chrome_options=${ARGS}
    Input Text      id=campoUsuario    admin
    Input Text      id=campoSenha      1234
    Click Button    xpath=//button[@type='submit']
    Wait Until Location Is    ${URL_LOJA}
    Click Button    xpath=//button[contains(text(),'Limpar')]
    Click Button    xpath=//button[contains(text(),'Finalizar')]
    Close Browser
