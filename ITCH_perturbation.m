% parameter values
clear all
close all
param_best = textread('Finalparamset4.txt');
tmp_modelparamvals=param_best(1,1:end);
tmp_initialConditions=Hippo;
tmp_model_statenames=Hippo('states');

%% simulation spec
%% sampling time point, simulation time, dosage
tmp_obstime = [0 2 48];
tmp_simtime=[linspace(0,5000-1,500) [5000+tmp_obstime]];

tmp_tidx=tmp_simtime>=5000;
%-----------
tmp_modelparamvals(44) = 10000;
modelparamvals1 = tmp_modelparamvals;
tmp_dose = [0 :0.1:5];

tmp_iniCond1 = tmp_initialConditions;
targets = {'cytoITCH'};%,'RSmad2','cAbl','Receptor2' 'cytoITCH' 'p73',

    tmp_iniCond1 = tmp_initialConditions;
    
    for i= 1:length(tmp_dose)
        
        tmp_iniCond1(ismember(tmp_model_statenames,targets)) = tmp_initialConditions(ismember(tmp_model_statenames,targets))*tmp_dose(i);
        out=Hippo(tmp_simtime,tmp_iniCond1,modelparamvals1');
        tmp_fc_varvals=out.variablevalues(tmp_tidx,:);
        
        tmp_YAPSmad(i,:)=(tmp_fc_varvals(:,ismember(out.variables,"pSmad2r")))';
        tmp_YAPp73(i,:) = (tmp_fc_varvals(:,ismember(out.variables,"p73YAPr")));
        
        %     saveas(gcf,sprintf('figures/YAPSmad_switch.png'));
    end

    tmp_YAPSmad = (tmp_YAPSmad - min(min(tmp_YAPSmad)))/max(tmp_YAPSmad(:,end));
    tmp_YAPSmad = tmp_YAPSmad/max(max(tmp_YAPSmad));
    
    figure('Position',[1175         658         100         74]);  
    plot(tmp_dose,tmp_YAPSmad(:,2),'color',[0.01,0.09,0.57],'LineWidth',1.5)
        hold on
    plot(tmp_dose,tmp_YAPSmad(:,3),'color',[0.01,0.09,0.57],'LineWidth',1.5)
    set(gca,'fontsize',7,'linewidth',1);
    box off
    axis([0 inf 0 1.01])
    yticks([0.5 1])
    xticks([0 1 2 3 4 5])

    saveas(gcf,sprintf('figures/%ssmad_yap.png',targets{1}));   
     saveas(gcf,sprintf('figures/svg/%ssmad_yap.svg',targets{1}));      
 % __________________________________________
 
     tmp_YAPp73 = (tmp_YAPp73 - min(min(tmp_YAPp73)))/max(tmp_YAPp73(:,end));
    tmp_YAPp73 = tmp_YAPp73/max(max(tmp_YAPp73));
     figure('Position',[1175         658         100        74]);
    plot(tmp_dose,tmp_YAPp73(:,2),'color',[0.01,0.09,0.57],'LineWidth',1.5)
    hold on
     plot(tmp_dose,tmp_YAPp73(:,3),'color',[0.64,0.08,0.18],'LineWidth',1.5)
   
    set(gca,'fontsize',7,'linewidth',1);
    box off
    hold off
    axis([0 inf 0 1.01])
    yticks([0.5 1])
    xticks([0 1 2 3 4 5])
    
    saveas(gcf,sprintf('figures/%sp73_yap.png',targets{1}));
     saveas(gcf,sprintf('figures/svg/%sp73_yap.svg',targets{1}));   
    



