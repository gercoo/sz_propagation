%% DCM result plots
clear all
% original posteriors for data

P.g = zeros(10,1);
P.c = 0;

% starting priors

load('/Users/gercoo/Google Drive/work 2022/codes/matlab/cortical_networks/data/DCM/DCM_szpropagation_1.mat')

pE = DCM.M.pE;

% estimated priors

Ep = DCM.Ep;

%% estimate sz onset times

t(:,1) = spm_szpropagation_forward_full(P);
t(:,2) = spm_szpropagation_forward_full(pE);
t(:,3) = spm_szpropagation_forward_full(Ep);

%% parameters

% para(:,1) = P.g;
para(:,1) = pE.g;
para(:,2) = Ep.g;
%% plot 

figure
subplot(1,2,1)

b1 = bar(t(2:5,:),'hist')%,'ok','MarkerSize',12)
b1(1).FaceColor = [0 0 0];
b1(2).FaceColor = [1 0 0];
b1(3).FaceColor = [0 0 1];
title('\fontsize{14}Seizure onset');
    ax = gca;
    ax.XLabel.String = '\fontsize{12}electrode';
        ax.XTick = 1:4;
        ax.XTickLabel = {'\fontsize{12} 2','\fontsize{12}3','\fontsize{12}4','\fontsize{12}5'};
% % %
        ax.YLabel.String = '\fontsize{12}time, n.u.';
        ax.YTick = 0.1:0.1:0.3;
%     ax.XLabel.FontSize = 14;
%     axis([0 1 0 6])


subplot(1,2,2)

b2 = bar(para,'hist')

b2(1).FaceColor = [1 0 0];
b2(2).FaceColor = [0 0 1];
title('\fontsize{14}Connectivity');

ax = gca;
    ax.XLabel.String = '\fontsize{12}Connectivity parameters';
    ax.YLabel.String = '\fontsize{12}n.u.';
  