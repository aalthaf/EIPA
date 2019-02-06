global C

C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                    % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665; %metres (32.1740 ft) per s²

nx = 50
ny = 50

x = linspace(0,1,nx);
y = linspace(0,1,ny)
dx2 = nx*ny


G = sparse(nx*ny,nx*ny);




% loop for the spatial matrix
for i = 1:nx
    for j=1:ny
        n = j + (i-1) * ny
        
        if (i == nx || i ==1 || j ==1 || j ==ny)
            G(n,n) = 1;
            
        else
            G(n,n) = -4; % middle value
            G(n,n-1) = 1; % left side
            G(n,n+1) = 1; % right side
            G(n,n-ny) = 1 ;% first value
            G(n,n+ny) = 1 ; % last value
            
        end
        
    end
    
end


figure (1)
spy(G)
[E,D] = eigs(G,9,'SM')
surf(E)
tempE= zeros(nx,ny,9)


for s = 1:9
    tempE(:,:,s) = reshape(E(:,s),nx,ny)
    subplot(3,3,s)
    surf(tempE(:,:,s))
    
    
end

% 
% [V,D] = eigs(G)
% [Ds,Pr] = sort(diag(D))
% D = D(Pr,Pr);
% V = V(:,Pr);
% 
% 
% subplot(2,1,1),plot(x*1e9,Poten/C.q_0);
% xlabel("x(nm)")
% ylabel("Potential(eV)")
