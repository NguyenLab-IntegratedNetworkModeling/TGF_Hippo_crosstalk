clear all
close all
param_best = textread('Finalparamset4.txt');

load data
data_format


ICs = Hippo;
tmp_simtime=[linspace(0,5000-1,1000) 5000+[0 0.5 1 8 24]];
idx = tmp_simtime>=5000;
time2 = [0 0.5 1 8 24];
cz = 10;
time_frame = 24;

for i=1:size(param_best,1)
    
    modelparamvalue = param_best(i,1:end)';
    output=Hippo(tmp_simtime,ICs,modelparamvalue');
    
    tmp_output.variable(i,:,:) = output.variablevalues(idx,:);
    tmp_output.state(i,:,:) = output.statevalues(idx,:);
end

for i=1:size(tmp_output(1).variable,1)
    
    tmp_output2.variablevalues(i,:,:) = (tmp_output.variable(i,:,:)-min(tmp_output.variable(i,:,:)))./max(tmp_output.variable(i,:,:)-min(tmp_output.variable(i,:,:)));
    tmp_output2.statevalues(i,:,:) = (tmp_output.state(i,:,:)-min(tmp_output.state(i,:,:)))./max(tmp_output.state(i,:,:)-min(tmp_output.state(i,:,:)));
    
end

for i=1:size(tmp_output2(1).variablevalues,2)
    for j=1:size(tmp_output2(1).variablevalues,3)
        
        wt.variablevalues(i,j) = mean(tmp_output2.variablevalues(:,i,j));
        wt.statevalues(i,j) = mean(tmp_output2.statevalues(:,i,j));
        standarddv.variablevalues(i,j) = std(tmp_output2.variablevalues(:,i,j));%/sqrt(size(param_best,1));
        standarddv.statevalues(i,j) = std(tmp_output2.statevalues(:,i,j));%/sqrt(size(param_best,1));
        
    end
end

length = 100;
hight = 74;

%---psamd2
figure('Position',[1175         658         length   hight]);

x2 = [time2 ,fliplr(time2)];
lower_margin = [wt.variablevalues(:,2)-standarddv.variablevalues(:,2)]';
upper_margin = [wt.variablevalues(:,2)+standarddv.variablevalues(:,2)]';
inBetween = [lower_margin ,fliplr(upper_margin)];
h = fill(x2, inBetween,[0.26,0.32,0.42]);
h.EdgeColor = 'none';
set(h,'facealpha',.3)
hold on
plot(time2,wt.variablevalues(:,2),'color',[0.26,0.32,0.42],'linewidth',1)

scatter(time2,wt.variablevalues(:,2),cz,'MarkerFaceColor',[0.26,0.32,0.42],'MarkerEdgeColor',[0.26,0.32,0.42])

scatter(EstimData.expt.time{4}(1:end-1),(EstimData.expt.data{4}(1:end-1)-min(EstimData.expt.data{4}(1:end-1)))/max(EstimData.expt.data{4}(1:end-1)-min(EstimData.expt.data{4}(1:end-1))),cz,'MarkerFaceColor',[0.91,0.44,0.32],'MarkerEdgeColor',[0.91,0.44,0.32])
plot(EstimData.expt.time{4}(1:end-1),(EstimData.expt.data{4}(1:end-1)-min(EstimData.expt.data{4}(1:end-1)))/max(EstimData.expt.data{4}(1:end-1)-min(EstimData.expt.data{4}(1:end-1))),'color',[0.91,0.44,0.32],'linewidth',1)
set(gca,'linewidth',1)

set(gca,'fontsize',8);
hold off
box off

    xticks([0 8 16 24])
yticks([0 0.5 1])
axis([0 time_frame 0 inf])

saveas(gcf,'figures/psmad2.png')
saveas(gcf,'figures/svg/psmad2.svg')

%---RASSF1A
figure('Position',[1175         658         length   hight]);

x2 = [time2 ,fliplr(time2)];
lower_margin = [wt.variablevalues(:,3)-standarddv.variablevalues(:,3)]';
upper_margin = [wt.variablevalues(:,3)+standarddv.variablevalues(:,3)]';
inBetween = [lower_margin ,fliplr(upper_margin)];
h = fill(x2, inBetween,[0.26,0.32,0.42]);
h.EdgeColor = 'none';
set(h,'facealpha',.3)
hold on
plot(time2,wt.variablevalues(:,3),'color',[0.26,0.32,0.42],'linewidth',1)

scatter(time2,wt.variablevalues(:,3),cz,'MarkerFaceColor',[0.26,0.32,0.42],'MarkerEdgeColor',[0.26,0.32,0.42])

scatter(EstimData.expt.time{1}(1:end-1),(EstimData.expt.data{1}(1:end-1)-min(EstimData.expt.data{1}(1:end-1)))/max(EstimData.expt.data{1}(1:end-1)-min(EstimData.expt.data{1}(1:end-1))),cz,'MarkerFaceColor',[0.91,0.44,0.32],'MarkerEdgeColor',[0.91,0.44,0.32])
plot(EstimData.expt.time{1}(1:end-1),(EstimData.expt.data{1}(1:end-1)-min(EstimData.expt.data{1}(1:end-1)))/max(EstimData.expt.data{1}(1:end-1)-min(EstimData.expt.data{1}(1:end-1))),'color',[0.91,0.44,0.32],'linewidth',1)
set(gca,'linewidth',1)

set(gca,'fontsize',8);
hold off
box off

    xticks([0 8 16 24])
yticks([0 0.5 1])
axis([0 time_frame 0 inf])

saveas(gcf,'figures/RASSF1A.png')
saveas(gcf,'figures/svg/RASSF1A.svg')

%---YAP357
figure('Position',[1175         658         length   hight]);

x2 = [time2 ,fliplr(time2)];
lower_margin = [wt.variablevalues(:,7)-standarddv.variablevalues(:,7)]';
upper_margin = [wt.variablevalues(:,7)+standarddv.variablevalues(:,7)]';
inBetween = [lower_margin ,fliplr(upper_margin)];
h = fill(x2, inBetween,[0.26,0.32,0.42]);
h.EdgeColor = 'none';
set(h,'facealpha',.3)
hold on
plot(time2,wt.variablevalues(:,7),'color',[0.26,0.32,0.42],'linewidth',1)

scatter(time2,wt.variablevalues(:,7),cz,'MarkerFaceColor',[0.26,0.32,0.42],'MarkerEdgeColor',[0.26,0.32,0.42])

scatter(EstimData.expt.time{2}(1:end-1),(EstimData.expt.data{2}(1:end-1)-min(EstimData.expt.data{2}(1:end-1)))/max(EstimData.expt.data{2}(1:end-1)-min(EstimData.expt.data{2}(1:end-1))),cz,'MarkerFaceColor',[0.91,0.44,0.32],'MarkerEdgeColor',[0.91,0.44,0.32])
plot(EstimData.expt.time{2}(1:end-1),(EstimData.expt.data{2}(1:end-1)-min(EstimData.expt.data{2}(1:end-1)))/max(EstimData.expt.data{2}(1:end-1)-min(EstimData.expt.data{2}(1:end-1))),'color',[0.91,0.44,0.32],'linewidth',1)
set(gca,'linewidth',1)
set(gca,'fontsize',8);
hold off
box off

yticks([0 0.5 1])
axis([0 time_frame 0 inf])
    xticks([0 8 16 24])

saveas(gcf,'figures/YAP357.png')
saveas(gcf,'figures/svg/YAP357.svg')
%---smad7
figure('Position',[1175         658         length   hight]);

x2 = [time2 ,fliplr(time2)];
lower_margin = [wt.variablevalues(:,6)-standarddv.variablevalues(:,6)]';
upper_margin = [wt.variablevalues(:,6)+standarddv.variablevalues(:,6)]';
inBetween = [lower_margin ,fliplr(upper_margin)];
h = fill(x2, inBetween,[0.26,0.32,0.42]);
h.EdgeColor = 'none';
set(h,'facealpha',.3)
hold on
plot(time2,wt.variablevalues(:,6),'color',[0.26,0.32,0.42],'linewidth',1)

scatter(time2,wt.variablevalues(:,6),cz,'MarkerFaceColor',[0.26,0.32,0.42],'MarkerEdgeColor',[0.26,0.32,0.42])

scatter(EstimData.expt.time{3}(1:end-1),(EstimData.expt.data{3}(1:end-1)-min(EstimData.expt.data{3}(1:end-1)))/max(EstimData.expt.data{3}(1:end-1)-min(EstimData.expt.data{3}(1:end-1))),cz,'MarkerFaceColor',[0.91,0.44,0.32],'MarkerEdgeColor',[0.91,0.44,0.32])
plot(EstimData.expt.time{3}(1:end-1),(EstimData.expt.data{3}(1:end-1)-min(EstimData.expt.data{3}(1:end-1)))/max(EstimData.expt.data{3}(1:end-1)-min(EstimData.expt.data{3}(1:end-1))),'color',[0.91,0.44,0.32],'linewidth',1)
set(gca,'linewidth',1)
set(gca,'fontsize',7);
hold off
box off

yticks([0 0.5 1])
axis([0 time_frame 0 inf])
    xticks([0 8 16 24])

saveas(gcf,'figures/smad7.png')
saveas(gcf,'figures/svg/smad7.svg')

