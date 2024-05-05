/// @description Initialize
event_inherited();

stationMessage = "AMMO REPLENISHED";

Condition = function()
{
	var p = obj_Player;
	return (!items_is_maximazed(p.items_state, Item.Missile) || 
			!items_is_maximazed(p.items_state, Item.SMissile) || 
			!items_is_maximazed(p.items_state, Item.PBomb));
}
Interact = function()
{
	var p = obj_Player;
	items_amount_iterate_with_max_value(p.items_state, Item.Missile, 0.25, 1)
	items_amount_iterate_with_max_value(p.items_state, Item.SMissile, 0.25, 1)
	items_amount_iterate_with_max_value(p.items_state, Item.PBomb, 0.25, 1)
}