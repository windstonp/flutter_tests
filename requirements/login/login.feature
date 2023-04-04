Feature: Login
Como cliente quero poder acessar minha conta e me manter logado.
para que eu possa responder enquetes de forma rapida.

Cenario: Credenciais validas
Dado que o cliente informou Credenciais validas
Quando solicitar para fazer o Login
Entao o sistema deve enviar o usuario para a tela de pesquisas
E manter o usuario conectado

Cenario: Credenciais invalidas
Dado que o cliente informou Credenciais invalidas
Quando solicitar para fazer o Login
Entao o sistema deve retornar uma mensagem de erro