% Script to plot Figure 6
% BY Yangkang Chen
% Jan, 2023
% This script takes about 6 hours?
%
% Dependency MATdrr
% svn co https://github.com/aaspip/MATdrr/trunk ./MATdrr
% or git clone https://github.com/aaspip/MATdrr ./

clc;clear;close all;
addpath(genpath('./MATdrr'));
addpath(genpath('./'));

names=dir('raw/*.mat');

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

%%
c_raws=zeros(31,1);
c_bps=zeros(31,1);
c_bpmfs=zeros(31,1);
c_bpmfmrrs=zeros(31,1);


for ii =1:31
    name=names(ii).name;
    load(strcat(names(ii).folder,'/',names(ii).name));
    eq=data;

    if ii==13
        eq(:,7200:7221)=0;
        eq(:,7150:7271)=das_mf(eq(:,7150:7271),40,1,2);
        eq(:,7150:7271)=das_meanf(eq(:,7150:7271),40,1,2);
    end

    if ii==13
        [n1,n2]=size(data);
        t=[0:n2-1]*(1/250);
        x=1:n1;
    end

    %     figure('units','normalized','Position',[0.2 0.4 0.8, 1],'color','w');
    %     subplot(3,2,1);
    %     das_imagesc(eq,95,1,t,x);title(name,'Interpreter', 'none');

    if ii==12
        eq(find(isnan(data)))=0;
    end

    d_bp=das_bandpass(eq',1/250,0,20)';
    d_bpmf=das_mf(d_bp,5,1,1);

    %% MRR
    n1win=512;n2win=200;n3win=1;
    r1=0.5;r2=0.5;r3=0.5;
    d_bpmfmrr=drr3d_win(d_bpmf',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';
    d_bpmfmrr=single(d_bpmfmrr);
    save(sprintf('processed/eq%d.mat',ii),'d_bpmfmrr');
%     load(sprintf('processed/eq%d.mat',ii));
%     load(sprintf('processed/bp%d.mat',ii));
%     load(sprintf('processed/mf%d.mat',ii));
%     d_bpmfmrr=datatt;

    c_raw=das_coh(eq',Param);
    c_bp=das_coh(d_bp',Param);
    c_bpmf=das_coh(d_bpmf',Param);
    c_bpmfmrr=das_coh(d_bpmfmrr',Param);

    c_raws(ii)=max(abs(c_raw(:)));
    c_bps(ii)=max(abs(c_bp(:)));
    c_bpmfs(ii)=max(abs(c_bpmf(:)));
    c_bpmfmrrs(ii)=max(abs(c_bpmfmrr(:)));

    fprintf('II=%d is done\n',ii);
end

save allcmax.mat c_raws c_bps c_bpmfs c_bpmfmrrs
% load allcmax.mat

figure('units','normalized','Position',[0.2 0.4 0.6, 0.75],'color','w');
plot([1:31],c_raws,'-ok','linewidth',2);hold on;
plot([1:31],c_bps,'-sg','linewidth',2);
plot([1:31],c_bpmfs,'-vb','linewidth',2);
plot([1:31],c_bpmfmrrs,'-pr','linewidth',2);


ylabel('Cmax','Fontsize',20,'fontweight','bold');
xlabel('Earthquake NO','Fontsize',20,'fontweight','bold');
title('Cmax Distribution of 31 Earthquake Events ','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
plot([0,32.8],0.46*ones(1,2),'--m','linewidth',2);text(0,0.45,'Detection threshold','color','m','Fontsize',12,'fontweight','bold');
legend('Raw','BP','BP+MF','BP+MF+MRR','Threshold','location','southeast');

xlim([0.0,32.8]);

mags={'0.7','0.77','2.17','0.57','0.24','0.29','0.62','2.39','1.33','0.68','0.61','-0.05','2.46','0.39','-0.5','2.39','1.36','2.86','1.56','1.66','0.74','0.5','0.59','2.86','0.42','0.57','1.51','1.63','0.77','0.61','1.12'};
for ii=1:31
text(ii,c_bpmfmrrs(ii),strcat('M=',mags(ii)),'color','k','Fontsize',10,'fontweight','bold');
end

ap1=[5,0.15];
ap2=[5,c_bpmfs(5)];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String','Missed in Lellouch et al (2019)','linewidth',2,'Fontsize',12,'fontweight','bold','color','k','HorizontalAlignment','center');
ap1=[5,0.15];
ap2=[6,c_bpmfs(6)];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('arrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'linewidth',2,'color','k');
ap1=[5,0.15];
ap2=[7,c_bpmfs(7)];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('arrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'linewidth',2,'color','k');


ap1=[22,0.18];
ap2=[21,c_bpmfs(21)];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('textarrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'String',{'Missed in Lellouch','et al (2019)'},'linewidth',2,'Fontsize',12,'fontweight','bold','color','k','HorizontalAlignment','center');
ap1=[22,0.18];
ap2=[22,c_bpmfs(22)];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('arrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'linewidth',2,'color','k');
ap1=[22,0.18];
ap2=[25,c_bpmfs(25)];
fp1=yc_ap2fp(ap1);
fp2=yc_ap2fp(ap2);
annotation('arrow',[fp1(1),fp2(1)],[fp1(2),fp2(2)],'linewidth',2,'color','k');


print(gcf,'-depsc','-r300','fig9.eps');




