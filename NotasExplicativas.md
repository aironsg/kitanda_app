#Este readme terá por responsabilidade de explicar algumas decisões tomadas na contrução do app

##name dos arquivos.
1- os names dos arquivos foi chamado por padronizanação da regra de negocios do app
Ex: HomeTab,CarrinhoTab,PedidosTab, PerfilTab,  = uma tela que é chamada a partir de um pageview que tem por funcionalidade uma chamada em formato "tab"
isto devido, que a partir da tela BaseScreen, todas as telas que serão chamadas a partir do BottomNavigationBar
terá em sua composição de tela o BottomNavigationBar.

2- Todos as Paginas terão seu diretorio individual dentro do diretorio src, esta tomada de decisão é para
uma forma mais limpa de condensar os arquivos no momento de uma busca.

3- sempre colocar uma nota de comentario definindo o campo
ex: um formulario terá sempre acima o comentario falando que ali encontra-se um formulario
se dentro do formulario tem um FormField de password, acima terá a nota falando que aqui é o campo de password
caso seja um botão, colocar que se refere ao botão especifico.
razão para isto, ficar mais facil de encontrar as funcionalidades do app, para uma possivel alteração.

#Utilização de Packges extras

 1- get: RESPONSAVEL POR GERENCIAMENTO DE ROTAS E ESTADOS
 2- animated_text_kit: RESPONSAVEL POR CRIAR ANIMAÇÕES DE TRANSIÇÕES DE TEXTO(titulo do app)

 3- mask_text_input_formatter: RESPONSAVEL POR FAZER FORMATAÇÕES DE MASCARAS EM CAMPOS DE TEXTO(vede pagina de login e cadastro)
 4- badges: RESPONSAVEL POR COLOCAR EFEITOS EM ICONES
 5- intl: RESPONSAVEL POR FORMATAÇÕES DE VALORES E DATAS E LINGUAS(vede arquivo utilService)
 6- add_to_cart_animation: RESPONSAVEL POR FAZER A ANIMAÇÃO DE LEVAR O ITEM PARA O CARRINHO
 7- qr_flutter: RESPONSAVEL POR CRIAÇÃO DE QR CODE
 8- flutter_launcher_icons: RESPONSAVEL POR COLOCAR ICONS NÃO PADRÕES NO APP (analisar arquivo pubspec.yaml) este package foi responsavel por colocar uma imagem como a logo padrão do app.
 9- shimmer: RESPONSAVEL POR EFEITO DE CARREGAMENTO DE WIDGETS. (vede pagina home)

 anotar sobre o json_serializible, json_anotation e build_runner