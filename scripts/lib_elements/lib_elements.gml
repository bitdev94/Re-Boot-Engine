// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @func SimpleItem(name)
/// @desc Function to create a item with name, enable state and active state
/// @param {String} _name 
/// @return {String,Bool,Bool} test
function SimpleItem(_name = "") constructor {
	name = _name
	enabled = false
	active = false
}

/// @func CountableItem(name)
/// @desc Function to create a item with name, enable state, active state, current amount, obtain amount and maximum amount
/// @returns {String,Bool,Bool,Real,Real,Real} test
function CountableItem(_name = "") constructor {
	name = _name
	enable = false
	active = false
	
	current_amount = 0
	obtain_amount = 0
	max_amount = 0
}
