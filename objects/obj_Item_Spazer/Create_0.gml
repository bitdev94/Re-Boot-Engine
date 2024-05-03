/// @description Initialize
event_inherited();

itemName = "spazer";
itemID = 0;

itemHeader = "SPAZER";
itemDesc = "Fire 3 beams at once.";

CollectItem = function()
{
	if (instance_exists(obj_Player))
	{
		beam_enable(obj_Player.beam_state, Beam.Spazer)
		beam_activate(obj_Player.beam_state, Beam.Spazer)
	}
}