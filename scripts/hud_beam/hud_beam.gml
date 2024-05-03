// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function have_highlighted_beam_enabled(_hud_state, _beam_state) {
	return beam_is_enabled(_beam_state, hud_find_active_beam(_hud_state))
}

function reload_beam_state_with_highlight(_hud_state, _beam_state) {
	var _beam_type = hud_get_highlighted_beam(_hud_state)
	beam_load_with_check(_beam_state, _beam_type)
}