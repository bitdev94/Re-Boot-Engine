// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum Beam
{
	Charge,
	Ice,
	Wave,
	Spazer,
	Plasma,
	SIZE
};

#region Base
function get_shoot(_index = 0) {
	static shoot_combinations =[
		/* +------ Plasma
		   |+----- Spazer    
		   ||+---- Wave
		   |||+--- Ice
		   ||||+-- Charge
		   |||||
		/* 00000 */ obj_PowerBeamShot,
		/* 00001 */ obj_PowerBeamChargeShot,
		/* 00010 */ obj_IceBeamShot,
		/* 00011 */ obj_IceBeamChargeShot,
		/* 00100 */ obj_WaveBeamShot,
		/* 00101 */ obj_WaveBeamChargeShot,
		/* 00110 */ obj_IceWaveBeamShot,
		/* 00111 */ obj_IceWaveBeamChargeShot,
		/* 01000 */ obj_SpazerBeamShot,
		/* 01001 */ obj_SpazerBeamChargeShot,
		/* 01010 */ obj_IceSpazerBeamShot,
		/* 01011 */ obj_IceSpazerBeamChargeShot,
		/* 01100 */ obj_WaveSpazerBeamShot,
		/* 01101 */ obj_WaveSpazerPlasmaBeamChargeShot,
		/* 01110 */ obj_IceWaveSpazerBeamShot,
		/* 01111 */ obj_IceWaveSpazerBeamChargeShot,
		/* 10000 */ obj_PlasmaBeamShot,
		/* 10001 */ obj_PlasmaBeamChargeShot,
		/* 10010 */ obj_IcePlasmaBeamShot,
		/* 10011 */ obj_IcePlasmaBeamChargeShot,
		/* 10100 */ obj_WavePlasmaBeamShot,
		/* 10101 */ obj_WavePlasmaBeamChargeShot,
		/* 10110 */ obj_IceWavePlasmaBeamShot,
		/* 10111 */ obj_IceWavePlasmaBeamChargeShot,
		/* 11000 */ obj_SpazerPlasmaBeamShot,
		/* 11001 */ obj_SpazerPlasmaBeamChargeShot,
		/* 11010 */ obj_IceSpazerPlasmaBeamShot,
		/* 11011 */ obj_IceSpazerPlasmaBeamChargeShot,
		/* 11100 */ obj_WaveSpazerPlasmaBeamShot,
		/* 11101 */ obj_WaveSpazerPlasmaBeamChargeShot,
		/* 11110 */ obj_IceWaveSpazerPlasmaBeamShot,
		/* 11111 */ obj_IceWaveSpazerPlasmaBeamChargeShot
	]
	return shoot_combinations[_index]
}

function get_shoot_animation(_index = 0) {
	static shoot_animations = [
		sprt_PowerBeamChargeAnim,
		sprt_IceBeamChargeAnim,
		sprt_WaveBeamChargeAnim,
		sprt_SpazerChargeAnim,
		sprt_PlasmaBeamChargeAnim
	]
	return shoot_animations[_index]
}

function get_shoot_sound(_index = 0) {
	static shoot_sound = [
		snd_PowerBeam_Shot,
		snd_IceBeam_Shot,
		snd_WaveBeam_Shot,
		snd_Spazer_Shot,
		snd_PlasmaBeam_Shot,
		snd_IceComboShot
	]
	return shoot_sound[_index]
}

function get_delay_item(_index = 0) {
	static delay_table = [
		8, // Power
		4, // Ice
		0, // Wave
		0, // Spazer
		3  // Plasma
	]
	return delay_table[_index]
}

function get_charge_shoot_flare_item(_index = 0) {
	static charge_shoot_flare = [
		sprt_PowerBeamChargeFlare,
		sprt_IceBeamChargeFlare,
		sprt_WaveBeamChargeFlare,
		sprt_SpazerChargeFlare,
		sprt_PlasmaBeamChargeFlare
	]
	return charge_shoot_flare[_index]
}

function  get_charge_shoot_sound_item(_index = 0) {
	static charge_shoot_sound = [
		snd_PowerBeam_ChargeShot,
		snd_IceBeam_ChargeShot,
		snd_WaveBeam_ChargeShot,
		snd_Spazer_ChargeShot,
		snd_PlasmaBeam_ChargeShot,
	]
	return charge_shoot_sound[_index]
}

function get_damage_item(_index = 0) {
	static 	damage_table = [
		/* +----- Plasma   
		   |+---- Wave
		   ||+--- Ice
		   |||
		/* 000 */ 20,
		/* 001 */ 30,
		/* 010 */ 50,
		/* 011 */ 60,
		/* 100 */ 150,
		/* 101 */ 200,
		/* 110 */ 250,
		/* 111 */ 300,
	]
	return damage_table[_index]
}


#endregion // Base

function find_shoot_sound(_flags = []) {
	/* Ice Combo > Ice > Plasma > Wave > Spazer > Power */
	var _sound_index = Beam.Charge
	
	if (_flags[Beam.Spazer])
		_sound_index = Beam.Spazer
		
	if (_flags[Beam.Wave])
		_sound_index = Beam.Wave
	
	if (_flags[Beam.Plasma])
		_sound_index = Beam.Plasma

	if (_flags[Beam.Ice]) {
		_sound_index = Beam.Ice
		
		// TODO: optimize using _sound_index != Beam.Charge
		if (array_any(_flags, function(_val, _ind) { return _val}, Beam.Wave))
			_sound_index = Beam.SIZE
	}

	return _sound_index
}

