function Psi = loadPsi(obj, s)
    load([obj.PsiMat 'Psi' num2str(s,'%.0f') '.mat'], 'Psi');
end

