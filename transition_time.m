function T = transition_time(h,phi)

%% parameters

m0 = 0;
m1 = 1; % boundary between attractor manifolds for low/high amplitude activity

T = m1./(-1.*h.*cos(phi));

if lt(T,0)
    T=NaN;
end