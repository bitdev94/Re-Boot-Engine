// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum Item
{
	Missile,
	SMissile,
	PBomb,
	Grapple,
	XRay,
	SIZE
};

#macro _COUNTABLE_ITEMS [Item.Missile, Item.SMissile, Item.PBomb]

function PlayerItems(): Debugger() constructor {
	_tag = "PlayerItems"
	_is_active = array_create(Item.SIZE, false)
	_is_enable = array_create(Item.SIZE, false)
	_amount = array_create(Item.SIZE, 0)
	_max_amount = array_create(Item.SIZE, 0)
}

#region Static Methods
function items_get_countables(_items_state) {
	return _COUNTABLE_ITEMS
}

function items_get_amount_map_tag(_items_state, _index) {
	var _ret = "other"
	switch (_index) {
		case Item.Missile:
			_ret = "missileStat"
		break;
		case Item.SMissile:
			_ret = "superMissileStat"
		break;
		case Item.PBomb:
			_ret = "powerBombStat"
		break;
	}
	return _ret
}

function items_get_max_amount_map_tag(_items_state, _index) {
	var _ret = "max_other"
	switch (_index) {
		case Item.Missile:
			_ret = "missileMax"
		break;
		case Item.SMissile:
			_ret = "superMissileMax"
		break;
		case Item.PBomb:
			_ret = "powerBombMax"
		break;
	}
	return _ret
}

function items_get_limit(_items_state, _item) {
	var _ret = 0
	switch (_item) {
		case Item.Missile:
			_ret = 250
		break;
		case Item.SMissile:
		case Item.PBomb:
			_ret = 50
		break;
		case Item.Grapple:
		case Item.XRay:
			_ret = 1
		break;
	}
	return _ret
}

function items_length(_items_state) {
	return Item.SIZE
}

#endregion // Static Methods

#region Public Methods
function items_is_enabled(_items_state, _index) {
	return _items_state._is_enable[_index]
}

function items_get_enable_list_tag(_items_state, _index) {
	return "Item_" + string(_index)
}

function items_get_enable_map_tag(_items_state, _index) {
	return "hasItem" + string(_index)
}


function items_get_active_map_tag(_items_state, _index) {
	return "item" + string(_index)
}

function items_enable(_items_state, _index) {
	_items_state._is_enable[_index] = true
}

function items_disable(_items_state, _index) {
	_items_state._is_enable[_index] = false
}

function items_enable_set(_items_state, _index, _state) {
	if (_state)
		items_enable(_items_state, _index)
	else
		items_disable(_items_state, _index)
}

function items_activate(_items_state, _index) {
	_items_state._is_active[_index] = true
}

function items_disactivate(_items_state, _index) {
	_items_state._is_active[_index] = false
}

function items_active_set(_items_state, _index, _state) {
	if (_state)
		items_activate(_items_state, _index)
	else
		items_disactivate(_items_state, _index)
}

function items_amount_set(_items_state, _item, _amount) {
	_items_state._amount[_item] = _amount
}

function items_max_amount_set(_items_state, _item, _max_amount) {
	_items_state._max_amount[_item] = _max_amount
}

function items_amount_get(_items_state, _item) {
	return _items_state._amount[_item]
}

function items_max_amount_get(_items_state, _item, _max_amount) {
	_items_state._ma_amount[_item] = _max_amount
}

function items_activate_all(_items_state) {
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		items_activate(_items_state, _index)
	}
}

function items_is_active(_items_state, _index) {
	return _items_state._is_active[_index]
}

function items_is_countable(_items_state, _index) {
	return array_is_value_inside(_COUNTABLE_ITEMS, _index)
}

/* TODO: Remove not necessary anymore
function items_active_calculate_mask(_items_state, _mask = []) {
	var _ret = array_create(items_length(_items_state), 0)
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		_ret[_index] = items_is_active(_items_state, _index) * _mask[_index]
	}
	return _ret
}
*/

function items_is_maximazed(_items_state, _item) {
	return _items_state._amount[_item] >= _items_state._max_amount[_item]
}

function items_active_and_still_has(_items_state) {
	var _ret_array = array_create(Item.SIZE, false)
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		if (items_is_countable(_items_state, _index)) {
			_ret_array[_index] = items_still_has(_items_state, _index) && items_is_active(_items_state, _index)
		} else {
			_ret_array[_index] = items_is_active(_items_state, _index)
		}
	}
	return _ret_array
}

function items_active_number(_items_state) {
	var _sum = 0
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		_sum += items_is_active(_items_state, _index)
	}
	return _sum
}

function items_toggle_active(_items_state, _index) {
	_items_state._is_active[_index] = !items_is_active(_items_state, _index)
}


function items_enable_all(_items_state) {
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		items_enable(_items_state, _index)
	}
}

function items_add_amount(_items_state, _item, _increment) {
	log_info(_items_state, "Addin amount " + string_format(_increment, 1, 0) + " with max of " + string_format(_items_state._max_amount[_item], 1, 0))
	_items_state._amount[_item] = min(_items_state._amount[_item] + _increment, _items_state._max_amount[_item])
}

function items_add_max_amount(_items_state, _item, _increment) {
	_items_state._max_amount[_item] = min(_items_state._max_amount[_item] + _increment, items_get_limit(_items_state, _item))
}

function items_get_ammo_amount(_items_state) {
	var _countables = items_get_countables(_items_state)
	var _ret = 0
	for (var _index = 0; _index < array_length(_countables); ++_index) {
		_ret += _items_state._amount[_index]
	}
	return _ret
}

function items_still_has(_items_state, _item) {
	return _items_state._amount[_item] > 0
}

function items_is_at_limit(_items_state, _item) {
	return _items_state._max_amount[_item] >= items_get_limit(_items_state, _item)
}

function items_get_display_amount(_items_state, _item) {
	return string(_items_state._amount[_item]) + "/" + string(_items_state._max_amount[_item])
}

function items_set_item_to_max(_items_state, _item) {
	log_info(_items_state, "Set to Max " + string_format(_item, 1, 0))
	_items_state._amount[_item] = _items_state._max_amount[_item]
}

function items_set_item_max(_items_state, _item, _max_amount) {
	_items_state._max_amount[_item] = _max_amount
}

function items_set_max_to_limit(_item_state, _item) {
	_items_state._max_amount[_item] = items_get_limit(_items_state, _item)
}

function items_amount_iterate(_items_state, _item, _percentage, _max_percentage) {
	log_info(_items_state, _item)
	log_info(_items_state, _percentage)
	log_info(_items_state, _max_percentage)
	var _amount = _items_state._amount[_item],
		_max_amount = _items_state._max_amount[_item]
	
	log_info(_items_state, _amount)
	log_info(_items_state, _max_amount)
	_items_state._amount[_item] = clamp(lerp(_amount, _max_amount, _percentage), _amount + _max_amount * _max_percentage, _max_amount);
}

function items_amount_iterate_with_max_value(_items_state, _item, _percentage, _max_increment) {
	log_info(_items_state, "Iterate with max value")
	var _amount = _items_state._amount[_item],
		_max_amount = _items_state._max_amount[_item]
	
	_items_state._amount[_item] = clamp(lerp(_amount, _max_amount, _percentage), _amount + _max_increment, _max_amount);
}

function items_add_more(_items_state, _item, _amount) {
	items_add_max_amount(_items_state, _item, _amount)
	items_add_amount(_items_state, _item, _amount)
}

#endregion // Public Methods