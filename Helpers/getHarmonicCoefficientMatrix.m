function gamma = getHarmonicCoefficientMatrix(Q,N,L)
%%% harmonic coefficient matrix corresponding to the modulation function
%%% equation 18 of Ni et. al. 2021
%%% Q - harmonic number
%%% N - number of antenna elements
%%% L - "ON" time of phase

q = -Q:1:Q; % range of harmonic values
n = 1:N; % range of antenna elements
gamma = zeros(length(q),N); % init gamma

for q_ = 1:1:length(q)
    for n_ = 1:1:length(n)
        if q_ == 0
            gamma(q_,n_) = 2*L/N-1;
        else
            gamma(q_,n_) = (2*sin(pi*q_*L/N)/(pi*q_))*exp(-1i*pi*q_*((2*n_-2+L)/N));
        end
    end
end
