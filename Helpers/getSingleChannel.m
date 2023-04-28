function Yt = getSingleChannel(fp, gamma, X)
%%% Ni 2021 (eq6)

q = -Q:1:Q;                     % range of harmonic values
n = 1:N;                        % range of antenna elements
w = zeros(q,1);                 % init modulation term
Yt = zeros(length(q),N);        % init single channel

for q_idx=1:1:length(q_idx)
    w(q_idx) = exp(-1i*2*pi*q_idx*fp*t);
end


% Yt = w*gamma*Xnt;             % modulate Xnt and combine





