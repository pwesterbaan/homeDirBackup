clock_x=1680/2
clock_y=1050/2

ring_sep=45
ring_gap=1.5
ring_thickness=ring_sep-ring_gap
hour_ring=250
min_ring=hour_ring+ring_sep
sec_ring=min_ring+ring_sep
day_ring=sec_ring+1.25*ring_sep
mnth_ring=day_ring+ring_sep
hand_r_adjust=0.4*ring_sep
clock_r=sec_ring+hand_r_adjust
hour_r =(hour_ring+hand_r_adjust)/clock_r
min_r =(min_ring+hand_r_adjust)/clock_r


hour_hand_thickness=9
min_hand_thickness=6
sec_hand_thickness=3

settings_table = {
    {
        name='time',
        arg='%I.%M',
        max=12,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.2,
        x=clock_x, y=clock_y,
        radius=hour_ring,
        thickness=ring_thickness,
        start_angle=0,
        end_angle=360,
    },{
        name='time',
        arg='%M.%S',
        max=60,
        bg_colour=0xFFFFFF,
        bg_alpha=0.1,
        fg_colour=0xFFFFFF,
        fg_alpha=0.4,
        x=clock_x, y=clock_y,
        radius=min_ring,
        thickness=ring_thickness,
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
        radius=sec_ring,
        thickness=ring_thickness,
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
        radius=day_ring,
        thickness=ring_thickness,
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
        radius=mnth_ring,
        thickness=ring_thickness,
        start_angle=-90,
        end_angle=90,
    }
}


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
    cairo_set_line_width(cr,hour_hand_thickness)
    cairo_set_source_rgba(cr,1.0,1.0,1.0,1.0)
    cairo_stroke(cr)

    -- Draw minute hand

    xm=xc+min_r*clock_r*math.sin(mins_arc)
    ym=yc-min_r*clock_r*math.cos(mins_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xm,ym)

    cairo_set_line_width(cr,min_hand_thickness)
    cairo_stroke(cr)

    -- Draw seconds hand

    if show_seconds then
        xs=xc+clock_r*math.sin(secs_arc)
        ys=yc-clock_r*math.cos(secs_arc)
        cairo_move_to(cr,xc,yc)
        cairo_line_to(cr,xs,ys)

        cairo_set_line_width(cr,sec_hand_thickness)
        cairo_stroke(cr)
    end
end

function draw_graduations(display)
    -- graduations marks
    local x, y = clock_x, clock_y
    local graduation_radius = min_ring
    local graduation_thickness, graduation_mark_thickness = 2.75*ring_sep, 0.25
    local graduation_unit_angle = 30
    local graduation_fg_colour, graduation_fg_alpha = 0xFFFFFF, 0.3
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
          if str=='${time %I.%M}' and tonumber(conky_parse(str)) >= 12 then
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

    if update_num>1 then
        for i in pairs(settings_table) do
            setup_rings(cr,settings_table[i])
        end
        -- Adapted from Distro-Clock-Conky
        -- https://www.noobslab.com/2013/03/install-distro-clock-conky-in.html
        draw_graduations(cr)
    end

    draw_clock_hands(cr,clock_x,clock_y)
end
