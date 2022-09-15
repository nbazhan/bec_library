function N = nParticlesInHarmonicOscillator(grid, Psi, n)
X = gather(grid.X);
Y = gather(grid.Y);
Z = gather(grid.Z);
dV = gather(grid.dV);
phi = exp(-0.5.*(X.^2 + Y.^2 + Z.^2)).*...
      hermiteH(n(1), X).*...
      hermiteH(n(2), Y).*...
      hermiteH(n(3), Z);
  
N = sum(sum(sum(conj(phi).*Psi.*dV)));
end