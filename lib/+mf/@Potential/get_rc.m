function rc = get_rc(obj, t)
rc.x = obj.c.x + obj.c.rx*cos(obj.c.w*t); 
rc.y = obj.c.y + obj.c.ry*sin(obj.c.w*t); 
end