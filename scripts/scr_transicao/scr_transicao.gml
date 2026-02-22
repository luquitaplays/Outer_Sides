//transicao
global.transicao = false;

//Chame essa função para criar a transição
function cria_transicao_inicia(_destino = noone)
{
    //falando que a transicao começou
    global.transicao = true;
    
    //se a room n for valida
    if (!room_exists(_destino)) 
    {
        //mostre uma mensagem
        show_message("defina um destino");
        //pode fazer transicao
        global.transicao = false;
        //saia da funçao
        return;
    }
    
    //Criando o objeto transição
    var _transicao = instance_create_depth(0, 0, 0, obj_transicao, 
    { 
        //definindo valor inicial do destino
        destino: _destino
    });
    
}

//Função de transição
function fazendo_transicao(_sq = sq_transicao_1)
{
    //Criando a camada de transição se ela não existe
    if (!layer_exists("transicao"))
    {
        layer_create(-100, "transicao");    
    }
    
    //Pegando a posição da câmera para criar a transição no local correto
    var _cam_x = camera_get_view_x(view_camera[0]);
    var _cam_y = camera_get_view_y(view_camera[0]);
    
    //cria a sequence da transiçao no x e y da minha camera
    layer_sequence_create("transicao", _cam_x, _cam_y, _sq);
}

//Destruindo a sequencia da transição no final dela
function destruindo_layer_transicao()
{
    //se a layer existe
    if (layer_exists("transicao"))
    {
        //destroi ela
        layer_destroy("transicao");
        global.transicao = false;
    }
}