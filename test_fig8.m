% Script to plot Figure 8
% BY Yangkang Chen
% Jan, 2023
% This script takes about 60 minutes
%
% Dependency MATdrr
% svn co https://github.com/aaspip/MATdrr/trunk ./MATdrr
% or git clone https://github.com/aaspip/MATdrr ./

clc;clear;close all;
addpath(genpath('./MATdrr'));
addpath(genpath('./'));

%Mag=[2.46,1.56,0.39]
% ieq=[2,5,6,7,15,21,22,25];
ieq=[5,6,7,21,22,25];

%% ieq=15 is the 2017-07-01T03:15:13.538000Z_magUNKNOWN.mat

t=[0:14999]*1/250;
x=1:800;

names=dir('raw/*.mat');

%% coherency
nt=14999;
nx=800;
v=linspace(-0.0013,0.0013,100);
% v=linspace(-0.0002,0.0002,200);
Param.v=v;
Param.nt=nt;
Param.h=[0:nx-1];
Param.dt=1/250.0;
Param.type=1;
Param.oper=-1;

%% parameters for MRR
n1win=512;n2win=200;n3win=1;
r1=0.5;r2=0.5;r3=0.5;

ii=1;
jj=ieq(ii);
name1=names(jj).name;
load(strcat(names(jj).folder,'/',names(jj).name));
eq1=data;
dbpmf1=das_mf(das_bandpass(data',1/250,0,20)',5,1,1);
% load(sprintf('processed/eq%d.mat',jj));dbpmfmrr1=d_bpmfmrr;
dbpmfmrr1=drr3d_win(dbpmf1',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

ii=2;
jj=ieq(ii);
name2=names(jj).name;
load(strcat(names(jj).folder,'/',names(jj).name));
eq2=data;
dbpmf2=das_mf(das_bandpass(data',1/250,0,20)',5,1,1);
% load(sprintf('processed/eq%d.mat',jj));dbpmfmrr2=d_bpmfmrr;
dbpmfmrr2=drr3d_win(dbpmf2',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

ii=3;
jj=ieq(ii);
name3=names(jj).name;
load(strcat(names(jj).folder,'/',names(jj).name));
eq3=data;
dbpmf3=das_mf(das_bandpass(data',1/250,0,20)',5,1,1);
% load(sprintf('processed/eq%d.mat',jj));dbpmfmrr3=d_bpmfmrr;
dbpmfmrr3=drr3d_win(dbpmf3',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

ii=4;
jj=ieq(ii);
name4=names(jj).name;
load(strcat(names(jj).folder,'/',names(jj).name));
eq4=data;
dbpmf4=das_mf(das_bandpass(data',1/250,0,20)',5,1,1);
% load(sprintf('processed/eq%d.mat',jj));dbpmfmrr4=d_bpmfmrr;
dbpmfmrr4=drr3d_win(dbpmf4',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

ii=5;
jj=ieq(ii);
name5=names(jj).name;
load(strcat(names(jj).folder,'/',names(jj).name));
eq5=data;
dbpmf5=das_mf(das_bandpass(data',1/250,0,20)',5,1,1);
% load(sprintf('processed/eq%d.mat',jj));dbpmfmrr5=d_bpmfmrr;
dbpmfmrr5=drr3d_win(dbpmf5',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

ii=6;
jj=ieq(ii);
name6=names(jj).name;
load(strcat(names(jj).folder,'/',names(jj).name));
eq6=data;
dbpmf6=das_mf(das_bandpass(data',1/250,0,20)',5,1,1);
% load(sprintf('processed/eq%d.mat',jj));dbpmfmrr6=d_bpmfmrr;
dbpmfmrr6=drr3d_win(dbpmf6',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

%% run from this line
figure('units','normalized','Position',[0.2 0.4 0.8, 1],'color','w');
tiledlayout(6,5,'TileSpacing','Compact','Padding','Compact');
nexttile;
das_imagesc(eq1,95,1,t,x);title(name1,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'a)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
das_imagesc(dbpmf1,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
das_framebox(x1,x2,y1,y2,'g',2);
nexttile;
das_imagesc(dbpmfmrr1,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
das_framebox(x1,x2,y1,y2,'r',2);
nexttile;
das_imagesc(dbpmf1,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
das_imagesc(dbpmfmrr1,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[16,100];
ap2=[13,150];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');

nexttile;
das_imagesc(eq2,95,1,t,x);title(name2,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'b)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
das_imagesc(dbpmf2,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
das_framebox(x1,x2,y1,y2,'g',2);
nexttile;
das_imagesc(dbpmfmrr2,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
das_framebox(x1,x2,y1,y2,'r',2);
nexttile;
das_imagesc(dbpmf2,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
das_imagesc(dbpmfmrr2,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[18,50];
ap2=[14,100];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


nexttile;
das_imagesc(eq3,95,1,t,x);title(name3,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'c)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
das_imagesc(dbpmf3,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
das_framebox(x1,x2,y1,y2,'g',2);
nexttile;
das_imagesc(dbpmfmrr3,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
das_framebox(x1,x2,y1,y2,'r',2);
nexttile;
das_imagesc(dbpmf3,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
das_imagesc(dbpmfmrr3,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[17,50];
ap2=[14,100];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


nexttile;
das_imagesc(eq4,95,1,t,x);title(name4,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'d)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
das_imagesc(dbpmf4,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
das_framebox(x1,x2,y1,y2,'g',2);
nexttile;
das_imagesc(dbpmfmrr4,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
das_framebox(x1,x2,y1,y2,'r',2);
nexttile;
das_imagesc(dbpmf4,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
das_imagesc(dbpmfmrr4,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[18,50];
ap2=[13.5,100];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


nexttile;
das_imagesc(eq5,95,1,t,x);title(name5,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'e)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
das_imagesc(dbpmf5,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
das_framebox(x1,x2,y1,y2,'g',2);
nexttile;
das_imagesc(dbpmfmrr5,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
das_framebox(x1,x2,y1,y2,'r',2);
nexttile;
das_imagesc(dbpmf5,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
das_imagesc(dbpmfmrr5,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[22,50];
ap2=[15,100];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


nexttile;
das_imagesc(eq6,95,1,t,x);title(name6,'Interpreter', 'none','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');ylabel('Channel','Fontsize',10,'fontweight','bold');
text(-10,-100,'f)','color','k','Fontsize',16,'fontweight','bold','HorizontalAlignment','center');
nexttile;
das_imagesc(dbpmf6,95,1,t,x);title('Denoised (BP+MF)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');
x1=5;x2=30;y1=2;y2=200;
das_framebox(x1,x2,y1,y2,'g',2);
nexttile;
das_imagesc(dbpmfmrr6,95,1,t,x);title('Denoised (BP+MF+MRR)','Fontsize',10,'fontweight','bold');set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');
das_framebox(x1,x2,y1,y2,'r',2);
nexttile;
das_imagesc(dbpmf6,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF)','Fontsize',10,'fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','g','ycolor','g');
nexttile;
das_imagesc(dbpmfmrr6,95,1,t,x);xlim([x1,x2]);ylim([y1,y2]);title('Zoomed (BP+MF+MRR)','Fontsize',10,'fontweight','bold');xlabel('Time (s)','Fontsize',10,'fontweight','bold');%hold on;plot(t(6430)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold','xcolor','r','ycolor','r');
ap1=[15,70];
ap2=[12,100];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Detection due to MRR','linewidth',2,'Fontsize',12,'fontweight','bold','color','r','HorizontalAlignment','center');


print(gcf,'-depsc','-r300','fig8.eps');





