/// @description HUD Control
cHSelect = obj_Control.hSelect;
cHCancel = obj_Control.hCancel;
cHRight = obj_Control.right;
cHLeft = obj_Control.left;
cHUp = obj_Control.up;
cHDown = obj_Control.down;
cHToggle = obj_Control.mSelect;

var itemNum = (item[Item.Missile]+item[Item.SMissile]+item[Item.PBomb]+item[Item.Grapple]+item[Item.XRay]);

if(!global.roomTrans && !obj_PauseMenu.pause)
{
	if(global.HUD == 0)
	{
		hud_reset_beam(hud_state)
		moveHPrev = 1;
		pauseSelect = false;
		
		var itemAmmo = array((item[Item.Missile] && missileStat > 0),(item[Item.SMissile] && superMissileStat > 0),(item[Item.PBomb] && powerBombStat > 0),item[Item.Grapple],item[Item.XRay]);
		var itemNum2 = (itemAmmo[Item.Missile]+itemAmmo[Item.SMissile]+itemAmmo[Item.PBomb]+itemAmmo[Item.Grapple]+itemAmmo[Item.XRay]);
		
		if(itemNum2 > 0)
		{
			if(cHSelect && rHSelect)
			{
				if(itemSelected == 0)
				{
					itemSelected = 1;
				}
				else
				{
					hud_highlight_next_item(hud_state)
				}
				
				var numH = 5;
				while(!itemAmmo[scr_wrap(hud_state._item, 0, 5)] && numH > 0)
				{
					hud_highlight_next_item(hud_state)
				}
				
				if (hud_is_last_item(hud_state))
				{
					itemSelected = 0;
					hud_reset_item(hud_state)
				}
				
				audio_play_sound(snd_MenuTick,0,false);
			}
			else if (itemSelected == 1)
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
						itemSelected = 0;
						hud_reset_item(hud_state)
					}
					audio_play_sound(snd_MenuTick,0,false);
				}
			}
			
			if (itemSelected == 1 && ((cHCancel && rHCancel) || hud_is_last_item(hud_state)))
			{
				itemSelected = 0;
				hud_reset_item(hud_state)
				if (cHCancel)
				{
					audio_play_sound(snd_MenuTick,0,false);
				}
			}
		}
		else
		{
			itemSelected = 0;
			hud_reset_item(hud_state)
		}
		
		if (itemSelected == 0)
		{
			hud_reset_item(hud_state)
		}
	}
	else if(global.HUD == 1)
	{
		hud_reset_beam(hud_state)
		if (cHCancel && itemNum > 0)
		{
			if(cHCancel && rHCancel)
			{
				audio_play_sound(snd_MenuTick,0,false);
			}
			itemSelected = 1;
		}
		else
		{
			itemSelected = 0;
		}
		
		if(itemNum > 1)
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
			itemSelected = scr_wrap(itemSelected + 1, 0, 2);
			audio_play_sound(snd_MenuTick,0,false);
		}
		if(cHSelect)
		{
			global.gamePaused = true;
			/*if(((cHUp && rHUp) || (cHDown && rHDown)) && itemNum > 0)
			{
				itemSelected = scr_wrap(itemSelected + 1, 0, 1);
				audio_play_sound(snd_MenuTick,0,false);
			}*/
			if((itemSelected == 0 && beam_check_if_not_active(beam_state)) || (itemSelected == 1 && itemNum > 1))
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
			if (itemSelected == 0 && !hud_is_beam_highlighted(hud_state, Beam.Charge))
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
numH = 5;
while(!item[hud_find_active_item(hud_state)] && numH > 0)
{
	hud_increment_item(hud_state, moveHPrev)
	hudBOffsetX += 28*moveHPrev;
	hudIOffsetX += 28*moveHPrev;
	numH--;
}

hud_rectify(hud_state)

rHSelect = !cHSelect;
rHCancel = !cHCancel;
rHRight = !cHRight;
rHLeft = !cHLeft;
rHUp = !cHUp;
rHDown = !cHDown;
rHToggle = !cHToggle;