function phi = harmonicOscillatorState3d(model, n, w)

        l = sqrt(model.config.M*w/(model.config.hbar));
        hx = util.harmonicOscillatorState(model.grid.r, n(1), l(1));
        hy = util.harmonicOscillatorState(model.grid.r, n(2), l(2));
        hz = util.harmonicOscillatorState(model.grid.rz, n(3), l(3));

        [HX, HY, HZ] = meshgrid(hx, hy, hz);
        phi = HX.*HY.*HZ;
end