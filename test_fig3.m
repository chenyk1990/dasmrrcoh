% Script to plot Figure 3
% BY Yangkang Chen
% Jan, 2023
% This script takes about 10 minutes
%
% Dependency MATdrr
% svn co https://github.com/aaspip/MATdrr/trunk ./MATdrr
% or git clone https://github.com/aaspip/MATdrr ./

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
    name=names(ii).name;
    load(name);
    if ii==ieq
        [n1,n2]=size(data);
        t=[0:n2-1]*(1/250);
        x=1:n1;
    end

    if ii==12
        data(find(isnan(data)))=0;
    end
    eq=data';

    param=struct;
    param.dt=1/250;
    param.nf=10;
    param.mu=0.1;
    param.lf=0;
    param.hf=50;
    dfx=drr_win2d(@das_localfx, param, data', 512, 200, 0.5, 0.5)';

    data=das_bandpass(data',1/250,0,20)';
    dbpfx=drr_win2d(@das_localfx, param, data', 512, 200, 0.5, 0.5)';

    datat=das_mf(data,5,1,1);
    dbpmffx=drr_win2d(@das_localfx, param, datat', 512, 200, 0.5, 0.5)';

    %FX
    %BP+FX
    %BP+MF+FX

end

data=dfx;
datat=dbpfx;
datatt=dbpmffx;

%% coherency
d_bp=data';
d_bpmf=datat';
d_bpmffx=datatt';

nt=size(d_bp,1);
nx=size(d_bp,2);
v=linspace(-0.0013,0.0013,100);
Param.v=v;
Param.nt=nt;
Param.h=[0:nx-1];
Param.dt=1/250.0;
Param.type=1;
Param.oper=-1;
c0=das_coh(eq,Param);
c_bp=das_coh(d_bp,Param);
c_bpmf=das_coh(d_bpmf,Param);
c_bpmffx=das_coh(d_bpmffx,Param);

figure('units','normalized','Position',[0.2 0.4 0.7, 0.25],'color','w');
ax4=subplot(1,2,1);
das_imagesc(datatt,95,1,t,x);colormap(ax4,seis);title('BP+MF+MRR');
title('BP+MF+FX','Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Channel','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,-100,'a)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
hold on;plot(t(3095)*ones(1,2),[max(x),min(x)],'--','color','r','linewidth',2);

ax8=subplot(1,2,2);
imagesc(t,v,c_bpmffx');colormap(ax8,jet);caxis([0,0.5]);
title(strcat('BP+MF+FX Cmax=',num2str(max(abs(c_bpmffx(:))))),'Fontsize',14,'fontweight','bold');
xlabel('Time (s)','Fontsize',14,'fontweight','bold');
ylabel('Slope','Fontsize',14,'fontweight','bold');
set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
text(-5,min(v)-(max(v)-min(v))/(max(x)-min(x))*100,'b)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
hold on;plot(t(3095)*ones(1,2),[max(v),min(v)],'--','color','r','linewidth',2);
text(t(3095)+4,max(v)-0.0005,'Cmax','color','r','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

print(gcf,'-depsc','-r300','fig3.eps');
