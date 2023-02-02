function D = spm_szpropagation_forward_full(P)% Create spectrum of ISI for parameter range
%clear ISI
% Parameters

%noise = 0.1:0.05:2.05;


%% estimate parameters for model

G = P.g;
H = zeros(5);
GM = zeros(5);
% H(1,2:5) = exp(G(1:4)).*0.1;
% H(2,3:5) = exp(G(5:7)).*0.2;
% H(3,4:5) = exp(G(8:9)).*0.3;
% H(4,5) = exp(G(10)).*0.4;
%% create H matrix
H(2:5,1) = [0.7;0.2;0.1;0.05];
H(3:5,2) = [0.3;0.2;0.01];
H(4:5,3) = [0.1;0.05];
H(5,4) =   [0.3];


GM(2:5,1) = exp(G(1:4,1));
GM(3:5,2) = exp(G(5:7,1));
GM(4:5,3) = exp(G(8:9,1));
GM(5,4) = exp(G(10,1));

% H = H.*GM;
%% reset parameters

GM2 = zeros(5);
G2 = [-0.0227
   -0.0659
    0.0011
    0.0473
   -0.0428
    0.0130
   -0.0038
   -0.0230
    0.0297
    0.1346];
GM2(2:5,1) = exp(G2(1:4,1));
GM2(3:5,2) = exp(G2(5:7,1));
GM2(4:5,3) = exp(G2(8:9,1));
GM2(5,4) = exp(G2(10,1));


H = H.*GM.*GM2;
%% rescale time

C = exp(P.c).*1/14;  % time rescaling, estimation done in arbitary time units

%% reset parameters

C = C.*exp(-0.1032);

%% run forward model


%D = probability_distribution_T1_2(G);
D = seizure_onset_times(H,C);
return

