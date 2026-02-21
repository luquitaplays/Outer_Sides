//se a potencia for maior que 0.1(quaze zero)
if (treme > 0.1)
{
	//setando variaveis para variar varias vezes o treme
	var _x = random_range(-treme, treme);
	var _y = random_range(-treme, treme);
	
	//setando o ponto de visao do jogador como as variaveis do treme
	view_set_xport(view_current, _x);
	view_set_yport(view_current, _y);
}
else //se ele chegou perto de zero
{
	//garantindo que agora ele e zero
	treme = 0;
	
	//garantindo que meu ponto de visao tmb e zero(ou seja normal)
	view_set_xport(view_current, treme);
	view_set_yport(view_current, treme);
}
//diminuindo aos poucos a variavel
treme = lerp(treme, 0, 0.1);