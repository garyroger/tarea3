

% ===================================================================
% 1. ESTILO IEEE PARA GRÁFICAS
% ===================================================================
% Setea fuentes y estilos por defecto
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultaxesTickLabelInterpreter','latex');
set(groot,'defaultlegendInterpreter','latex');
set(groot,'defaultAxesFontName','Times New Roman');
set(groot,'defaultTextFontName','Times New Roman');

% Tamaños y grosores recomendados
fs_ax   = 10; % Fuente de ejes y etiquetas
lw_main = 1.5; % Grosor de línea

% Tamaño de figura en pulgadas
fig_w = 6.0; fig_h = 3; % Ligeramente más grande para acomodar más datos

% ===================================================================
% 2. CÁLCULO DE ARMÓNICOS
% ===================================================================
% Definir los rangos para las variables
alpha_deg = 0:1:180; % Ángulo de disparo de 0 a 180 grados
alpha_rad = deg2rad(alpha_deg); % Convertir a radianes
n_harmonics = 6:6:60; % Órdenes de armónicos a graficar (hasta el 60)

% ===================================================================
% 3. CREACIÓN DE LA GRÁFICA
% ===================================================================
% Crear y configurar la figura
f1 = figure(1); clf;
set(f1,'Units','inches','Position',[1 1 fig_w fig_h],'PaperPositionMode','auto');
hold on; % Mantener la figura para añadir múltiples líneas

% Generar una paleta de colores vivos y distinguibles
num_lines = length(n_harmonics);
colors = lines(num_lines);

% Bucle para calcular y graficar cada armónico
for i = 1:num_lines
    n = n_harmonics(i);
    
    % Calcular la magnitud RMS para el armónico 'n' actual
    Vn = (3*sqrt(3))/(sqrt(2)*pi) * sqrt(1/((n-1)^2) + 1/((n+1)^2) - (2*cos(2*alpha_rad))/(n^2-1));
    
    % Crear un vector 'y' constante con el valor del armónico para plot3
    y_axis_val = ones(size(alpha_deg)) * n;
    
    % Graficar en 3D con el color correspondiente de la paleta
    plot3(alpha_deg, y_axis_val, Vn, 'LineWidth', lw_main, 'Color', colors(i,:));
end

hold off; % Dejar de añadir líneas a la gráfica

% Configurar ejes y etiquetas
xlabel('$\alpha$','FontSize',fs_ax);
ylabel('n','FontSize',fs_ax);
zlabel('$V_n$','FontSize',fs_ax);


% Ajustar límites, ticks y apariencia
xlim([0 180]);
yticks(n_harmonics); % Poner marcas en el eje Y solo en los números de armónicos
view(220, 35); % Ángulo de vista ajustado para la nueva densidad de datos
grid on;
box on;

