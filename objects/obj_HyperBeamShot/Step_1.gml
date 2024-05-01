/// @description 

if(setWave)
{
	//isWave = creator.beam[Beam.Wave];
	isWave = creator.beam_state.is_wave;
	tileCollide = !isWave;
	setWave = false;
}
else
{
	layer = layer_get_id("WorldObjects");
}