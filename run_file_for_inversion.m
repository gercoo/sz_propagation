% Inversion script for estimating cortical network from seizure propagation
% times. Please cite "https://doi.org/10.48550/arXiv.2301.01144".

name = 'spm_data_sz2'
cd(['folder_with data'])

%% Clearing all previous information

spm('defaults','EEG');


%% Paths to data, etc.

    
Pbase     = ['folder_with data']; 

Pdata     = Pbase ;                                                   % data directory in Pbase

mkdir([Pbase,'DCM']);

Panalysis = [Pbase,'DCM'] ;                                   % analysis directory in Pbase


% the data

    DCM.xY.Dfile = [Pbase,name,'.mat'];




%% Parameters and options used for setting up model.

DCM.options.analysis = 'ERP';                                               % analyze evoked responses
DCM.options.model = 'szpropagation';                                                  % ERP model
DCM.options.spatial = 'LFP';                                                % spatial model


DCM.options.trials  = [1];                                                    % index of ERPs within ERP/ERF file
DCM.options.Tdcm(1) = 0;                                                    % start of peri-stimulus time to be modelled
DCM.options.Tdcm(2) = 1000;                                                  % end of peri-stimulus time to be modelled
DCM.options.Nmodes  = 1;                                                    % nr of modes for data selection
DCM.options.h       = 0;                                                    % nr of DCT components, detrending data
DCM.options.onset   = 0;                                                   % selection of onset (prior mean)
DCM.options.D       = 1;                                                    % downsampling
DCM.options.location =0;                                                    % Optimise dipole locations
DCM.options.symmetry =0;                                                    % Use symmetry constraint on dipoles
DCM.options.lock     =0;                                                    % Lock between trials
DCM.options.han      =0;                                                    % Use Hanning window on ERP signal
DCM.Sname = {'LFP'};
Nareas    = 1;%size(DCM.Lpos,2);

%----------------------------------------------------------
%% Specify connectivity model
%----------------------------------------------------------


cd(Panalysis)

DCM.A{1} = zeros(Nareas,Nareas);
DCM.A{2} = zeros(Nareas,Nareas);
DCM.A{3} = zeros(Nareas,Nareas);

%----------------------------------------------------------
%% Speciyfing between trial effects
%----------------------------------------------------------
DCM.xU.X = [1];
DCM.xU.name = {'sound'};

%invert
%----------------------------------------------------------
DCM.name = ['DCM_szpropagation_1'];

DCM      = spm_dcm_csd_szpropagation(DCM);

return

