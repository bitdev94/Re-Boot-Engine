///scr_DrawHUD
function scr_DrawHUD() {

	var vX = camera_get_view_x(view_camera[0]),
		vY = camera_get_view_y(view_camera[0]);

	var col = c_black, alpha = 0.4;

	var itemNum = items_active_number(items_state)

	var selecting = (pauseSelect && !global.roomTrans && !obj_PauseMenu.pause);
    
	if(global.hudDisplay && itemNum > 0)
	{
		if(selecting)
	    {
	        draw_set_color(c_black);
	        draw_set_alpha(0.5);
	        draw_rectangle(vX,vY,vX+global.resWidth,vY+global.resHeight,false);
	        draw_set_alpha(0.75);
	        draw_rectangle(vX,vY,vX+global.resWidth,vY+48,false);
	        draw_set_alpha(1);
	    }

	    for(var i = 0; i < array_length(items_state._is_active); i++)
	    {
	        if (items_is_active(items_state, i))
	        {
	            draw_set_color(col);
	            draw_set_alpha(alpha);
				
				var eOffX = 0;
				var energyTanks = floor(energyMax / 100);
				if(energyTanks > 14)
				{
					eOffX = 7*scr_floor((energyTanks-13)/2);
				}
				var vX2 = vX+eOffX;
				
				var xx = 57,
					yy = 4,
					ww = 39,
					hh = 14;
				if(i == 1)
				{
					xx = 101;
					ww = 33;
				}
				if(i == 2)
				{
					xx = 139;
					ww = 30;
				}
				if(i >= 3)
				{
					xx = 174;
					ww = 14;
					if(i == 4)
					{
						xx = 193;
					}
				}
				var index = 0;
				if((hud_is_item_highlighted(hud_state, i) && (global.HUD == 0 || stateFrame != State.Morph)) || (global.HUD == 1 && stateFrame == State.Morph && i == 2))
				{
					if (global.HUD == 1)
					{
						index = 2;
					}
					if (hud_state._selected == HUD.ITEMS)
					{
						index = 1;
					}
				}
				var x2 = xx-2, y2 = yy-2;
				draw_roundrect_ext(vX2+x2,vY+y2,vX2+x2+ww,vY+y2+hh,8,8,false);
				
				draw_set_alpha(1);
	            draw_set_color(c_white);
				
				draw_sprite_ext(sprt_HItem,index+3*i,floor(vX2+xx),floor(vY+yy),1,1,0,c_white,1);
				
				if(i == 0)
				{
					var col2 = c_white;
					if (items_is_maximazed(items_state, Item.Missile))
					{
						col2 = c_lime;
					}
					
					draw_sprite_ext(sprt_HNumFont2, items_state._amount[Item.Missile],floor(vX2+85),floor(vY+7),1,1,0,col2,1);
					var missileNum = floor(items_state._amount[Item.Missile]/10);
	                draw_sprite_ext(sprt_HNumFont2,missileNum,floor(vX2+79),floor(vY+7),1,1,0,col2,1);
					missileNum = floor(items_state._amount[Item.Missile]/100);
	                draw_sprite_ext(sprt_HNumFont2,missileNum,floor(vX2+73),floor(vY+7),1,1,0,col2,1);
				}
				if(i == 1)
				{
					var col2 = c_white;
					if (items_is_maximazed(items_state, Item.SMissile))
					{
						col2 = c_lime;
					}
					
					draw_sprite_ext(sprt_HNumFont2, items_state._amount[Item.SMissile], floor(vX2+123),floor(vY+7),1,1,0,col2,1);
	                var superMissileNum = floor(items_state._amount[Item.SMissile]/10);
	                draw_sprite_ext(sprt_HNumFont2, superMissileNum, floor(vX2+117), floor(vY+7), 1, 1, 0, col2, 1);
				}
				if(i == 2)
				{
					var col2 = c_white;
					if (items_is_maximazed(items_state, Item.PBomb))
					{
						col2 = c_lime;
					}
					
					draw_sprite_ext(sprt_HNumFont2, items_state._amount[Item.PBomb], floor(vX2+158), floor(vY+7), 1, 1, 0, col2, 1);
	                var powerBombNum = floor(items_state._amount[Item.PBomb]/10);
	                draw_sprite_ext(sprt_HNumFont2,powerBombNum,floor(vX2+152),floor(vY+7),1,1,0,col2,1);
				}
	        }
	    }
		
		draw_set_color(c_white);
	
		if (selecting)
		{
			draw_set_font(fnt_Menu2);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			var strg = itemName[hud_state._item],
	        tX = 123 - scr_round(string_width(strg) / 2);
	        draw_text_transformed(vX+tX, vY+21, strg, 1, 1, 0);
			var xx = 69,
				yy = 38;
			for(var i = 0; i < array_length(items_state._is_active); i++)
			{
				xx = 50 + 36*i;
				if (items_is_active(items_state, i))
				{
					draw_sprite_ext(sprt_HItemMisc,i + 5*(hud_is_item_highlighted(hud_state, i)), vX+xx,vY+yy,1,1,0,c_white,1);
				}
			}
		}
	}


}
