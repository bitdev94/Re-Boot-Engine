/// @description Initialize
event_inherited();

itemName = "missileTank";
itemID = 0;

missileAmount = 5;

itemHeader = "MISSILE";
//itemDesc = "Select it and press [Shoot]";
itemDesc = "Select ${hudIcon_0} and press ${shootButton} to fire a Missile.";
expanHeader = "MISSILE EXPANSION";
expanDesc = "+"+string(missileAmount)+" Missile Capacity";

CollectItem = function()
{
	if (instance_exists(obj_Player))
	{
		isExpansion = (items_is_enabled(obj_Player.items_state, Item.Missile));
		items_enable(obj_Player.items_state, Item.Missile)
		items_activate(obj_Player.items_state, Item.Missile)
		items_add_more(obj_Player.items_state, Item.Missile, missileAmount)
	}
}