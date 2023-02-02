% script creating spm data
% save data consisting of ISI vs. background power
% use LFP modality

clear all


%% load data
address = '/Users/gercoo/Google Drive/work 2022/codes/matlab/cortical_networks/data/';
%name = '100'
load([address,'data2'])

% create simulated data
d1 = D{1};
name = 'data_sz2';

%% define the output file


fname = ['spm_',name];


[n,m]=size(d1);
fsample = m;
%--------------------------------------------------------------------------
Ic = [n];

% Create the Fieldtrip raw struct
%--------------------------------------------------------------------------
ftdata = [];

It            = [1:fsample];
ftdata.trial{1} = d1(:,It);
%    ftdata.trial{2} = s2(:,It);
ftdata.time{1} = [It]./fsample;
%    ftdata.time{2} = [It-512]./fsample;


ftdata.fsample = fsample;
ftdata.label = {'LFP1'};
cd([address]);
% Convert the ftdata struct to SPM M\EEG dataset
%--------------------------------------------------------------------------
D = spm_eeg_ft2spm(ftdata, fname);



% Examples of providing additional information in a script
% [] comes instead of an index vector and means that the command
% applies to all channels/all trials.
%--------------------------------------------------------------------------
D = type(D, 'single');             % Sets the dataset type
D = chantype(D, [], 'LFP');        % Sets the channel type
%D = conditions(D,[1:k], 'Sound 1');  % Sets the condition label
%D = conditions(D, [k+1:k+k1], 'Sound 2');  % Sets the condition label

D = conditions(D,1,'plain');  % Sets the condition label
%  D = conditions(D,2,'I');  % Sets the condition label
%D=units(D,[],'\muV');
%

clear Ic It label fsample ftdata
clear d1
clear name
%--------------------------------------------------------------------------
%cd /home/vernon/spm8/gerald_T1D_091026/
%disp('1')



save(D);


