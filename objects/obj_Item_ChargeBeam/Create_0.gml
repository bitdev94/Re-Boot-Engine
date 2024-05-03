/// @description Initialize
event_inherited();

itemName = "chargeBeam";
itemID = 0;

itemHeader = "CHARGE BEAM";
itemDesc = "Hold ${shootButton} to charge your beam\n"+"and release to fire a charge shot.";

CollectItem = function()
{
	if(instance_exists(obj_Player))
	{
		beam_enable(obj_Player.beam_state, Beam.Charge)
		beam_activate(obj_Player.beam_state, Beam.Charge)
	}
}