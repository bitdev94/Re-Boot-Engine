/// @description Initialize
event_inherited();

itemName = "grappleBeam";
itemID = 0;

itemHeader = "GRAPPLE BEAM";
itemDesc = "Select ${hudIcon_3} and press ${shootButton} to fire a Grapple Beam.";

CollectItem = function()
{
	if (instance_exists(obj_Player))
	{
		items_enable(obj_Player.items_state, Item.Grapple)
		items_activate(obj_Player.items_state, Item.Grapple)
		items_add_more(obj_Player.items_state, Item.Grapple, 1)
	}
}