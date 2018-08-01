--[[
Clock Rings by Linux Mint (2011) reEdited by despot77

This script draws percentage meters as rings, and also draws clock hands if you want! It is fully customisable; all options are described in the script. This script is based off a combination of my clock.lua script and my rings.lua script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num>5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num>3; conversely if you update Conky every 0.5s, you should use update_num>10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
    lua_load ~/scripts/clock_rings.lua
    lua_draw_hook_pre clock_rings
    
Changelog:
+ v1.0 -- Original release (30.09.2009)
   v1.1p -- Jpope edit londonali1010 (05.10.2009)
*v 2011mint -- reEdit despot77 (18.02.2011)
]]

-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.
clock_x=100
clock_y=150

x_sep=34.5
y_sep=50

disc_x=35
disc_y=255

mem_x=80
mem_y=310
fs_x=110
fs_y=365
network_x=140
network_y=420
batt_x=170
batt_y=475
settings_table = {
    {
        -- Edit this table to customise your rings.
        -- You can create more rings simply by adding more elements to settings_table.
        name='time',          -- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.
        arg='%I.%M',          -- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
        max=12,               -- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
        bg_colour=0xFFFFFF,   -- "bg_colour" is the colour of the base ring.
        bg_alpha=0.1,         -- "bg_alpha" is the alpha value of the base ring.
        fg_colour=0xFFFFFF,   -- "fg_colour" is the colour of the indicator part of the ring.
        fg_alpha=0.2,         -- "fg_alpha" is the alpha value of the indicator part of the ring.
        x=clock_x, y=clock_y, -- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
        radius=50,            -- "radius" is the radius of the ring.
        thickness=5,          -- "thickness" is the thickness of the ring, centred around the radius.
        start_angle=0,        -- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
        end_angle=360,        -- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, but must be larger than start_angle.
    },{
        name='time',
        arg='%M.%S',
        max=60,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.4,
        x=clock_x, y=clock_y,
        radius=56,
        thickness=5,
        start_angle=0,
        end_angle=360,
    },{
        name='time',
        arg='%S',
        max=60,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.6,
        x=clock_x, y=clock_y,
        radius=62,
        thickness=5,
        start_angle=0,
        end_angle=360,
    },{
        name='time',
        arg='%d',
        max=31,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=clock_x, y=clock_y,
        radius=70,
        thickness=5,
        start_angle=-90,
        end_angle=90,
    },{
        name='time',
        arg='%m',
        max=12,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=1,
        x=clock_x, y=clock_y,
        radius=76,
        thickness=5,
        start_angle=-90,
        end_angle=90,
    },{
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=0xFFFFFF,
        bg_alpha=0.2,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x, y=disc_y,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    },{
        name='memperc',
        arg='',
        max=100,
        bg_colour=0xFFFFFF,
        bg_alpha=0.2,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x+x_sep, y=disc_y+y_sep,
        radius=20,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    },{
        name='swapperc',
        arg='',
        max=100,
        bg_colour=0xFFFFFF,
        bg_alpha=0.2,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x+x_sep, y=disc_y+y_sep,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    },{
        name='fs_used_perc',
        arg='/',
        max=100,
        bg_colour=0xFFFFFF,
        bg_alpha=0.2,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x+2*x_sep, y=disc_y+2*y_sep,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    },{
        -- arg name comes from ifconfig
        name='downspeedf',
        arg='enp6s0',
        max=500,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x+3*x_sep, y=disc_y+3*y_sep,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    },{
        name='upspeedf',
        arg='enp6s0',
        max=500,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x+3*x_sep, y=disc_y+3*y_sep,
        radius=20,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    },{
        -- arg name comes from ifconfig
        name='downspeedf',
        arg='wlp5s0f0',
        max=500,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x+3*x_sep, y=disc_y+3*y_sep,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    },{
        name='upspeedf',
        arg='wlp5s0f0',
        max=500,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x+3*x_sep, y=disc_y+3*y_sep,
        radius=20,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    },{
        name='battery_percent',
        arg='BAT0',
        max=100,
        bg_colour=0xFFFFFF,
        bg_alpha=0.2,
        fg_colour=0xFFFFFF,
        fg_alpha=0.8,
        x=disc_x+4*x_sep, y=disc_y+4*y_sep,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=180,
    }
}

