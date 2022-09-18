function rc = getRc(obj, t)
rc.x = obj.xyc.x + obj.Rc.x*cos(obj.Wc*t); 
rc.y = obj.xyc.y + obj.Rc.y*sin(obj.Wc*t); 
end