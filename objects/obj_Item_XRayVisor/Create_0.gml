/// @description Initialize
event_inherited();

itemName = "xRayVisor";
itemID = 0;

itemHeader = "X-RAY VISOR";
itemDesc = "Select ${hudIcon_4} and hold ${dashButton} to activate." + "\n" + "Reveals destroyable blocks and hidden pathways.";

CollectItem = function()
{
	if (instance_exists(obj_Player))
	{
		items_enable(obj_Player.items_state, Item.XRay)
		items_activate(obj_Player.items_state, Item.XRay)
		items_add_more(obj_Player.items_state, Item.Grapple, 1)
	}
}