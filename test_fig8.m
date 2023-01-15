% Script to plot Figure 8
% BY Yangkang Chen
% Jan, 2023
% This script takes about 4 hours?
%
% Dependency MATdrr
% svn co https://github.com/chenyk1990/MATdrr/trunk ./MATdrr 
% or git clone https://github.com/chenyk1990/MATdrr 

clc;clear;close all;
addpath(genpath('./MATdrr'));
addpath(genpath('./'));

if ~isdir('fig')
    mkdir('fig');
end

if ~isdir('processed')
    mkdir('processed');
end

names=dir('raw/*.mat');

ii=9;
ii=2;
name=names(ii).name;
load(strcat(names(ii).folder,'/',names(ii).name));

randn('state',202425);
noise=randn(800,14999);%% pure noise 
ndata=das_bandpass(noise',1/250,0,20)';%% pure noise 
ndatat=das_mf(ndata,5,1,1);%% pure noise 


if ii==12
    data(find(isnan(data)))=0;
end
eq=data;
data=das_bandpass(eq',1/250,0,20)';
datat=das_mf(data,5,1,1); 

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


nw=10;nw2=4;
nws=128*(2:2:2*nw);
nws2=200*(1:nw2);
cs=zeros(nw,nw2);
ncs=zeros(nw,nw2);
for iw2=1:nw2
for iw=1:nw
    %% LDRR
    n1win=1024;WinS=800;n3win=1;
    n1win=nws(iw);WinS=nws2(iw2);n3win=1;
    r1=0.5;r2=0.5;r3=0.5;
    param.N=3;
    datatt=drr3d_win(datat',0,50,1/250,2,4,0,n1win,WinS,n3win,r1,r2,r3)';
    ndatatt=drr3d_win(ndatat',0,50,1/250,2,4,0,n1win,WinS,n3win,r1,r2,r3)';
    % load(sprintf('processed/eq%d.mat',ii));
    %     figname=sprintf('fig/new_eq%d.png',ii);
    %     print(gcf,'-dpng','-r300',figname);
%     save(sprintf('processed/eq2-mrr-win-%d-%d.mat',WinS,n1win),'datatt');
%     save(sprintf('processed/noise-mrr-win-%d-%d.mat',WinS,n1win),'ndatatt');

    tmp=abs(das_coh(datatt',Param));
    cs(iw,iw2)=max(tmp(:));
    tmp=abs(das_coh(ndatatt',Param));
    ncs(iw,iw2)=max(tmp(:));
    fprintf('%d/%d n1win=%d,WinS=%d cs(%d,%d)=%g ncs(%d,%d)=%g  is done\n',iw,nw,n1win,WinS,iw,iw2,cs(iw,iw2),iw,iw2,ncs(iw,iw2));
end
end
save eq2_winsize.mat cs ncs
% figure;
% plot(nws,cs(:,1));hold on;
% plot(nws,cs(:,2));
% plot(nws,cs(:,3));
% plot(nws,cs(:,4));
% legend('WinS=200','WinS=400','WinS=600','WinS=800','location','best');
% print(gcf,'-depsc','-r300','win_eq2.eps');

%%
ii=25;
name=names(ii).name;
load(strcat(names(ii).folder,'/',names(ii).name));

if ii==12
    data(find(isnan(data)))=0;
end
eq=data;
data=das_bandpass(eq',1/250,0,20)';
datat=das_mf(data,5,1,1); 

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

nw=10;nw2=4;
nws=128*(2:2:2*nw);
nws2=200*(1:nw2);
cs=zeros(nw,nw2);
for iw2=1:nw2
for iw=1:nw
    %% LDRR
    n1win=1024;WinS=800;n3win=1;
    n1win=nws(iw);WinS=nws2(iw2);n3win=1;
    r1=0.5;r2=0.5;r3=0.5;
    param.N=3;
    datatt=drr3d_win(datat',0,50,1/250,2,4,0,n1win,WinS,n3win,r1,r2,r3)';
    % load(sprintf('processed/eq%d.mat',ii));
    %     figname=sprintf('fig/new_eq%d.png',ii);
    %     print(gcf,'-dpng','-r300',figname);
    save(sprintf('processed/eq25-mrr-win-%d-%d.mat',WinS,n1win),'datatt');

    tmp=abs(das_coh(datatt',Param));
    cs(iw,iw2)=max(tmp(:));
    fprintf('%d/%d n1win=%d,WinS=%d cs(%d,%d)=%g ncs(%d,%d)=%g  is done\n',iw,nw,n1win,WinS,iw,iw2,cs(iw,iw2),iw,iw2,ncs(iw,iw2));
end
end
save eq25_winsize.mat cs


%% run from this line
load eq2_winsize.mat

cs2=cs;
nw=10;
nws=128*(2:2:2*nw);

figure('units','normalized','Position',[0.2 0.4 1, 0.75],'color','w');
tiledlayout(1,2,'TileSpacing','Compact','Padding','Compact');
nexttile;
plot(nws,cs(:,1),'-o','linewidth',2,'MarkerSize',8);hold on;
% ylabel('Cmax','Fontsize',20,'fontweight','bold');
xlabel('Window size in time','Fontsize',20,'fontweight','bold');
title('Cmax variation with window size (M=0.77)','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
% plot([0,32.8],0.46*ones(1,2),'--m','linewidth',2,'MarkerSize',8);
% text(0,0.45,'Detection threshold','color','m','Fontsize',12,'fontweight','bold');
xlim([100,2700]);
plot(nws,cs(:,2),'-o','linewidth',2,'MarkerSize',8);
plot(nws,cs(:,3),'-o','linewidth',2,'MarkerSize',8);
plot(nws,cs(:,4),'-o','linewidth',2,'MarkerSize',8);

plot(nws,ncs(:,1),'-s','linewidth',2,'MarkerSize',8);
plot(nws,ncs(:,2),'-s','linewidth',2,'MarkerSize',8);
plot(nws,ncs(:,3),'-s','linewidth',2,'MarkerSize',8);
plot(nws,ncs(:,4),'-s','linewidth',2,'MarkerSize',8);
%% legend
ap1=[1900,0.65];
ap2=[2560,0.85];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
legend('WinS=200','WinS=400','WinS=600','WinS=800','WinSN=200','WinSN=400','WinSN=600','WinSN=800','Position',[fp1(1),fp1(2),fp2(1)-fp1(1),fp2(2)-fp1(2)],'NumColumns',1);
%% framebox
ap1=[190,0.22];
ap2=[2620,0.58];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
annotation(gcf,'rectangle',[fp1(1) fp1(2) fp2(1)-fp1(1) fp2(2)-fp1(2)],'LineStyle','--','LineWidth',2,'color','m');
text(190,0.60,'Calculated from filtered noise','color','m','Fontsize',14,'fontweight','bold');
text(-150,1.02,'a)','color','k','Fontsize',28,'fontweight','bold');


load eq2_winsize.mat
load eq25_winsize.mat
cs2=cs;
nw=10;
nws=128*(2:2:2*nw);

nexttile;

plot(nws,cs2(:,1),'-o','linewidth',2,'MarkerSize',8);hold on;
ylabel('Cmax','Fontsize',20,'fontweight','bold');
xlabel('Window size in time','Fontsize',20,'fontweight','bold');
title('Cmax variation with window size (M=0.42)','Fontsize',20,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',20,'Fontweight','bold');
% plot([0,32.8],0.46*ones(1,2),'--m','linewidth',2,'MarkerSize',8);
% text(0,0.45,'Detection threshold','color','m','Fontsize',12,'fontweight','bold');
xlim([100,2700]);

plot(nws,cs2(:,2),'-o','linewidth',2,'MarkerSize',8);
plot(nws,cs2(:,3),'-o','linewidth',2,'MarkerSize',8);
plot(nws,cs2(:,4),'-o','linewidth',2,'MarkerSize',8);
plot(nws,ncs(:,1),'-s','linewidth',2,'MarkerSize',8);
plot(nws,ncs(:,2),'-s','linewidth',2,'MarkerSize',8);
plot(nws,ncs(:,3),'-s','linewidth',2,'MarkerSize',8);
plot(nws,ncs(:,4),'-s','linewidth',2,'MarkerSize',8);
%% legend
ap1=[1900,0.48];
ap2=[2560,0.68];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
legend('WinS=200','WinS=400','WinS=600','WinS=800','WinSN=200','WinSN=400','WinSN=600','WinSN=800','Position',[fp1(1),fp1(2),fp2(1)-fp1(1),fp2(2)-fp1(2)],'NumColumns',1);
%% framebox
ap1=[190,0.22];
ap2=[2620,0.58];
fp1=das_ap2fp(ap1);
fp2=das_ap2fp(ap2);
annotation(gcf,'rectangle',[fp1(1) fp1(2) fp2(1)-fp1(1) fp2(2)-fp1(2)],'LineStyle','--','LineWidth',2,'color','m');
text(190,0.60,'Calculated from filtered noise','color','m','Fontsize',14,'fontweight','bold');
text(-150,1.02,'b)','color','k','Fontsize',28,'fontweight','bold');

% print(gcf,'-depsc','-r300','win_eq25.eps');
print(gcf,'-depsc','-r300','fig8.eps');





