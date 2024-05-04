// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_items_to_list(_list, _items_state) {
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		if (items_is_enabled(_items_state, _index)) {
			ds_list_add(_list, items_get_enable_list_tag(_items_state, _index));
		}
	}
}

function save_items_to_map(_map, _items_state) {
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		var _items_enable_tag = items_get_enable_map_tag(_items_state, _index),
			_items_active_tag = items_get_active_map_tag(_items_state, _index)
		
		ds_map_add(_map, _items_enable_tag, items_is_enabled(_items_state, _index));
		ds_map_add(_map, _items_active_tag, items_is_active(_items_state, _index));
	}
}

function load_items_from_map(_map, _items_state) {
	for (var _index = 0; _index < items_length(_items_state); ++_index) {
		var _items_enable_tag = items_get_enable_map_tag(_items_state, _index),
			_items_active_tag = items_get_active_map_tag(_items_state, _index)
		
		items_enable_set(_items_state, _index, _map[? _items_enable_tag])
		items_active_set(_items_state, _index, _map[? _items_active_tag])
	}
}


