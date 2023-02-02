% Script preprocessing data
% clear all
% %%
% 
% name = '100'
% state = 'sleep'
% 
% S = [];
% S.D = ['/Users/gercoo/Google Drive/work 2020/research/Ep DCM networks/data/',name,'/spm_ep_erp_',name,'_',state,'.mat'];
% S.task = 'defaulteegsens';
% S.save = 1;
% D = spm_eeg_prep(S);


matlabbatch{1}.spm.meeg.averaging.average.D = {'/Users/gercoo/Google Drive/work 2021/codes/matlab2021/ISI_20210101/data/simulate/simulate_data.mat'};
matlabbatch{1}.spm.meeg.averaging.average.userobust.standard = false;
matlabbatch{1}.spm.meeg.averaging.average.plv = false;
matlabbatch{1}.spm.meeg.averaging.average.prefix = 'm';