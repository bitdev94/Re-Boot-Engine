// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_suits_to_map(_map, _suits_state) {
	for (var _index = 0; _index < items_length(_suits_state); ++_index) {
		var _suits_enable_tag = items_get_enable_map_tag(_suits_state, _index),
			_suits_active_tag = items_get_active_map_tag(_suits_state, _index)
		
		ds_map_add(_map, _suits_enable_tag, items_is_enabled(_suits_state, _index));
		ds_map_add(_map, _suits_active_tag, items_is_active(_suits_state, _index));
	}
}

function load_suits_from_map(_map, _suits_state) {
	for (var _index = 0; _index < suits_length(_suits_state); ++_index) {
		var _suits_enable_tag = suits_get_enable_map_tag(_suits_state, _index),
			_suits_active_tag = suits_get_active_map_tag(_suits_state, _index)
		
		suits_enable_set(_suits_state, _index, _map[? _suits_enable_tag])
		suits_active_set(_suits_state, _index, _map[? _suits_active_tag])
	}
}

/// @func save_suits_to_list
/// @param {Id.DsList} _list
/// @param {Struct.PlayerBeam} _suits_state
function save_suits_to_list(_list, _suits_state) {
	for (var _index = 0; _index < suits_length(_suits_state); ++_index) {
		if (suits_is_enable(_suits_state, _index)) {
			ds_list_add(_list, suits_get_list_tag(_suits_state, _index))
		}
	}
}