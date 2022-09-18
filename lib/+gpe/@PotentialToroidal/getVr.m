function V = getVr(obj)
V = 0.5*obj.config.M*...
            obj.wr^2*((obj.grid.X.^2 + obj.grid.Y.^2).^0.5 - obj.R).^2;
end