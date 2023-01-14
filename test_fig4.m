% Script to plot Figure 4
% BY Yangkang Chen
% Jan, 2023
% This script takes about 5-10 minutes
%
% Dependency MATdrr
% svn co https://github.com/chenyk1990/MATdrr/trunk ./MATdrr 
% or git clone https://github.com/chenyk1990/MATdrr 

clc;clear;close all;
addpath(genpath('./MATdrr'));


%Mag=[2.46,1.56,0.39]
ieq=[13,19,14]

t=[0:14999]*1/250;
x=1:800;

names=dir('*.mat');

%% load data
ii=ieq(1);
name1=names(ii).name;
load(name1);eq1=data;
load(sprintf('processed/eq%d.mat',ii));dmrr1=datatt;

ii=ieq(2);
name2=names(ii).name;
load(name2);eq2=data;
load(sprintf('processed/eq%d.mat',ii));dmrr2=datatt;

ii=ieq(3);
name3=names(ii).name;
load(name3);eq3=data;
load(sprintf('processed/eq%d.mat',ii));dmrr3=datatt;



%%Cmax
v=linspace(-0.0013,0.0013,100);
% v=linspace(-0.0002,0.0002,200);
Param.v=v;
Param.nt=14999;
Param.h=[0:800-1];
Param.dt=1/250.0;
Param.type=1;
Param.oper=-1;
craw1=yc_coh(eq1',Param);
cmrr1=yc_coh(dmrr1',Param);

craw2=yc_coh(eq2',Param);
cmrr2=yc_coh(dmrr2',Param);

craw3=yc_coh(eq3',Param);
cmrr3=yc_coh(dmrr3',Param);


figure('units','normalized','Position',[0.2 0.4 0.8, 1],'color','w');
ax1=subplot(3,2,1);
yc_imagesc(eq1,95,1,t,x);colormap(ax1,seis);
title(name1,'Interpreter', 'none','Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'a)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');


ax2=subplot(3,2,2);
yc_imagesc(dmrr1,95,1,t,x);colormap(ax2,seis);
title(strcat('Denoised (Cmax:'," ",num2str(max(abs(craw1(:)))),'->',num2str(max(abs(cmrr1(:)))),')'),'Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
% ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'b)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

ax1=subplot(3,2,3);
yc_imagesc(eq2,95,1,t,x);colormap(ax1,seis);
title(name2,'Interpreter', 'none','Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'c)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');


ax2=subplot(3,2,4);
yc_imagesc(dmrr2,95,1,t,x);colormap(ax2,seis);
title(strcat('Denoised (Cmax:'," ",num2str(max(abs(craw2(:)))),'->',num2str(max(abs(cmrr2(:)))),')'),'Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
% ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'d)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

ax1=subplot(3,2,5);
yc_imagesc(eq3,95,1,t,x);colormap(ax1,seis);
title(name3,'Interpreter', 'none','Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'e)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');


ax2=subplot(3,2,6);
yc_imagesc(dmrr3,95,1,t,x);colormap(ax2,seis);
title(strcat('Denoised (Cmax:'," ",num2str(max(abs(craw3(:)))),'->',num2str(max(abs(cmrr3(:)))),')'),'Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
% ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'f)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');


print(gcf,'-depsc','-r300','fig4.eps');



