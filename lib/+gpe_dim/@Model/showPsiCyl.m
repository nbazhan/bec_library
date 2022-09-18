function showPsiCyl(obj, Psi, i)
    if obj.grid.GPU == 1
        Psi = gather(Psi);
    end
    r = obj.Vts(i).R;
    Nphi = 450;

    angr0 = zeros([obj.grid.N.z Nphi]);
    angrp = zeros([obj.grid.N.x obj.grid.N.y]);
    psirp = zeros([obj.grid.N.x obj.grid.N.y]);
    v = zeros([obj.grid.N.z Nphi]);
 
    for iz=1:obj.grid.N.z
        [X,Y] = meshgrid(obj.grid.r.x, obj.grid.r.y);
        for ix=1:obj.grid.N.x
            for iy=1:obj.grid.N.y
                psirp(ix,iy)=real(Psi(ix,iy,iz));
                angrp(ix,iy)=imag(Psi(ix,iy,iz));
            end
        end
        for l=1:Nphi
            X1=r*cos(2*pi*l/Nphi);
            Y1=r*sin(2*pi*l/Nphi);
            psirazb=interp2(X,Y, psirp, X1, Y1);
            angrrazb=interp2(X,Y,angrp, X1, Y1);
            angr0(iz,l)=(psirazb)+(1i*angrrazb);
            v(iz,l)=abs(angr0(iz,l))^2;
        end
    end
   
    rl = linspace(-pi/2*r, 3*pi/2*r, Nphi);
    
    f = figure('visible', 'off', 'Position', [10 10 1500 900]);
    ax1 = subplot(2,1,1);
    imagesc(rl, obj.grid.r.z, v);
    title(['Density']);
    %axis manual;
    %xticks(rc.*r.*[-pi/2, 0, pi/2, pi, 3*pi/2])
    %xticklabels({'-\pi/2', '0', '\pi/2', '\pi', '3\pi/2'})
    %ylim([-rc*obj.grid.Lz/2 rc*obj.grid.Lz/2]);
    ylabel('y, $l_r$');
    xlabel('\phi, \circ');
    colorbar('horiz'); 
    %caxis([0 470]);
    set(gca,'LineWidth',1.2);
    set(gca,'FontSize',20);
    set(gca,'YDir','normal')

    ax2 = subplot(2,1,2);
    imagesc(rl, obj.grid.r.z, angle(angr0));
    title('Phase');
    %xticks(rc.*r.*[-pi/2, 0, pi/2, pi, 3*pi/2])
    %xticklabels({'-\pi/2', '0', '\pi/2', '\pi', '3\pi/2'})
    %ylim([-rc*obj.grid.Lz/2 rc*obj.grid.Lz/2]);
    ylabel('y, $l_r$');
    xlabel('\phi, \circ');
    colorbar('horiz'); 
    set(gca,'YDir','normal')
    set(gca,'LineWidth', 1.2);
    set(gca,'FontSize', 20);
    shg
end
  
