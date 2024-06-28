  %% directory of training data
tmp_curdir='';
tmp_filename=strcat(tmp_curdir,'/Training data.xlsx');

tmp_sheet='RASSF1A';
tmp_xlRange = 'B3:C8';
tmp_num = xlsread(tmp_filename,tmp_sheet,tmp_xlRange);
EstimData.expt.title{1}=tmp_sheet;
EstimData.expt.description{1}= 'time course(in house data (Gaya))';
EstimData.expt.ligand{1}='TGFbeta';
EstimData.expt.dose{1}=[100]; % 10 nM
EstimData.expt.data{1}=tmp_num(:,2);
EstimData.expt.names{1}={'RASSF1Ar'};
EstimData.expt.time{1}=tmp_num(:,1); % time points (min)


tmp_sheet='YAP357';
tmp_xlRange = 'B3:C8';
tmp_num = xlsread(tmp_filename,tmp_sheet,tmp_xlRange);
EstimData.expt.title{2}=tmp_sheet;
EstimData.expt.description{2}='experiment 2: (Golan-Lavi, Giacomelli et al. 2017)';
EstimData.expt.ligand{2}='TGFbeta';
EstimData.expt.dose{2}=[100]; % 20ng
EstimData.expt.data{2}=tmp_num(:,2);
EstimData.expt.names{2}={'YAP357r'};
EstimData.expt.time{2}=tmp_num(:,1);

tmp_sheet='smad7';
tmp_xlRange = 'B3:C8';
tmp_num = xlsread(tmp_filename,tmp_sheet,tmp_xlRange);
EstimData.expt.title{3}=tmp_sheet;
EstimData.expt.description{3}='experiment 2: (Golan-Lavi, Giacomelli et al. 2017)';
EstimData.expt.ligand{3}='TGFbeta';
EstimData.expt.dose{3}=[ 100]; % 20ng
EstimData.expt.data{3}=tmp_num(:,2);
EstimData.expt.names{3}={'smad7r'};
EstimData.expt.time{3}=tmp_num(:,1);


% multi-dose time course response
tmp_sheet='pSmad2';
tmp_xlRange = 'B3:C8';
tmp_num = xlsread(tmp_filename,tmp_sheet,tmp_xlRange);
EstimData.expt.title{4}=tmp_sheet;
EstimData.expt.description{4}='experiment 4';
EstimData.expt.ligand{4}='TGFbeta';
EstimData.expt.dose{4}=[100]; % nM
EstimData.expt.data{4}=tmp_num(:,2);
% EstimData.expt.data{4}{2}=tmp_num(:,6);
EstimData.expt.names{4}={'pSmad2r'};
EstimData.expt.time{4}=tmp_num(:,1);

tmp_sheet='p73YAP';
tmp_xlRange = 'B3:C6';
tmp_num = xlsread(tmp_filename,tmp_sheet,tmp_xlRange);
EstimData.expt.title{5}=tmp_sheet;
EstimData.expt.description{5}='time course';
EstimData.expt.ligand{5}='Doseinput1';
EstimData.expt.dose{5}=[5000]; % 20ng
EstimData.expt.data{5}=tmp_num(:,2);
EstimData.expt.names{5}={'YAPp73'};
EstimData.expt.time{5}=tmp_num(:,1);
% 
% 
tmp_sheet='pSmad2YAP';
tmp_xlRange = 'B3:C6';
tmp_num = xlsread(tmp_filename,tmp_sheet,tmp_xlRange);
EstimData.expt.title{6}=tmp_sheet;
EstimData.expt.description{6}='time course';
EstimData.expt.ligand{6}='Doseinput1';
EstimData.expt.dose{6}=[100]; % 20ng
EstimData.expt.data{6}=tmp_num(:,2);
EstimData.expt.names{6}={'YAPpSmad2'};
EstimData.expt.time{6}=tmp_num(:,1);


%% model parameters
EstimData.model.paramnames=Hippo('parameters');
EstimData.model.paramvals=[];
EstimData.model.initialparamvals=Hippo('parametervalues');
EstimData.model.statenames=Hippo('states');
tmp_output=Hippo(0:10);
EstimData.model.initials=Hippo;
EstimData.model.varnames=tmp_output.variables;
EstimData.model.maxnumsteps=10000; % max steps of MEX
EstimData.model.bestfit=Hippo('parametervalues');

%% simulation data
EstimData.sim.statevalues{1}=[];
EstimData.sim.varvalues{1}=[];
EstimData.sim.resampled{1}=[];
EstimData.sim.J{1}=[];
EstimData.sim.Jb=[];
EstimData.sim.errorcheck= @(x) logical(sum((abs(x(end-1,x(end,:)>1e-3) - x(end,x(end,:)>1e-3))./x(end,x(end,:)>1e-3) > 1e-3) + (x(end,x(end,:)>1e-3)) < -1e-10));
EstimData.sim.ci_mask_size=0.2;
EstimData.sim.Jth={0 0 0 0 0 0};
EstimData.sim.Jweight={1 1 1 1 1 1 };

clear -regexp ^tmp_