function [l, E] = getDimless(obj)
% get oscillator length and energy
if ~isempty(obj.Vts)
    l = sqrt(obj.config.hbar/(obj.config.M*obj.Vts(1).wr));
    E = obj.config.hbar*obj.Vts(1).wr;
else
    l = 1;
    E = 1;
end
end

