function Yt = getSingleChannel(fp, Q, Nt, gamma, Xnt)
%%% Ni 2021 (eq6)

q = -Q:1:Q;                     % range of harmonic values
% n = 1:N;                        % range of antenna elements
t=1:1:Nt;                       % range of snapshots

w = zeros(Nt, length(q));       % init modulation term

for tdx = 1:1:Nt
    for qdx = 1:1:length(q)
        w(tdx,qdx) = exp(-1i*2*pi*q(qdx)*fp*t(tdx));
    end
end

Yt = (gamma*Xnt)*w;             % modulate Xnt and combine





