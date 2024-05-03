/// @description Initialize
event_inherited();

itemName = "plasmaBeam";
itemID = 0;

itemHeader = "PLASMA BEAM";
itemDesc = "Your beam now pierces enemies.";

CollectItem = function()
{
	if(instance_exists(obj_Player))
	{
		beam_enable(obj_Player.beam_state, Beam.Plasma)
		beam_activate(obj_Player.beam_state, Beam.Plasma)
	}
}