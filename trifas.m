% Configuración de parámetros
f = 50;              % Frecuencia (Hz)
Vmax = 220;          % Voltaje máximo (V)
fase = 120;          % Desfase entre fases (grados)
ciclos = 2;          % Número de ciclos a graficar

% Rango de ángulos (0 a 720 grados para 2 ciclos)
grados = linspace(0, 360 * ciclos, 2000);

% Convertir grados a radianes para cálculos
radianes = deg2rad(grados);

% Generar las tres fases
fase_A = Vmax * sin(radianes);
fase_B = Vmax * sin(radianes - deg2rad(fase));
fase_C = Vmax * sin(radianes - deg2rad(2*fase));

% Encontrar intersecciones
% Intersecciones entre Fase A y Fase B
intersecciones_AB = find(diff(sign(fase_A - fase_B)) ~= 0);
% Intersecciones entre Fase A y Fase C
intersecciones_AC = find(diff(sign(fase_A - fase_C)) ~= 0);
% Intersecciones entre Fase B y Fase C
intersecciones_BC = find(diff(sign(fase_B - fase_C)) ~= 0);

% Crear la figura
figure('Position', [100, 100, 1000, 700]);
hold on;
grid on;

% Graficar las tres fases
plot(grados, fase_A, 'r', 'LineWidth', 2, 'DisplayName', 'Fase A');
plot(grados, fase_B, 'b', 'LineWidth', 2, 'DisplayName', 'Fase B');
plot(grados, fase_C, 'g', 'LineWidth', 2, 'DisplayName', 'Fase C');

% Marcar intersecciones con puntos y texto
% Intersecciones A-B
for i = 1:min(length(intersecciones_AB), 10) % Limitar a 10 puntos para evitar saturación
    idx = intersecciones_AB(i);
    angulo = grados(idx);
    valor = fase_A(idx);
    plot(angulo, valor, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    if mod(i,2) == 0
        text(angulo, valor + 25, sprintf('(%.1f°, %.1f V)', angulo, valor), ...
            'FontSize', 8, 'HorizontalAlignment', 'center');
    else
        text(angulo, valor - 35, sprintf('(%.1f°, %.1f V)', angulo, valor), ...
            'FontSize', 8, 'HorizontalAlignment', 'center');
    end
end

% Intersecciones A-C
for i = 1:min(length(intersecciones_AC), 10)
    idx = intersecciones_AC(i);
    angulo = grados(idx);
    valor = fase_A(idx);
    plot(angulo, valor, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    if mod(i,2) == 0
        text(angulo, valor + 25, sprintf('(%.1f°, %.1f V)', angulo, valor), ...
            'FontSize', 8, 'HorizontalAlignment', 'center');
    else
        text(angulo, valor - 35, sprintf('(%.1f°, %.1f V)', angulo, valor), ...
            'FontSize', 8, 'HorizontalAlignment', 'center');
    end
end

% Intersecciones B-C
for i = 1:min(length(intersecciones_BC), 10)
    idx = intersecciones_BC(i);
    angulo = grados(idx);
    valor = fase_B(idx);
    plot(angulo, valor, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    if mod(i,2) == 0
        text(angulo, valor + 25, sprintf('(%.1f°, %.1f V)', angulo, valor), ...
            'FontSize', 8, 'HorizontalAlignment', 'center');
    else
        text(angulo, valor - 35, sprintf('(%.1f°, %.1f V)', angulo, valor), ...
            'FontSize', 8, 'HorizontalAlignment', 'center');
    end
end

% Configurar el gráfico
xlabel('Ángulo (grados)', 'FontSize', 12);
ylabel('Voltaje (V)', 'FontSize', 12);
title(sprintf('Onda Trifásica - %d Ciclos Completo(s)', ciclos), 'FontSize', 14);
legend('show', 'Location', 'best');

% Configurar eje x para mostrar grados
xlim([0 360 * ciclos]);
xticks(0:60:360 * ciclos);
xlabel('Ángulo (grados)');

% Añadir líneas de referencia para cada ciclo
for ciclo = 0:ciclos
    xline(360 * ciclo, 'k--', 'LineWidth', 0.8, 'Alpha', 0.7);
    if ciclo < ciclos
        xline(360 * ciclo + 120, 'k--', 'LineWidth', 0.5, 'Alpha', 0.5);
        xline(360 * ciclo + 240, 'k--', 'LineWidth', 0.5, 'Alpha', 0.5);
    end
end
yline(0, 'k--', 'LineWidth', 0.8);

% Añadir etiquetas para los ciclos
for ciclo = 1:ciclos
    text(360 * (ciclo - 0.5), Vmax + 30, sprintf('Ciclo %d', ciclo), ...
        'FontSize', 10, 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
end

hold off;

% Mostrar información de intersecciones en consola
fprintf('\n=== PUNTOS DE INTERSECCIÓN (2 CICLOS) ===\n');

fprintf('\nFase A - Fase B:\n');
for i = 1:min(length(intersecciones_AB), 6) % Mostrar solo los primeros 6
    idx = intersecciones_AB(i);
    fprintf('Ángulo: %.1f°, Voltaje: %.2f V\n', grados(idx), fase_A(idx));
end

fprintf('\nFase A - Fase C:\n');
for i = 1:min(length(intersecciones_AC), 6)
    idx = intersecciones_AC(i);
    fprintf('Ángulo: %.1f°, Voltaje: %.2f V\n', grados(idx), fase_A(idx));
end

fprintf('\nFase B - Fase C:\n');
for i = 1:min(length(intersecciones_BC), 6)
    idx = intersecciones_BC(i);
    fprintf('Ángulo: %.1f°, Voltaje: %.2f V\n', grados(idx), fase_B(idx));
end

% Calcular periodicidad
fprintf('\n=== ANÁLISIS DE PERIODICIDAD ===\n');
fprintf('La señal se repite cada 360° (1 ciclo)\n');
fprintf('Número total de intersecciones A-B en 2 ciclos: %d\n', length(intersecciones_AB));
fprintf('Número total de intersecciones A-C en 2 ciclos: %d\n', length(intersecciones_AC));
fprintf('Número total de intersecciones B-C en 2 ciclos: %d\n', length(intersecciones_BC));