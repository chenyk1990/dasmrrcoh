% Script to plot Figure 6
% BY Yangkang Chen
% March, 2023
% This script takes about 10 minutes
%
% Dependency MATdrr
% svn co https://github.com/aaspip/MATdrr/trunk ./MATdrr
% or git clone https://github.com/aaspip/MATdrr ./

clc;clear;close all;
addpath(genpath('./MATdrr'));
addpath(genpath('./'));

ii=31;
load(sprintf('processed/eq%d.mat',ii));
d_ldrr=d_bpmfmrr;
dtmp=d_ldrr';
indx=1:800;

Param.h=[0:length(indx)-1];
Param.dt=1/250;dt=1/250;
Param.type=1;
v=linspace(-0.0013,0.0013,100);
% v=linspace(-0.0020,0.0020,200);
Param.v=v;
Param.nt=1000;
t1=das_coh(dtmp(1:1000,indx),Param);
t2=das_coh(dtmp([1:1000]+1000,indx),Param);
t3=das_coh(dtmp([1:1000]+2000,indx),Param);
t4=das_coh(dtmp([1:1000]+3000,indx),Param);
t5=das_coh(dtmp([1:1000]+4000,indx),Param);
t6=das_coh(dtmp([1:1000]+5000,indx),Param);
t7=das_coh(dtmp([1:1000]+6000,indx),Param);
t8=das_coh(dtmp([1:1000]+7000,indx),Param);
t9=das_coh(dtmp([1:1000]+8000,indx),Param);
t10=das_coh(dtmp([1:1000]+9000,indx),Param);


figure('units','normalized','Position',[0.2 0.4 0.7, 1],'color','w');
ax=subplot(4,5,1);iw=0;
das_imagesc2(dtmp([1:1000],indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);ylabel('Time sample','Fontsize',14,'fontweight','bold');
title('Window 1');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-300,-150,'a)','color','k','Fontsize',30,'fontweight','bold','HorizontalAlignment','center');

ax=subplot(4,5,2);iw=1;
das_imagesc2(dtmp([1:1000]+1000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);
title('Window 2');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,3);iw=2;
das_imagesc2(dtmp([1:1000]+2000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);f1=das_ap2fp([300,2790]);f2=das_ap2fp([300,2600]);annotation('textarrow',[f2(1),f1(1)],[f2(2),f1(2)],'String','P','color','r','linewidth',2,'Fontsize',20,'fontweight','bold');f1=das_ap2fp([600,2900]);f2=das_ap2fp([600,2600]);annotation('textarrow',[f2(1),f1(1)],[f2(2),f1(2)],'String','S','color','r','linewidth',2,'Fontsize',20,'fontweight','bold');
title('Window 3');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,4);iw=3;
das_imagesc2(dtmp([1:1000]+3000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);f1=das_ap2fp([300,3400]);f2=das_ap2fp([400,3600]);annotation('textarrow',[f2(1),f1(1)],[f2(2),f1(2)],'String','Signal','color','r','linewidth',2,'Fontsize',20,'fontweight','bold');
title('Window 4');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,5);iw=4;
das_imagesc2(dtmp([1:1000]+4000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);f1=das_ap2fp([300,4200]);f2=das_ap2fp([400,4400]);annotation('textarrow',[f2(1),f1(1)],[f2(2),f1(2)],'String','Signal','color','r','linewidth',2,'Fontsize',20,'fontweight','bold');
title('Window 5');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,6);iw=5;
das_imagesc2(dtmp([1:1000]+5000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);ylabel('Time sample','Fontsize',14,'fontweight','bold');
title('Window 6');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,7);iw=6;
das_imagesc2(dtmp([1:1000]+6000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);
title('Window 7');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,8);iw=7;
das_imagesc2(dtmp([1:1000]+7000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);
title('Window 8');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,9);iw=8;;
das_imagesc2(dtmp([1:1000]+8000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);
title('Window 9');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,10);iw=9;
das_imagesc2(dtmp([1:1000]+9000,indx),98,1,indx,[1:1000]+1000*iw);colormap(ax,seis);
title('Window 10');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');


% figure('units','normalized','Position',[0.2 0.4 1, 0.9],'color','w');

ax=subplot(4,5,11);iw=0;
indv=1:100;
das_imagesc2(t1,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t1(:))))));set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');ylabel('Time sample','Fontsize',14,'fontweight','bold');
text(-37,-150,'b)','color','k','Fontsize',30,'fontweight','bold','HorizontalAlignment','center');

ax=subplot(4,5,12);iw=1;
das_imagesc2(t2,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t2(:))))));set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,13);iw=2;
das_imagesc2(t3,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t3(:))))),'color','r');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,14);iw=3;
das_imagesc2(t4,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t4(:))))),'color','r');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,15);iw=4;
das_imagesc2(t5,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t5(:))))),'color','r');set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
ax=subplot(4,5,16);iw=5;
das_imagesc2(t6,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t6(:))))));set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');xlabel('Trace','Fontsize',14,'fontweight','bold');ylabel('Time sample','Fontsize',14,'fontweight','bold');
ax=subplot(4,5,17);iw=6;
das_imagesc2(t7,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t7(:))))));set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');xlabel('Trace','Fontsize',14,'fontweight','bold');
ax=subplot(4,5,18);iw=7;
das_imagesc2(t8,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t8(:))))));set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');xlabel('Trace','Fontsize',14,'fontweight','bold');
ax=subplot(4,5,19);iw=8;
das_imagesc2(t9,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t9(:))))));set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');xlabel('Trace','Fontsize',14,'fontweight','bold');
ax=subplot(4,5,20);iw=9;
das_imagesc2(t10,98,1,indv,[1:1000]+1000*iw);colormap(ax,jet);caxis([0,1]);
title(strcat('Cmax=',num2str(max(abs(t10(:))))));set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');xlabel('Trace','Fontsize',14,'fontweight','bold');
cb=colorbar;
set(cb,'Position',[0.92,0.25 0.01 0.1])

print(gcf,'-depsc','-r300','fig6.eps');


