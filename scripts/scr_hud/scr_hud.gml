// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum HUD {
	BEAMS,
	ITEMS,
	SIZE
}

function PlayerHud(): Debugger() constructor {
	_tag = "PlayerHud"
	_selected = 0
	_beam = Beam.Charge
	_item = Item.Missile
}

function hud_reset(_hud) {
	hud_reset_beam(_hud)
	hud_reset_item(_hud)
}
/// @func hud_reset_beam(_hud)
/// @param {Struct.PlayerHud} _hud
function hud_reset_beam(_hud) {
	_hud._beam = Beam.Charge
}

function hud_reset_item(_hud) {
	_hud._item = Item.Missile
}


function hud_next_selection(_hud) {
	_hud._selected = (_hud._selected + 1) % HUD.SIZE
}

function hud_goto_next(_hud) {
	if (_hud._selected == HUD.BEAMS)
		hud_next_selection(_hud)
	else
		hud_highlight_next_item(_hud)
}

/// @func hud_get_highlighted_beam(_hud)
/// @param {Struct.PlayerHud} _hud
function hud_get_highlighted_beam(_hud) {
	return _hud._beam
}

function hud_have_projectile_item_highlighted(_hud) {
	return _hud._selected == HUD.ITEMS && (_hud._item == Item.Missile || _hud._item == Item.SMissile || _hud._item == Item.Grapple)
}

function hud_have_missile_highlighted(_hud) {
	return (_hud._item == Item.Missile || _hud._item == Item.SMissile)
}

function hud_have_missile_selected(_hud) {
	return _hud._selected == HUD.ITEMS && (_hud._item == Item.Missile || _hud._item == Item.SMissile)
}


function hud_is_item_highlighted(_hud, _item) {
	return  _hud._item == _item
}

function hud_is_item_selected(_hud, _item) {
	return _hud._selected == HUD.ITEMS && _hud._item == _item
}


function hud_is_beam_highlighted(_hud, _beam) {
	return _hud._beam == wrap(_beam, 0, Beam.SIZE)
}

function hud_highlight_next_item(_hud) {
	_hud._item = (_hud.item + 1) % Item.SIZE
}

function hud_is_last_item(_hud) {
	return _hud._item + 1 == Item.SIZE
}

function hud_find_active_beam(_hud, _start = Beam.Ice, _end = Beam.SIZE) {
	return scr_wrap(_hud._beam, _start, _end)
}


function hud_find_active_item(_hud, _start = Item.Missile, _end = Item.SIZE) {
	return scr_wrap(_hud._item, _start, _end)
}

function hud_rectify(_hud) {
	_hud._beam = scr_wrap(_hud._beam, 0, Beam.SIZE)
	_hud._item = scr_wrap(_hud._item, 0, Item.SIZE)
}

#region To Improve
// TODO: Change this logic where it is used if possible
function hud_increment_item(_hud, _increment) {
	_hud._item = (_hud._item + _increment) % Item.SIZE
}

function hud_increment_beam(_hud, _increment) {
	_hud._beam = (_hud._beam + _increment) % Beam.SIZE
}

function hud_increment_selected(_hud, _increment) {
	log_info(_hud, _increment)
	switch (_hud._selected) {
		case HUD.BEAMS:
			hud_increment_beam(_hud, _increment)
		break;
		case HUD.ITEMS:
			hud_increment_item(_hud, _increment)
		break;
	}		
}
#endregion // To Improve