function find_shoot(_flags = [], _offset = 1) {
	var _state = 0
	var _level = power(2, _offset)
	for (var _index = _offset; _index < array_length(_flags); ++_index) {
		_state += _level * _flags[_index]
		_level *= 2
	}
	return _state
}

function get_simple_charge_amount(_type = -1) {
	/* Spazer > Wave > Plasma, Ice, Power*/
	var _amount = 1
	
	if (_type == Beam.Wave)
		_amount = 2
	
	if (_type == Beam.Spazer)
		_amount = 3
		
	return _amount
}

function find_simple_shoot(_type = -1) {
	return power(2, _type) - 1
}

function find_charge_animation(_flags = []) {
	/* Ice > Plasma > Wave > Spazer > Power */
	// TODO: Implement verification if charge is active
	var _index = Beam.Charge
	
	if (_flags[Beam.Spazer])
		_index = Beam.Spazer
		
	if (_flags[Beam.Wave])
		_index = Beam.Wave
	
	if (_flags[Beam.Plasma])
		_index = Beam.Plasma

	if (_flags[Beam.Ice])
		_index = Beam.Ice

	return _index
}





function get_simple_delay(_type = -1, _default = 0) {
	return get_delay_item(_type) + _default
}

function get_default_charge_delay() {
	static default_charge_delay = 12
	return default_charge_delay
}

function get_simple_charge_delay(_type = -1) {
	return get_simple_delay(_type, get_default_charge_delay())
}

function get_delay(_flags = [], _default = 0) {
	var _delay = 0
	for (var _index = 0; _index < array_length(_flags); ++_index) {
		_delay += get_delay_item(_index) * _flags[_index]
	}
	return _delay
}

function get_charge_delay(_flags = []) {
	get_delay(_flags, get_default_charge_delay())
}

function get_simple_charge_flare_index(_type = -1) {
	return _type
}

function get_charge_amount(_flags = []) {
	/* Spazer > Wave > Plasma, Ice, Power*/
	var _amount = 1
	
	if (_flags[Beam.Wave])
		_amount = 2
	
	if (_flags[Beam.Spazer])
		_amount = 3
		
	return _amount
}

function get_charge_flare_index(_flags = []) {
	/* Ice > Plasma > Wave > Spazer > Power */
	var _index = Beam.Charge
	
	if (_flags[Beam.Spazer])
		_index = Beam.Spazer
		
	if (_flags[Beam.Wave])
		_index = Beam.Wave
	
	if (_flags[Beam.Plasma])
		_index = Beam.Plasma

	if (_flags[Beam.Ice])
		_index = Beam.Ice
	
	return _index
}

function get_simple_damage(_type = -1) {
	var _damage = get_damage_item((_type == Beam.Ice) + 2 * (_type == Beam.Wave) * 4 * (_type == Beam.Plasma))
	if (_type == Beam.Spazer)
		_damage *= (2 / 3)
	return _damage
}

function get_damage(_flags = []) {
	var _damage = get_damage_item((_flags[Beam.Ice] + 2 * _flags[Beam.Wave] + 4 * _flags[Beam.Plasma]))
	if (_flags[Beam.Spazer])
		_damage *= (2 / 3)
	return _damage
}

function find_charge_sound(_flags = []) {
	/* Ice > Plasma > Wave > Spazer > Power */
	var _index = Beam.Charge
	
	if (_flags[Beam.Spazer])
		_index = Beam.Spazer
		
	if (_flags[Beam.Wave])
		_index = Beam.Wave
	
	if (_flags[Beam.Plasma])
		_index = Beam.Plasma

	if (_flags[Beam.Ice])
		_index = Beam.Ice

	return _index
}

function get_icon_index(_flags = []) {
	return bitarray_value(_flags) / 2
}

function get_simple_icon_index(_type = -1) {
	return power(2, _type) / 2;
}

function check_simple_if_is_wave(_type = 0) {
	return _type == Beam.Wave
}

function check_if_is_wave(_flags = []) {
	return _flags[Beam.Wave]
}

function get_simple_shot_amount(_type = 0) {
	var _amount = 1
	if (_type == Beam.Spazer)
		_amount = 3
	return _amount
}

function get_simple_wave_style_offset(_type = -1) {
	var _offset = 1
	if (_type == Beam.Spazer)
		_offset = 0
	return _offset
}

function get_shot_amount(_flags = []) {
	var _amount = 1

	if (_flags[Beam.Wave] && _flags[Beam.Plasma])
		_amount = 2

	if (_flags[Beam.Spazer])
		_amount = 3

	return _amount
}

function get_wave_style_offset(_flags = []) {
	var _offset = 1
	if (_flags[Beam.Spazer])
		_offset = 0
	return _offset
}

function check_if_not_active(_flags = []) {
	var _not_active = array_sum(_flags)
	return check_if_is_not_active(_not_active)
}

function check_if_is_not_active(_index = 0) {
	static default_active_index = 2
	return _index < default_active_index
}

