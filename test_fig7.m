% Script to plot Figure 7
% BY Yangkang Chen
% Jan, 2023
% This script takes about 5-10 minutes
%
% Dependency MATdrr
% svn co https://github.com/chenyk1990/MATdrr/trunk ./MATdrr 
% or git clone https://github.com/chenyk1990/MATdrr 

clc;clear;close all;
addpath(genpath('./MATdrr'));

clc;clear;close all;


names=dir('*.mat');

jj=7;

name3=names(jj).name;
load(name3);eq3=data;
dbpmf3=yc_mf(yc_bandpass(data',1/250,0,20)',5,1,1);
load(sprintf('processed/eq%d.mat',jj));dbpmfmrr3=datatt;

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

c_raw=yc_coh(eq3',Param);
% c_bp=yc_coh(d_bp,Param);
c_bpmf=yc_coh(dbpmf3',Param);
c_bpmfmrr=yc_coh(dbpmfmrr3',Param);

%% picking
addpath(genpath('~/dasdenoising'));
nsta=30;nlta=300;
[ O,R ] = das_picker_stalta(dbpmfmrr3',nsta, nlta);
[ O2,R ] = das_picker_stalta(dbpmf3',nsta, nlta);


figure('units','normalized','Position',[0.2 0.4 0.8, 1],'color','w');
ax=subplot(3,2,1);
yc_imagesc(eq3,95,1,t,x);colormap(ax,seis);xlim([0,60]);
title(name3,'Interpreter', 'none','Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'a)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

ax=subplot(3,2,3);
yc_imagesc(dbpmf3,95,1,t,x);colormap(ax,seis);title('BP+MF');xlim([0,60]);
title('BP+MF','Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'c)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
hold on;plot(O2/250,x,'o','color','g','linewidth',2);legend('STA/LTA','Location','Best');

ax=subplot(3,2,5);
yc_imagesc(dbpmfmrr3,95,1,t,x);colormap(ax,seis);title('BP+MF');xlim([0,60]);
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



%% find Cmax

% yc_attr(abs(c_bpmfmrr(1:5000,:)));
%3672
%40
% tmp=yc_meanf(yc_meanf(abs(c_bpmfmrr(1:5000,:)),5,1,1),5,1,2);
% yc_attr(tmp)

%3672,37






