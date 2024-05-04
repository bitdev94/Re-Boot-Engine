/// @description Initialize
event_inherited();

itemName = "superMissileTank";
itemID = 0;

sMissileAmount = 5;

itemHeader = "SUPER MISSILE";
//itemDesc = "Select it and press [Shoot]";
itemDesc = "Select ${hudIcon_1} and press ${shootButton} to fire a Super Missile.";
expanHeader = "SUPER MISSILE EXPANSION";
expanDesc = "+"+string(sMissileAmount)+" Super Missile Capacity";

CollectItem = function()
{
	if (instance_exists(obj_Player))
	{
		isExpansion = (items_is_enabled(obj_Player.items_state, Item.SMissile));
		items_enable(obj_Player.items_state, Item.SMissile)
		items_activate(obj_Player.items_state, Item.SMissile)
		obj_Player.superMissileMax += sMissileAmount;
		obj_Player.superMissileStat += sMissileAmount;
	}
}