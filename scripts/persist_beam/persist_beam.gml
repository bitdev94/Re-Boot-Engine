// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function save_beam_to_map(_map, _beam_state) {
	for (var _index = 0; _index < beam_enable_length(_beam_state); ++_index) {
		var _beam_enable_tag = beam_get_enable_map_tag(_beam_state, _index),
			_beam_active_tag = beam_get_active_map_tag(_beam_state, _index)
			
		ds_map_add(_map, _beam_enable_tag, beam_is_enabled(_beam_state, _index));
		ds_map_add(_map, _beam_active_tag, beam_is_active(_beam_state, _index));
	}
}

/// @func load_beam_from_map
/// @param {Id.DSMap} _map
/// @param {Struct.PlayerBeam} _beam_state
function load_beam_from_map(_map, _beam_state) {
	for (var _index = 0; _index < beam_enable_length(_beam_state); ++_index) {
		var _beam_enable_tag = beam_get_enable_map_tag(_beam_state, _index)
		var _beam_active_tag = beam_get_active_map_tag(_beam_state, _index)
		
		if (_map[? _beam_enable_tag])
			beam_enable(_beam_state, _index)
		
		if (_map[? _beam_active_tag])
			beam_activate(_beam_state, _index)
	}
}

/// @func save_beam_to_list
/// @param {Id.DsList} _list
/// @param {Struct.PlayerBeam} _beam_state
function save_beam_to_list(_list, _beam_state) {
	for (var _index = 0; _index < beam_enable_length(_beam_state); ++_index) {
		if (beam_is_enabled(_beam_state, _index)) {
			ds_list_add(_list, beam_get_list_tag(_beam_state, _index))
		}
	}
}
