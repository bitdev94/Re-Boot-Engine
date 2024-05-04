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

function PlayerItems() constructor {
	_is_active = array_create(Item.SIZE, false)
	_is_enable = array_create(Item.SIZE, false)
}

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

function items_length(_items_state) {
	return Item.SIZE
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

function items_activate_all(_items_state) {
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		items_activate(_items_state, _index)
	}
}

function items_is_active(_items_state, _index) {
	return _items_state._is_active[_index]
}

function items_active_calculate_mask(_items_state, _mask = []) {
	var _ret = array_create(items_length(_items_state), 0)
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		_ret[_index] = items_is_active(_items_state, _index) * _mask[_index]
	}
	return _ret
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


#endregion // Public Methods