-- Use these settings to define the origin and extent of your clock.

clock_r=64.5
hour_r =48/clock_r
min_r  =56/clock_r

show_seconds=true

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height
    
    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    -- math.min is used to prevent ring over-fill
    local t_arc=math.min(t*(angle_f-angle_0),angle_f+math.pi)

    -- Draw background ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)
    
    -- Draw indicator ring
    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)
end

function draw_clock_hands(cr,xc,yc)
    local secs,mins,hours,secs_arc,mins_arc,hours_arc
    local xh,yh,xm,ym,xs,ys
    
    secs=os.date("%S")    
    mins=os.date("%M")
    hours=os.date("%I")
        
    secs_arc=(2*math.pi/60)*secs
    mins_arc=(2*math.pi/60)*mins+secs_arc/60
    hours_arc=(2*math.pi/12)*hours+mins_arc/12

    -- Draw hour hand

    xh=xc+hour_r*clock_r*math.sin(hours_arc)
    yh=yc-hour_r*clock_r*math.cos(hours_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xh,yh)
    
    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
    cairo_set_line_width(cr,5)
    cairo_set_source_rgba(cr,1.0,1.0,1.0,1.0)
    cairo_stroke(cr)
    
    -- Draw minute hand
    
    xm=xc+min_r*clock_r*math.sin(mins_arc)
    ym=yc-min_r*clock_r*math.cos(mins_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xm,ym)
    
    cairo_set_line_width(cr,3)
    cairo_stroke(cr)
    
    -- Draw seconds hand
    
    if show_seconds then
        xs=xc+clock_r*math.sin(secs_arc)
        ys=yc-clock_r*math.cos(secs_arc)
        cairo_move_to(cr,xc,yc)
        cairo_line_to(cr,xs,ys)
    
        cairo_set_line_width(cr,1)
        cairo_stroke(cr)
    end
end

function draw_graduations(display)
    -- graduations marks
    local x, y = clock_x, clock_y
    local graduation_radius = 61
    local graduation_thickness, graduation_mark_thickness = 5, 1.5
    local graduation_unit_angle = 30
    local graduation_fg_colour, graduation_fg_alpha = 0xFFFFFF, 0.75
    if graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = 360 / graduation_unit_angle
        local i = 0
        while i < nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            cairo_arc(display, x, y, graduation_radius, (((graduation_unit_angle * i)-(graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2),(((graduation_unit_angle * i)+(graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2))
            cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end
end

function conky_clock_rings()
    local function setup_rings(cr,pt)
        local str=''
        local value=0
        local tmp
        
        str=string.format('${%s %s}',pt['name'],pt['arg'])
        if str=='${time %I.%M}' or str=='${time %M.%S}' then
          -- Use hours=0 so that 12:xx doesn't fill the hour ring
          if str=='${time %I.%M}' and tonumber(conky_parse(str)) > 12 then
            str=conky_parse(str)-12
          end
          -- The following statement converts 00-59 mins to 00-99 decimals
          str=conky_parse(str)+2/3*(conky_parse(str)%1)
        else
          str=conky_parse(str)
        end
        value=tonumber(str)
        pct=value/pt['max']
        
        draw_ring(cr,pct,pt)
    end
    
    -- Check that Conky has been running for at least 5s

    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
    
    local cr=cairo_create(cs)    
    
    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)
    
    if update_num>5 then
        for i in pairs(settings_table) do
            setup_rings(cr,settings_table[i])
        end
        -- Adapted from Distro-Clock-Conky
        -- https://www.noobslab.com/2013/03/install-distro-clock-conky-in.html
        draw_graduations(cr)
    end
    
    draw_clock_hands(cr,clock_x,clock_y)
end
