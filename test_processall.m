% Script to process/plot all results
% BY Yangkang Chen
% Jan, 2023
% This script takes about 6 hours (for processing) and 10 minutes (for plotting only)
%
% Dependency MATdrr
% svn co https://github.com/chenyk1990/MATdrr/trunk ./MATdrr
% or git clone https://github.com/chenyk1990/MATdrr

clc;clear;close all;
addpath(genpath('./MATdrr'));
addpath(genpath('./'));

names=dir('raw/*.mat');


if ~isdir('figresults')
    mkdir('figresults');
end

t=[0:14999]*1/250;
x=1:800;

nt=14999;
nx=length(x);

for ii =2:31
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

    if ii==12
        eq(find(isnan(data)))=0;
    end

    d_bp=das_bandpass(eq',1/250,0,20)';
    d_bpmf=das_mf(d_bp,5,1,1);

    %% MRR
    %     n1win=512;n2win=200;n3win=1;
    %     r1=0.5;r2=0.5;r3=0.5;
    %     d_bpmfmrr=drr3d_win(d_bpmf',0,50,1/250,2,4,0,n1win,n2win,n3win,r1,r2,r3)';
    %     d_bpmfmrr=single(d_bpmfmrr); %% because the maximum allowed size of a single file is roughly 50 MB.
    %     save(sprintf('processed/eq%d.mat',ii),'d_bpmfmrr');
    load(sprintf('processed/eq%d.mat',ii));
    d_bpmfmrr=d_bpmfmrr;

    figure('units','normalized','Position',[0.2 0.4 0.7, 1],'color','w');
    ax1=subplot(3,2,1);
    das_imagesc(eq,95,1,t,x);colormap(ax1,seis);
    title(name,'Interpreter', 'none','Fontsize',14,'fontweight','bold');
    % xlabel('Time (s)','Fontsize',14,'fontweight','bold');
    ylabel('Channel','Fontsize',14,'fontweight','bold');
    set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
    text(-5,-100,'a)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');


    ax2=subplot(3,2,2);
    das_imagesc(d_bp,95,1,t,x);colormap(ax2,seis);
    title('BP','Fontsize',14,'fontweight','bold');
    % xlabel('Time (s)','Fontsize',14,'fontweight','bold');
    % ylabel('Channel','Fontsize',14,'fontweight','bold');
    set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
    text(-5,-100,'b)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');

    ax3=subplot(3,2,3);
    das_imagesc(d_bpmf,95,1,t,x);colormap(ax3,seis);title('BP+MF');
    title('BP+MF','Fontsize',14,'fontweight','bold');
    % xlabel('Time (s)','Fontsize',14,'fontweight','bold');
    ylabel('Channel','Fontsize',14,'fontweight','bold');
    set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
    text(-5,-100,'c)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
    x1=0;x2=30;y1=0;y2=400;
    yc_framebox(x1,x2,y1,y2,'r',2)

    ax4=subplot(3,2,4);
    das_imagesc(d_bpmfmrr,95,1,t,x);colormap(ax4,seis);title('BP+MF+MRR');
    title('BP+MF+MRR','Fontsize',14,'fontweight','bold');
    % xlabel('Time (s)','Fontsize',14,'fontweight','bold');
    % ylabel('Channel','Fontsize',14,'fontweight','bold');
    set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
    text(-5,-100,'d)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');
    yc_framebox(x1,x2,y1,y2,'r',2)

    ax5=subplot(3,2,5);
    das_imagesc(d_bpmf,95,1,t,x);colormap(ax4,seis);xlim([x1,x2]);ylim([y1,y2]);
    title('BP+MF (Zoom)','Fontsize',14,'fontweight','bold');
    xlabel('Time (s)','Fontsize',14,'fontweight','bold');
    ylabel('Channel','Fontsize',14,'fontweight','bold');
    set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
    text(-(x2-x1)/60*5,-(y2-y1)/800*100,'e)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');


    ax6=subplot(3,2,6);
    das_imagesc(d_bpmfmrr,95,1,t,x);colormap(ax4,seis);xlim([x1,x2]);ylim([y1,y2]);
    title('BP+MF+MRR (Zoom)','Fontsize',14,'fontweight','bold');
    xlabel('Time (s)','Fontsize',14,'fontweight','bold');
    ylabel('Channel','Fontsize',14,'fontweight','bold');
    set(gca,'Linewidth',2,'Fontsize',14,'Fontweight','bold');
    text(-(x2-x1)/60*5,-(y2-y1)/800*100,'f)','color','k','Fontsize',18,'fontweight','bold','HorizontalAlignment','center');


    print(gcf,'-dpng','-r100',strcat('figresults/eq',num2str(ii),'.png'));

    close gcf;

    fprintf('II=%d is done\n',ii);
end



% fid=fopen('EQNO2RawFileName.txt','w');
% for ii =1:31
%     fprintf(fid,"EQ NO %d: %s\n",ii,names(ii).name);
% end



