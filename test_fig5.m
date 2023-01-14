% Script to plot Figure 5
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
ieq=[2,5,6,7,15,21,22,25];

ieq=[5,6,7,21,22,25];

%% ieq=15 is the 2017-07-01T03:15:13.538000Z_magUNKNOWN.mat

names=dir('*.mat');

%% coherency
ii=ieq(1);
name=names(ii).name;
load(name);
[n1,n2]=size(data);
t=[0:n2-1]*(1/250);
x=1:n1;

nt=n2;
nx=n1;
v=linspace(-0.0013,0.0013,100);
% v=linspace(-0.0002,0.0002,200);
Param.v=v;
Param.nt=nt;
Param.h=[0:nx-1];
Param.dt=1/250.0;
Param.type=1;
Param.oper=-1;


% for ii=1:6
%     jj=ieq(ii);
%     name=names(jj).name;
%     load(name);
%     figure('units','normalized','Position',[0.2 0.4 0.8, 0.7],'color','w');
% 
%     subplot(2,2,1);
%     c0=yc_coh(data',Param);
%     yc_imagesc(c0',95,1,t,x);colormap(jet);colorbar;caxis([0,0.8]);
%     title(strcat('Cmax=',num2str(max(abs(c0(:))))));
% 
%     data=yc_bandpass(data',1/250,0,20)';
%     datat=yyc_mf(data,5,1,1);
% 
%     subplot(2,2,2);
%     c1=yc_coh(data',Param);
%     yc_imagesc(c1',95,1,t,x);colormap(jet);colorbar;caxis([0,0.8]);
%     title(strcat('Cmax=',num2str(max(abs(c1(:))))));
% 
%     subplot(2,2,3);
%     c2=yc_coh(datat',Param);
%     yc_imagesc(c2',95,1,t,x);colormap(jet);colorbar;caxis([0,0.8]);
%     title(strcat('Cmax=',num2str(max(abs(c2(:))))));
%     load(sprintf('processed/eq%d.mat',ii));
% 
%     subplot(2,2,4);
%     load(sprintf('processed/eq%d.mat',ii));
%     c3=yc_coh(datatt',Param);
%     yc_imagesc(c3',95,1,t,x);colormap(jet);colorbar;caxis([0,0.8]);
%     title(strcat('Cmax=',num2str(max(abs(c3(:))))));
% 
%     print(gcf,'-depsc','-r300',sprintf('miss_%d.eps',ii));
% 
% end

ii=1;
jj=ieq(ii);
name1=names(jj).name;
load(name1);eq1=data;
dbpmf1=yc_mf(yc_bandpass(data',1/250,0,20)',5,1,1);
load(sprintf('processed/eq%d.mat',jj));dbpmfmrr1=datatt;

ii=2;
jj=ieq(ii);
name2=names(jj).name;
load(name2);eq2=data;
dbpmf2=yc_mf(yc_bandpass(data',1/250,0,20)',5,1,1);
load(sprintf('processed/eq%d.mat',jj));dbpmfmrr2=datatt;

ii=3;
jj=ieq(ii);
name3=names(jj).name;
load(name3);eq3=data;
dbpmf3=yc_mf(yc_bandpass(data',1/250,0,20)',5,1,1);
load(sprintf('processed/eq%d.mat',jj));dbpmfmrr3=datatt;

ii=4;
jj=ieq(ii);
name4=names(jj).name;
load(name4);eq4=data;
dbpmf4=yc_mf(yc_bandpass(data',1/250,0,20)',5,1,1);
load(sprintf('processed/eq%d.mat',jj));dbpmfmrr4=datatt;

ii=5;
jj=ieq(ii);
name5=names(jj).name;
load(name5);eq5=data;
dbpmf5=yc_mf(yc_bandpass(data',1/250,0,20)',5,1,1);
load(sprintf('processed/eq%d.mat',jj));dbpmfmrr5=datatt;

ii=6;
jj=ieq(ii);
name6=names(jj).name;
load(name6);eq6=data;
dbpmf6=yc_mf(yc_bandpass(data',1/250,0,20)',5,1,1);
load(sprintf('processed/eq%d.mat',jj));dbpmfmrr6=datatt;


t=[0:14999]*1/250;
x=1:800;

% figure('units','normalized','Position',[0.2 0.4 0.8, 1],'color','w');
% subplot(6,3,1);
% yc_imagesc(eq1,95,1,t,x);
% subplot(6,3,2);
% yc_imagesc(dbpmf1,95,1,t,x);
% subplot(6,3,3);
% yc_imagesc(dbpmfmrr1,95,1,t,x);
% 
% subplot(6,3,4);
% yc_imagesc(eq2,95,1,t,x);
% subplot(6,3,5);
% yc_imagesc(dbpmf2,95,1,t,x);
% subplot(6,3,6);
% yc_imagesc(dbpmfmrr2,95,1,t,x);
% 
% subplot(6,3,7);
% yc_imagesc(eq3,95,1,t,x);
% subplot(6,3,8);
% yc_imagesc(dbpmf3,95,1,t,x);
% subplot(6,3,9);
% yc_imagesc(dbpmfmrr3,95,1,t,x);
% 
% subplot(6,3,10);
% yc_imagesc(eq4,95,1,t,x);
% subplot(6,3,11);
% yc_imagesc(dbpmf4,95,1,t,x);
% subplot(6,3,12);
% yc_imagesc(dbpmfmrr4,95,1,t,x);
% 
% subplot(6,3,13);
% yc_imagesc(eq5,95,1,t,x);
% subplot(6,3,14);
% yc_imagesc(dbpmf5,95,1,t,x);
% subplot(6,3,15);
% yc_imagesc(dbpmfmrr5,95,1,t,x);
% 
% subplot(6,3,16);
% yc_imagesc(eq6,95,1,t,x);
% subplot(6,3,17);
% yc_imagesc(dbpmf6,95,1,t,x);
% subplot(6,3,18);
% yc_imagesc(dbpmfmrr6,95,1,t,x);
% 
% print(gcf,'-depsc','-r300','figmiss.eps');


%% run from this line
figure('units','normalized','Position',[0.2 0.4 0.8, 1],'color','w');
tiledlayout(6,5,'TileSpacing','Compact','Padding','Compact');
nexttile;
yc_imagesc(eq1,95,1,t,x);title(name1,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'a)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
yc_imagesc(dbpmf1,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
yc_framebox(x1,x2,y1,y2,'g',2);
nexttile;
yc_imagesc(dbpmfmrr1,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
yc_framebox(x1,x2,y1,y2,'r',2);
nexttile;
yc_imagesc(dbpmf1,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
yc_imagesc(dbpmfmrr1,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[16,100];
ap2=[13,150];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');

nexttile;
yc_imagesc(eq2,95,1,t,x);title(name2,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'b)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
yc_imagesc(dbpmf2,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
yc_framebox(x1,x2,y1,y2,'g',2);
nexttile;
yc_imagesc(dbpmfmrr2,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
yc_framebox(x1,x2,y1,y2,'r',2);
nexttile;
yc_imagesc(dbpmf2,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
yc_imagesc(dbpmfmrr2,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[18,50];
ap2=[14,100];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


nexttile;
yc_imagesc(eq3,95,1,t,x);title(name3,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'c)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
yc_imagesc(dbpmf3,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
yc_framebox(x1,x2,y1,y2,'g',2);
nexttile;
yc_imagesc(dbpmfmrr3,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
yc_framebox(x1,x2,y1,y2,'r',2);
nexttile;
yc_imagesc(dbpmf3,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
yc_imagesc(dbpmfmrr3,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[17,50];
ap2=[14,100];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


nexttile;
yc_imagesc(eq4,95,1,t,x);title(name4,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'d)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
yc_imagesc(dbpmf4,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
yc_framebox(x1,x2,y1,y2,'g',2);
nexttile;
yc_imagesc(dbpmfmrr4,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
yc_framebox(x1,x2,y1,y2,'r',2);
nexttile;
yc_imagesc(dbpmf4,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
yc_imagesc(dbpmfmrr4,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[18,50];
ap2=[13.5,100];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


nexttile;
yc_imagesc(eq5,95,1,t,x);title(name5,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'e)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
yc_imagesc(dbpmf5,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
yc_framebox(x1,x2,y1,y2,'g',2);
nexttile;
yc_imagesc(dbpmfmrr5,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
yc_framebox(x1,x2,y1,y2,'r',2);
nexttile;
yc_imagesc(dbpmf5,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
yc_imagesc(dbpmfmrr5,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[22,50];
ap2=[15,100];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


nexttile;
yc_imagesc(eq6,95,1,t,x);title(name6,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'f)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
yc_imagesc(dbpmf6,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
yc_framebox(x1,x2,y1,y2,'g',2);
nexttile;
yc_imagesc(dbpmfmrr6,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');
yc_framebox(x1,x2,y1,y2,'r',2);
nexttile;
yc_imagesc(dbpmf6,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
yc_imagesc(dbpmfmrr6,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[15,70];
ap2=[12,100];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


print(gcf,'-depsc','-r300','fig5.eps');








% tmp=yc_meanf(yc_meanf(cmrr1,5,1,1),5,1,2);%
% figure;imagesc(cmrr1');
% cmrr1=yc_coh(dbpmfmrr1',Param);
% figure;imagesc(cmrr1');


