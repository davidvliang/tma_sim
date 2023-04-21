function gamma = getHarmonicCoefficientMatrix(Q,N,L)
%%% harmonic coefficient matrix corresponding to the modulation function
%%% equation 18 of Ni et. al. 2021
%%% 
%%% Q - harmonic number
%%% N - number of antenna elements
%%% L - "ON" time of phase


q = -Q:1:Q;                     % range of harmonic values
n = 1:N;                        % range of antenna elements
gamma = zeros(length(q),N);     % init gamma

for q_idx = 1:1:length(q)
    for n_idx = 1:1:length(n)
        if q_idx == 0
            gamma(q_idx,n_idx) = 2*L/N-1;
        else
            gamma(q_idx,n_idx) = (2*sin(pi*q_idx*L/N)/(pi*q_idx))*exp(-1i*pi*q_idx*((2*n_idx-2+L)/N));
        end
    end
end
