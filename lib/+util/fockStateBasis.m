function [ fockbasis ] = fockStateBasis(M, N)
%   ManyBodyBasis Constructs many body basis for N particles
%   on M sites
DimHilbertSpace = round( prod(((N+1):(N+M-1))./(1:(M-1))) );

% matrix of basis vectors
fockbasis = zeros(M,DimHilbertSpace);

% first basis vector
b0 = zeros(M,1);
b0(1) = N;
fockbasis(:,1) = b0;

% iterative construction of basis
for j=2:DimHilbertSpace
    oldbasisvector = fockbasis(:,j-1);
    lastnonzero = find(oldbasisvector,1,'last');
    if lastnonzero < M
        % do nothing
    else
        lastnonzero = lastnonzero-1;
        while oldbasisvector(lastnonzero) == 0
            lastnonzero = lastnonzero-1;
        end
    end
    newbasisvector = oldbasisvector;
    newbasisvector(lastnonzero) = newbasisvector(lastnonzero) - 1;
    newbasisvector(lastnonzero+1) = N - sum(newbasisvector(1:lastnonzero));
    for k=lastnonzero+2:M
        newbasisvector(k) = 0;
    end
    fockbasis(:,j) = newbasisvector;
end

end

