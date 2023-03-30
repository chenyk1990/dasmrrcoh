% Script to plot Figure 5
% BY Yangkang Chen
% Jan, 2023
% This script takes about 30 minutes
%
% Dependency MATdrr
% svn co https://github.com/aaspip/MATdrr/trunk ./MATdrr
% or git clone https://github.com/aaspip/MATdrr ./

clc;clear;close all;
addpath(genpath('./MATdrr'));
addpath(genpath('./'));


%Mag=[2.46,1.56,0.39]
ieq=[13,19,14]

t=[0:14999]*1/250;
x=1:800;

names=dir('raw/*.mat');

%% first
for ii=ieq(1):ieq(1)
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
    %% LDRR
    n1win=1024;n2win=800;n3win=1;
    n1win=512;n2win=200;n3win=1;
    r1=0.5;r2=0.5;r3=0.5;
    d_bpmfmrr=drr3d_win(d_bpmf',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

    save(sprintf('processed/eq%d.mat',ii),'d_bp','d_bpmf','d_bpmfmrr');

    fprintf('event %d/%d is done\n',ii,length(names));
    %     close gcf;
end
name1=names(ieq(1)).name;
dmrr1=d_bpmfmrr;

%% second
for ii=ieq(2):ieq(2)
    load(strcat(names(ii).folder,'/',names(ii).name));
    eq2=data;

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
    %% LDRR
    n1win=1024;n2win=800;n3win=1;
    n1win=512;n2win=200;n3win=1;
    r1=0.5;r2=0.5;r3=0.5;
    d_bpmfmrr=drr3d_win(d_bpmf',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

    save(sprintf('processed/eq%d.mat',ii),'d_bp','d_bpmf','d_bpmfmrr');

    fprintf('event %d/%d is done\n',ii,length(names));
    %     close gcf;
end
name2=names(ieq(2)).name;
dmrr2=d_bpmfmrr;

%% third
for ii=ieq(3):ieq(3)
    load(strcat(names(ii).folder,'/',names(ii).name));
    eq3=data;

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
    %% LDRR
    n1win=1024;n2win=800;n3win=1;
    n1win=512;n2win=200;n3win=1;
    r1=0.5;r2=0.5;r3=0.5;
    d_bpmfmrr=drr3d_win(d_bpmf',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

    save(sprintf('processed/eq%d.mat',ii),'d_bp','d_bpmf','d_bpmfmrr');

    fprintf('event %d/%d is done\n',ii,length(names));
    %     close gcf;
end
name3=names(ieq(3)).name;
dmrr3=d_bpmfmrr;


%%Cmax
v=linspace(-0.0013,0.0013,100);
% v=linspace(-0.0002,0.0002,200);
Param.v=v;
Param.nt=14999;
Param.h=[0:800-1];
Param.dt=1/250.0;
Param.type=1;
Param.oper=-1;
craw1=das_coh(eq1',Param);
cmrr1=das_coh(dmrr1',Param);

craw2=das_coh(eq2',Param);
cmrr2=das_coh(dmrr2',Param);

craw3=das_coh(eq3',Param);
cmrr3=das_coh(dmrr3',Param);


figure('units','normalized','Position',[0.2 0.4 0.8, 1],'color','w');
ax1=subplot(3,4,1);
yc_imagesc(eq1,95,1,t,x);colormap(ax1,seis);
title(name1,'Interpreter', 'none','Fontsize',10,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(-10,-120,'a)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
yc_framebox(7,11,2,799,'r',2);

ax2=subplot(3,4,2);
yc_imagesc(dmrr1,95,1,t,x);colormap(ax2,seis);
title(strcat('Denoised (Cmax:'," ",num2str(max(abs(craw1(:)))),'->',num2str(max(abs(cmrr1(:)))),')'),'Fontsize',6,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
% ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
yc_framebox(7,11,2,799,'r',2);

ax1=subplot(3,4,3);
yc_imagesc(eq1,98,1,t,x);colormap(ax1,seis);
title('Raw','Interpreter', 'none','Fontsize',10,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
% ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
% text(-5,-100,'a)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
xlim([7,11]);

ax2=subplot(3,4,4);
yc_imagesc(dmrr1,98,1,t,x);colormap(ax2,seis);
title('Denoised','Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
% ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
% text(-5,-100,'b)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
xlim([7,11]);


ax1=subplot(3,4,5);
yc_imagesc(eq2,95,1,t,x);colormap(ax1,seis);
title(name2,'Interpreter', 'none','Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(-10,-120,'b)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
yc_framebox(10,13,2,799,'r',2);

ax2=subplot(3,4,6);
yc_imagesc(dmrr2,95,1,t,x);colormap(ax2,seis);
title(strcat('Denoised (Cmax:'," ",num2str(max(abs(craw2(:)))),'->',num2str(max(abs(cmrr2(:)))),')'),'Fontsize',14,'fontweight','bold');
% xlabel('Time (s)','Fontsize',14,'fontweight','bold');
% ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
yc_framebox(10,13,2,799,'r',2);

ax1=subplot(3,4,7);
yc_imagesc(eq2,99,1,t,x);colormap(ax1,seis);
title('Raw','Interpreter', 'none','Fontsize',10,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
xlim([10,13]);

ax2=subplot(3,4,8);
yc_imagesc(dmrr2,99,1,t,x);colormap(ax2,seis);
title('Denoised','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
xlim([10,13]);


ax1=subplot(3,4,9);
yc_imagesc(eq3,95,1,t,x);colormap(ax1,seis);
title(name3,'Interpreter', 'none','Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
text(-10,-120,'c)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
yc_framebox(10,15,2,799,'r',2);


ax2=subplot(3,4,10);
yc_imagesc(dmrr3,95,1,t,x);colormap(ax2,seis);
title(strcat('Denoised (Cmax:'," ",num2str(max(abs(craw3(:)))),'->',num2str(max(abs(cmrr3(:)))),')'),'Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
% ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
yc_framebox(10,15,2,799,'r',2);

ax1=subplot(3,4,11);
yc_imagesc(eq3,98,1,t,x);colormap(ax1,seis);
title('Raw','Interpreter', 'none','Fontsize',10,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');

xlim([10,15]);

ax2=subplot(3,4,12);
yc_imagesc(dmrr3,98,1,t,x);colormap(ax2,seis);
title('Denoised','Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',10,'Fontweight','bold');
xlim([10,15]);

print(gcf,'-depsc','-r300','fig5.eps');



