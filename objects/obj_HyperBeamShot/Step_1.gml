/// @description 

if (setWave)
{
	isWave = creator.beam_state._is_wave;
	tileCollide = !isWave;
	setWave = false;
}
else
{
	layer = layer_get_id("WorldObjects");
}