//funçao para tremer a tela
function treme_a_tela(_treme = 20)
{
	//se o obj treme tela nao existir saia do evento
	if (!instance_exists(obj_treme_tela)) return;
	obj_treme_tela.treme = _treme;
	//dentro do obj treme tela
	with (obj_treme_tela)
	{
		//se o meu treme atual for maior que o treme antigo
		if (_treme > treme)
		{
			//o novo treme é o atual
			treme = _treme
		}
	}
}