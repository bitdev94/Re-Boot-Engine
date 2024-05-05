/// @description HUD Control
cHSelect = obj_Control.hSelect;
cHCancel = obj_Control.hCancel;
cHRight = obj_Control.right;
cHLeft = obj_Control.left;
cHUp = obj_Control.up;
cHDown = obj_Control.down;
cHToggle = obj_Control.mSelect;

var itemNum = items_active_number(items_state)

if(!global.roomTrans && !obj_PauseMenu.pause)
{
	if (global.HUD == 0)
	{
		hud_reset_beam(hud_state)
		moveHPrev = 1;
		pauseSelect = false;
		
		var itemAmmo = items_active_and_still_has(items_state)
		
		var itemNum2 = array_sum(itemAmmo);
		
		if (itemNum2 > 0)
		{
			if (cHSelect && rHSelect)
			{
				hud_goto_next(hud_state)
				
				var numH = 5;
				while(!itemAmmo[scr_wrap(hud_state._item, 0, 5)] && numH > 0)
				{
					hud_highlight_next_item(hud_state)
				}
				
				if (hud_is_last_item(hud_state))
				{
					hud_state._selected = HUD.BEAMS
					hud_reset_item(hud_state)
				}
				
				audio_play_sound(snd_MenuTick, 0, false);
			}
			else if (hud_state._selected == HUD.ITEMS)
			{
				if(!itemAmmo[scr_wrap(hud_state._item, Item.Missile, Item.SIZE)])
				{
					if (hud_is_item_highlighted(hud_state, Item.Missile) && itemAmmo[Item.SMissile])
					{
						hud_state._item = Item.SMissile
					}
					else if (hud_is_item_highlighted(hud_state, Item.SMissile) && itemAmmo[Item.Missile])
					{
						hud_state._item = Item.Missile
					}
					else
					{
						hud_state._selected = HUD.BEAMS
						hud_reset_item(hud_state)
					}
					audio_play_sound(snd_MenuTick,0,false);
				}
			}
			
			if (hud_state._selected == HUD.ITEMS && ((cHCancel && rHCancel) || hud_is_last_item(hud_state)))
			{
				hud_state._selected = HUD.BEAMS
				hud_reset_item(hud_state)
				if (cHCancel)
				{
					audio_play_sound(snd_MenuTick,0,false);
				}
			}
		}
		
		if (hud_state._selected == HUD.BEAMS)
		{
			hud_reset_item(hud_state)
		}
	}
	else if(global.HUD == 1)
	{
		hud_reset_beam(hud_state)
		if (cHCancel && itemNum > 0)
		{
			if (cHCancel && rHCancel)
			{
				audio_play_sound(snd_MenuTick, 0, false)
			}
			hud_state._selected = HUD.ITEMS
		}
		else
		{
			hud_state._selected = HUD.BEAMS
		}
		
		if (itemNum > 1)
		{
			if(cHSelect)
			{
				pauseSelect = true;
				global.gamePaused = true;				
				moveH = (cHRight && rHRight) - (cHLeft && rHLeft);
				if (moveH != 0)
				{
					//hudBOffsetX = 28*moveH;
					//hudIOffsetX = 28*moveH;
					moveHPrev = moveH;
					audio_play_sound(snd_MenuTick,0,false);
				}

				hud_increment_item(hud_state, moveH)
			}
			else
			{
				moveHPrev = 1;
				if(!rHSelect)
				{
					global.gamePaused = false;
				}
				pauseSelect = false;
			}
		}
		else
		{
			pauseSelect = false;
		}
	}
	else if(global.HUD == 2)
	{
		if(cHCancel && rHCancel && itemNum > 0)
		{
			hud_next_selection(hud_state)
			audio_play_sound(snd_MenuTick,0,false);
		}
		if(cHSelect)
		{
			global.gamePaused = true;
			if ((hud_state._selected == HUD.BEAMS && beam_check_if_none_is_active(beam_state)) || (hud_state._selected == HUD.ITEMS && itemNum > 1))
			{
				moveH = (cHRight && rHRight) - (cHLeft && rHLeft);
				if(moveH != 0)
				{
					hudBOffsetX = 28*moveH;
					hudIOffsetX = 28*moveH;
					moveHPrev = moveH;
					audio_play_sound(snd_MenuTick,0,false);
				}
				hud_increment_selected(hud_state, moveH)
			}
			if (hud_state._selected == HUD.BEAMS && !hud_is_beam_highlighted(hud_state, Beam.Charge))
			{
				var _beam_highlighted = hud_find_active_beam(hud_state);
				if (cHToggle && rHToggle && beam_is_enabled(beam_state, _beam_highlighted))
				{
					beam_toggle_active(beam_state, _beam_highlighted)
					audio_play_sound(snd_MenuShwsh, 0, false);
				}
			}
		}
		else if(!rHSelect)
		{
			global.gamePaused = false;
		}
		pauseSelect = cHSelect;
	}
}

var numH = 5;
while (!have_highlighted_beam_enabled(hud_state, beam_state) && hud_is_beam_highlighted(hud_state, Beam.Charge) && numH > 0)
{
	hud_increment_beam(hud_state, moveHPrev)
	hudBOffsetX += 28*moveHPrev;
	hudIOffsetX += 28*moveHPrev;
	numH--;
}
;
for (var _num_h = 5; !items_is_active(items_state, hud_find_active_item(hud_state)) && _num_h > 0; _num_h--) {
	hud_increment_item(hud_state, moveHPrev)
	hudBOffsetX += 28 * moveHPrev;
	hudIOffsetX += 28 * moveHPrev;
}

hud_rectify(hud_state)

rHSelect = !cHSelect;
rHCancel = !cHCancel;
rHRight = !cHRight;
rHLeft = !cHLeft;
rHUp = !cHUp;
rHDown = !cHDown;
rHToggle = !cHToggle;