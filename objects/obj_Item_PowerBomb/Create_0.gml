/// @description Initialize
event_inherited();

itemName = "powerBombTank";
itemID = 0;

pBombAmount = 5;

itemHeader = "POWER BOMB";
//itemDesc = "While Morphed, select it and press [Shoot]";
itemDesc = "Select ${hudIcon_2} and press ${shootButton} to set during [sprt_Text_MiniMorph]";
expanHeader = "POWER BOMB EXPANSION";
expanDesc = "+"+string(pBombAmount)+" Power Bomb Capacity";

CollectItem = function()
{
	if (instance_exists(obj_Player))
	{
		isExpansion = (items_is_enabled(obj_Player.items_state, Item.PBomb));
		items_enable(obj_Player.items_state, Item.PBomb)
		items_activate(obj_Player.items_state, Item.PBomb)
		items_add_more(obj_Player.items_state, Item.PBomb, pBombAmount)
	}
}