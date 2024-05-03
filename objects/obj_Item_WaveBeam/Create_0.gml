/// @description Initialize
event_inherited();

itemName = "waveBeam";
itemID = 0;

itemHeader = "WAVE BEAM";
itemDesc = "Your beam now passes through walls.";

CollectItem = function() {
	if (instance_exists(obj_Player))
	{
		beam_enable(obj_Player.beam_state, Beam.Wave)
		beam_activate(obj_Player.beam_state, Beam.Wave)
	}
}