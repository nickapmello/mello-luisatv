// Função chamada no login
function autenticarUsuario() {
  const usuario = document.getElementById('campoUsuario').value;
  const senha = document.getElementById('campoSenha').value;

  if (usuario === 'admin' && senha === '1234') {
    localStorage.setItem('autenticado', 'sim');
    window.location.href = 'loja.html';
  } else {
    alert('Usuário ou senha inválidos!');
  }
  return false;
}

// Funções executadas ao carregar a loja
window.onload = () => {
  if (window.location.pathname.includes('loja.html')) {
    const produtos = ['Teclado Gamer', 'Fone Bluetooth'];
    const listaProdutos = document.getElementById('listaProdutos');
    const listaCarrinho = document.getElementById('listaCarrinho');
    let carrinho = JSON.parse(localStorage.getItem('itensCarrinho') || '[]');

    function atualizarCarrinho() {
      listaCarrinho.innerHTML = '';
      carrinho.forEach(item => {
        const li = document.createElement('li');
        li.textContent = item;
        listaCarrinho.appendChild(li);
      });
    }

    function adicionarItem(nomeProduto) {
      carrinho.push(nomeProduto);
      localStorage.setItem('itensCarrinho', JSON.stringify(carrinho));
      atualizarCarrinho();
    }

    produtos.forEach(nome => {
      const item = document.createElement('li');
      const botao = document.createElement('button');
      botao.textContent = 'Colocar no carrinho';
      botao.onclick = () => adicionarItem(nome);
      item.textContent = nome + ' ';
      item.appendChild(botao);
      listaProdutos.appendChild(item);
    });

    window.esvaziarCarrinho = () => {
      carrinho = [];
      localStorage.removeItem('itensCarrinho');
      atualizarCarrinho();
    };

    window.concluirCompra = () => {
      if (carrinho.length === 0) {
        alert('Adicione produtos antes de finalizar.');
      } else {
        alert('Compra realizada com sucesso!');
        esvaziarCarrinho();
      }
    };

    atualizarCarrinho();
  }
};