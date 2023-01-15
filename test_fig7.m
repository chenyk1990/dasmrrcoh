% Script to plot Figure 7
% BY Yangkang Chen
% Jan, 2023
% This script takes about 10 minutes
%
% Dependency MATdrr
% svn co https://github.com/chenyk1990/MATdrr/trunk ./MATdrr 
% or git clone https://github.com/chenyk1990/MATdrr 

clc;clear;close all;
addpath(genpath('./MATdrr'));
addpath(genpath('./'));

names=dir('raw/*.mat');

jj=7;
for ii=7:7
    name3=names(ii).name;
    load(strcat(names(ii).folder,'/',names(ii).name));
    eq1=data;

    if ii==12
        data(find(isnan(data)))=0;
    end

    if ii==13
        data(:,7200:7221)=0;
        data(:,7150:7271)=das_mf(data(:,7150:7271),40,1,2);
        data(:,7150:7271)=das_meanf(data(:,7150:7271),40,1,2);
    end

    eq=data;
    d_bp=das_bandpass(eq',1/250,0,20)';
    d_bpmf=das_mf(d_bp,5,1,1);
    %% MRR
    n1win=512;n2win=200;n3win=1;
    r1=0.5;r2=0.5;r3=0.5;
    d_bpmfmrr=drr3d_win(d_bpmf',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';
    d_bpmfmrr=single(d_bpmfmrr);
    save('processed/eq7.mat','d_bpmfmrr');
    fprintf('event %d/%d is done\n',ii,length(names));
    %     close gcf;
end



t=[0:14999]*1/250;
x=1:800;

nt=14999;
nx=length(x);

v=linspace(-0.0013,0.0013,100);
% v=linspace(-0.0002,0.0002,200);
Param.v=v;
Param.nt=nt;
Param.h=[0:nx-1];
Param.dt=1/250.0;
Param.type=1;
Param.oper=-1;

c_raw=das_coh(eq',Param);
% c_bp=das_coh(d_bp,Param);
c_bpmf=das_coh(d_bpmf',Param);
c_bpmfmrr=das_coh(d_bpmfmrr',Param);

%% picking
addpath(genpath('~/dasdenoising'));
nsta=30;nlta=300;
[ O,R ] = das_picker_stalta(d_bpmfmrr',nsta, nlta);
[ O2,R ] = das_picker_stalta(d_bpmf',nsta, nlta);


figure('units','normalized','Position',[0.2 0.4 0.8, 1],'color','w');
ax=subplot(3,2,1);
das_imagesc(eq,95,1,t,x);colormap(ax,seis);xlim([0,60]);
title(name3,'Interpreter', 'none','Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'a)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

ax=subplot(3,2,3);
das_imagesc(d_bpmf,95,1,t,x);colormap(ax,seis);title('BP+MF');xlim([0,60]);
title('BP+MF','Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'c)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
hold on;plot(O2/250,x,'o','color','g','linewidth',2);legend('STA/LTA','Location','Best');

ax=subplot(3,2,5);
das_imagesc(d_bpmfmrr,95,1,t,x);colormap(ax,seis);title('BP+MF');xlim([0,60]);
title('BP+MF+MRR','Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'e)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
hold on;
% plot(t(3672)*ones(1,2),[max(x),min(x)],'--','color','k','linewidth',2)
plot(O/250,x,'o','color','g','linewidth',2);
plot(t(3672)+x*v(37),x,'--','color','r','linewidth',2);legend('STA/LTA','Coherency','Location','Best');

ax2=subplot(3,2,2);
imagesc(t,v,c_raw'*10);colormap(ax2,jet);caxis([0,0.5]);xlim([0,60]);
title(strcat('Raw Cmax=',num2str(max(abs(c_raw(:))))),'Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Slope','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,min(v)-(max(v)-min(v))/(max(x)-min(x))*100,'b)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

ax4=subplot(3,2,4);
imagesc(t,v,c_bpmf');colormap(ax4,jet);caxis([0,0.5]);xlim([0,60]);
title(strcat('BP+MF Cmax=',num2str(max(abs(c_bpmf(:))))),'Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Slope','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,min(v)-(max(v)-min(v))/(max(x)-min(x))*100,'d)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

ax6=subplot(3,2,6);
imagesc(t,v,c_bpmfmrr');colormap(ax6,jet);caxis([0,0.5]);xlim([0,60]);
title(strcat('BP+MF+MRR Cmax=',num2str(max(abs(c_bpmfmrr(:))))),'Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Slope','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,min(v)-(max(v)-min(v))/(max(x)-min(x))*100,'f)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
hold on;plot(t(3672)*ones(1,2),[max(v),min(v)],'--','color','r','linewidth',2)
plot([min(t),max(t)],v(40)*ones(1,2),'--','color','r','linewidth',2)
plot(t(3672),v(40),'o','color','r','linewidth',2)
text(t(3672)+4,v(40)-0.0002,'Cmax','color','r','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

print(gcf,'-depsc','-r300','fig7.eps');








