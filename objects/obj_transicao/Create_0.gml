//variaveis

//fasendo ela ser criada em todas as rooms
persistent = true;

//Chamando a função que cria a sequence.
fazendo_transicao();

//Definindo o alarme para 30 frames porque a sequencia tem 30 frames
alarm[0] = 30;

//Variável de controle para saber se eu já troquei de level e posso começar a segunda transição
comecar_transicao_2 = false;

//Variável de controle para saber se eu devo deixar a tela totalmente escura
escurecer_tudo = false;