clear; clc; close all;

data1 = readtable('Voltajes_fase_Vr.txt');

t_psim =  table2array(data1(:,1));
van_psim =  table2array(data1(:,2));
vbn_psim =  table2array(data1(:,3));
vcn_psim =  table2array(data1(:,4));
vR_psim =  table2array(data1(:,5));

data2 = readtable('Voltajes_linea_Vr.txt');
vab_psim =  table2array(data2(:,2));
vac_psim =  table2array(data2(:,3));
vba_psim =  table2array(data2(:,4));
vbc_psim =  table2array(data2(:,5));
vca_psim =  table2array(data2(:,6));
vcb_psim =  table2array(data2(:,7));

% ===== estilo ieee para graficas =====
% setea fuentes y estilos por defecto (solo una vez por sesion)
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultaxesTickLabelInterpreter','latex');
set(groot,'defaultlegendInterpreter','latex');
set(groot,'defaultAxesFontName','Times New Roman');
set(groot,'defaultTextFontName','Times New Roman');

% tamanos y grosores recomendados
fs_ax   = 10;     % fuente de ejes (ieee single column)
fs_lbl  = 10;    % fuente de etiquetas
fs_legend = 10;   % fuente de la leyenda
lw_main = 1;   % grosor de linea
ms_main = 5;     % tamano de marcador

% tamano de figura en pulgadas (single column ~ 5.5in x 2in)
fig_w = 3.8; fig_h = 1.8;

% graficas
f1 = figure(1); clf;
set(f1,'Units','inches','Position',[1 1 fig_w fig_h],'PaperPositionMode','auto');
grid on
box on
plot(t_psim,van_psim, 'LineWidth',1.5); hold on
plot(t_psim,vbn_psim, 'LineWidth',1.5); hold on
plot(t_psim,vcn_psim, 'LineWidth',1.5); hold on
xlabel('tiempo [ms]','FontSize',fs_ax);
legend('$v_{an}$','$v_{bn}$','$v_{cn}$','location','best','FontSize',fs_legend);
grid on;
box on;
legend box off

% graficas
f2 = figure(2); clf;
set(f2,'Units','inches','Position',[1 1 fig_w fig_h],'PaperPositionMode','auto');
grid on
box on
plot(t_psim*1000,abs(vab_psim), 'LineWidth',1); hold on
plot(t_psim*1000,abs(vac_psim),"r", 'LineWidth',1);
plot(t_psim*1000,abs(vbc_psim), 'LineWidth',1);
plot(t_psim*1000,vR_psim, 'LineWidth',2, 'Color',[29/255, 185/255, 84/255]);
xlabel('tiempo [ms]','FontSize',fs_ax);
legend('$|v_{ab}|$','$|v_{ac}|$','$|v_{bc}|$','$v_R$','location','best','FontSize',fs_legend);
grid on;
xlim([0 0.07*1000])  
box on;
legend box off