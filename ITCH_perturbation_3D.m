% parameter values
clear all
close all
param_best = textread('Finalparamset4.txt');
tmp_modelparamvals=param_best(1,1:end);
tmp_initialConditions=Hippo;
tmp_model_statenames=Hippo('states');

%% simulation spec
%% sampling time point, simulation time, dosage
tmp_obstime = [0:0.005:48];
tmp_simtime=[linspace(0,5000-1,500) [5000+tmp_obstime]];

tmp_tidx=tmp_simtime>=5000;
%-----------
tmp_modelparamvals(44) = 10000;
modelparamvals1 = tmp_modelparamvals;
tmp_dose = [0 :0.005:3];

tmp_iniCond1 = tmp_initialConditions;
targets = {'cytoITCH'};

for j=1:length(targets)
    tmp_iniCond1 = tmp_initialConditions;
    
    for i= 1:length(tmp_dose)
        
        tmp_iniCond1(ismember(tmp_model_statenames,targets{j})) = tmp_initialConditions(ismember(tmp_model_statenames,targets{j}))*tmp_dose(i);
        out=Hippo(tmp_simtime,tmp_iniCond1,modelparamvals1');
        tmp_fc_varvals=out.variablevalues(tmp_tidx,:);
        
        tmp_YAPSmad(i,:)=tmp_fc_varvals(:,ismember(out.variables,"pSmad2r"))';
        tmp_YAPp73(i,:) = tmp_fc_varvals(:,ismember(out.variables,"p73YAPr"));
        
    end
    
    tmp_YAPSmad = (tmp_YAPSmad - min(min(tmp_YAPSmad)))/max(tmp_YAPSmad(:,end));
    tmp_YAPSmad = tmp_YAPSmad/max(max(tmp_YAPSmad));
    colormap (jet)
    figure('Position',[1175         658         209         129]);
    [X,Y] = meshgrid(tmp_obstime,tmp_dose);
    Z = tmp_YAPSmad;
    
    mesh(X,Y,Z)
    colormap (jet)
   set(gca,'XTick',[], 'YTick', [],'ZTick', [])
    res = 600;
    
    set(gca,'fontsize',12,'linewidth',1);
    box off

     print('figures/svg/3D-smad.svg','-dsvg',['-r' sprintf('%.0f',res)]);

%_____________ yap p73   
    tmp_YAPp73 = (tmp_YAPp73 - min(min(tmp_YAPp73)))/max(tmp_YAPp73(:,end));
    tmp_YAPp73 = tmp_YAPp73/max(max(tmp_YAPp73));
    colormap (jet)
    figure('Position',[1175         658         209         129]);
    [X,Y] = meshgrid(tmp_obstime,tmp_dose);
    Z = tmp_YAPp73;
    
    mesh(X,Y,Z)
    colormap (jet)
   set(gca,'XTick',[], 'YTick', [],'ZTick', [])
 
    
    set(gca,'fontsize',8,'linewidth',1);
    box off
    saveas(gcf,sprintf('figures/3D.png'));
          print('figures/svg/3D-p73.svg','-dsvg',['-r' sprintf('%.0f',res)]);

    
end



