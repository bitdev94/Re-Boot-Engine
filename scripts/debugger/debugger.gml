// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum DEBUG {
	SIMPLE
}

function Debugger() constructor {
	_debug_is_enable = true
	_tag = "DEFAULT"
}

function log_info(_debugger, _message ) {
	if (_debugger._debug_is_enable) {
		show_debug_message("{0} INFO: {1} ", _debugger._tag, _message)
	}
}