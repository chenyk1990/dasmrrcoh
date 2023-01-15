% Script to plot Figure 3
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

if ~isdir('fig')
    mkdir('fig');
end

if ~isdir('processed')
    mkdir('processed');
end

names=dir('raw/*.mat');
ieq=2;
for ii=ieq:ieq
    load(strcat(names(ii).folder,'/',names(ii).name));
    if ii==ieq
        [n1,n2]=size(data);
        t=[0:n2-1]*(1/250);
        x=1:n1;
    end

    if ii==12
        data(find(isnan(data)))=0;
    end
    eq=data;
    d_bp=das_bandpass(eq',1/250,0,20)';
    d_bpmf=das_mf(d_bp,5,1,1);
    %% MRR
    n1win=1024;n2win=800;n3win=1;
    n1win=512;n2win=200;n3win=1;
    r1=0.5;r2=0.5;r3=0.5;
    d_bpmfmrr=drr3d_win(d_bpmf',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';

    save(sprintf('processed/eq%d.mat',ii),'d_bp','d_bpmf','d_bpmfmrr');

    fprintf('event %d/%d is done\n',ii,length(names));
    %     close gcf;
end

eq=eq';
d_bp=d_bp';
d_bpmf=d_bpmf';
d_bpmfmrr=d_bpmfmrr';


%ii=3: FORGE_78-32_iDASv3-P11_UTC190423213209.sgy, 1484, 3.394402, 0.910045

% t=[0:n1-1]*0.0005;
[n1,n2]=size(d_bpmfmrr);
x=1:n2;
ngap=50;

eq2=[eq,zeros(n1,ngap),zeros(size(eq))];
d_bp2=[d_bp,zeros(n1,ngap),eq-d_bp];
d_bpmf2=[d_bpmf,zeros(n1,ngap),eq-d_bpmf];
d_bpmfmrr2=[d_bpmfmrr,zeros(n1,ngap),eq-d_bpmfmrr];
x=1:ngap+n2*2;

%% begin plotting
% figure('units','normalized','Position',[0.0 0.0 0.45, 1],'color','w');
nr=15;%number of stations in the first column
x0=0.1;y0=0.05;dy=0.13/2;dx=0;
%length: 0.5x0.5, 0.5x0.25, 0.25x0.5
%% axis XY
dh=(1-0.2)/3;dw=0.25;
dh1=0.04;%axis height
dy=0.04;

dh1=0.06;dy=dh1;
nr=3;
labels={'a)','b)','c)','d)','e)','f)','g)','h)','i)'};

ylm=[-5.0376e-09,5.0376e-09]*0.00001*5;
ylm2=[-5.0376e-09,5.0376e-09]*0.00001*5;
ylm3=[-5.0376e-09,5.0376e-09]*0.00001*5;
% traces=[623:631];
traces=[12,14,320,321,634,635,730,750,760];

%trace:624,625,631: perfect
%311,

il=0;
figure('units','normalized','Position',[0.0 0.0 0.5, 1],'color','w');
for ir=1:3
%% first column
ix=traces(3*(ir-1)+1);
a1=axes('Parent',gcf,'Position',[x0,y0+dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpmfmrr(:,ix),'k','linewidth',2); xlim([5,30]);ylim(ylm);
if ir<=2
    set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');
else
    xlabel('Time (s)');set(gca,'linewidth',2,'fontweight','bold');
end
a1=axes('Parent',gcf,'Position',[x0,y0+2*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpmf(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');xlim([5,30]);ylim(ylm);
a1=axes('Parent',gcf,'Position',[x0,y0+3*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bp(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');xlim([5,30]);ylim(ylm);
a1=axes('Parent',gcf,'Position',[x0,y0+4*dy+dh*(nr-ir),dw,dh1]);
plot(t,eq(:,ix)/30,'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold'); xlim([5,30]);ylim(ylm);
title(strcat('Channel:',num2str(ix)));

%add component
a1=axes('Parent',gcf,'Position',[x0,y0+dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+MF+MRR','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0,y0+2*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+MF','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0,y0+3*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0,y0+4*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'Raw data','color','r','Fontsize',10,'fontweight','bold');axis off;
%add label
il=il+1;
a1=axes('Parent',gcf,'Position',[x0,y0+5*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(-0.1,0,labels(il),'color','k','Fontsize',15,'fontweight','bold');axis off;

%% Second column
ix=traces(3*(ir-1)+2);
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpmfmrr(:,ix),'k','linewidth',2); xlim([5,30]);ylim(ylm2);
if ir<=2
    set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');
else
    xlabel('Time (s)');set(gca,'linewidth',2,'fontweight','bold');
end
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+2*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpmf(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');xlim([5,30]);ylim(ylm2);
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+3*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bp(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');xlim([5,30]);ylim(ylm2);
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+4*dy+dh*(nr-ir),dw,dh1]);
plot(t,eq(:,ix)/30,'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold'); xlim([5,30]);ylim(ylm2);
title(strcat('Channel:',num2str(ix)));

%add component
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+MF+MRR','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+2*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+MF','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+3*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+4*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'Raw data','color','r','Fontsize',10,'fontweight','bold');axis off;
%label
il=il+1;
a1=axes('Parent',gcf,'Position',[x0+0.3,y0+5*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(-0.1,0,labels(il),'color','k','Fontsize',15,'fontweight','bold');axis off;

%% Third column
ix=traces(3*(ir-1)+3);
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpmfmrr(:,ix),'k','linewidth',2); xlim([5,30]);ylim(ylm3);
if ir<=2
    set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');
else
    xlabel('Time (s)');set(gca,'linewidth',2,'fontweight','bold');
end
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+2*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bpmf(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');xlim([5,30]);ylim(ylm3);
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+3*dy+dh*(nr-ir),dw,dh1]);
plot(t,d_bp(:,ix),'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');xlim([5,30]);ylim(ylm3);
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+4*dy+dh*(nr-ir),dw,dh1]);
plot(t,eq(:,ix)/30,'k','linewidth',2); set(gca,'xticklabel',[],'linewidth',2,'fontweight','bold');xlim([5,30]);ylim(ylm3);
title(strcat('Channel:',num2str(ix)));
%add component
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+MF+MRR','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+2*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP+MF','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+3*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'BP','color','r','Fontsize',10,'fontweight','bold');axis off;
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+4*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(0.01,dy*10,'Raw data','color','r','Fontsize',10,'fontweight','bold');axis off;
%label
il=il+1;
a1=axes('Parent',gcf,'Position',[x0+0.6,y0+5*dy+dh*(nr-ir)+0.015,dw,dh1]);
text(-0.1,0,labels(il),'color','k','Fontsize',15,'fontweight','bold');axis off;

end

print(gcf,'-depsc','-r300','fig3.eps');







