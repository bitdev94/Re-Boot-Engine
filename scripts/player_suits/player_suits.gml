// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

enum Suit
{
	Varia,
	Gravity,
	SIZE
};

#region Constructors
function PlayerSuits(): Debugger() constructor {
	_tag = "PlayerSuits"
	_is_active = array_create(Suit.SIZE, false)
	_is_enable = array_create(Suit.SIZE, false)
}
#endregion // Constructors

#region Constants
function suits_get_active_map_tag(_suits_state, _index) {
	return "suit" + string(_index)
}

function suits_get_enable_map_tag(_suits_state, _index) {
	return "hasSuit" + string(_index)
}

function suits_get_list_tag(_suits_state, _index) {
	return "Suit_" + string(_index)
}

#endregion // Constants

#region Public
#region Set

function suits_enable(_suits_state, _suit) {
	_suits_state._is_enable[_suit] = true
}

function suits_active(_suits_state, _suit) {
	_suits_state._is_active[_suit] = true
}

function suits_active_all(_suits_state) {
	for (var _index = 0; _index < Suit.SIZE; ++_index) {
		suits_active(_suits_state, _index)
	}
}

#endregion // Set
#region Get

function suits_length(_suits_state) {
	return Suit.SIZE
}

function suits_is_enable(_suits_state, _suit) {
	return _suits_state._is_enable[_suit]
}

function suits_is_active(_suits_state, _suit) {
	return _suits_state._is_active[_suit]
}

function suits_enable_set(_suits_state, _suit, _state) {
	_suits_state._is_enable[_suit] = _state
}

function suits_active_set(_suits_state, _suit, _state) {
	_suits_state._is_active[_suit] = _state
}

#endregion // Get

function suits_toggle_active(_suits_state, _suit) {
	_suits_state._is_active[_suit] = !_suits_state._is_active[_suit]
}


#endregion // Public