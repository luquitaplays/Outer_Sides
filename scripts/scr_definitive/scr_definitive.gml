//variaveis

global.room_atual = rm_reception;

//funçoes
function end_animation(_num = image_number)
{
    //se a animaçao chegar no fim troca para a animaçao do meio
    var _intervalo = sprite_get_speed(sprite_index) / 60;
    //isso verifica se o proximo quadro passa do image number
    if (image_index + _intervalo >= _num)
    {
        //animation end = true
        return true;
    }
    else 
    {
        //animation end = false
    	return false;
    }
}

//atualizando arrays
function atualiza_colisao(array, objeto, adicionar_ou_nao)
{
    if (adicionar_ou_nao)
    {
        //se n tem ainda
        if (!array_contains(array, objeto))
        {
            //adiciona
            array_push(array, objeto);
        }
    }
    else 
    {
        //se tem 
        if (array_contains(array, objeto))
        {
            //deleta
            array_delete(array, array_get_index(array, objeto), 1);
        }
    }
    
    //faz retornar o array novo
    return array;
}


//sistema de save para o best score
function salvar_jogo()
{
    //criando dados
    var _struct =
    {
        room_atual : global.room_atual
    };
    
    //cria buffer
    var _buff = buffer_create(0, buffer_grow, 1);
    
    //converte a struct em uma string
    var _global = json_stringify(_struct);
    
    //adiciona a string no buffer
    buffer_write(_buff, buffer_string, _global);
    
    //salva o buffer
    buffer_save(_buff, "Save.json");
    
    //deleta o buffer
    buffer_delete(_buff);
}

//sistema de carregar jogo
function carregar_jogo()
{
    //se o arquivo n existe sai.
    if (!file_exists("Save.json")) return;
    
    //arquivo em um buffer
    var _new_buff = buffer_load("Save.json");
    
    //buffer em uma string
    var _string_struct = buffer_read(_new_buff, buffer_string);
    
    //string em stuct
    var _new_stuct = json_parse(_string_struct);
    
    //salvando na variavel
    global.room_atual = _new_stuct.room_atual;
    
    //deletando buff
    buffer_delete(_new_buff);
}