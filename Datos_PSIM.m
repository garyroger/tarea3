% Definir la ruta completa
carpeta = 'G:\Mi unidad\2. Segundo Semestre\2. Conversión de Energía Eléctrica Para Fuentes Renovables\Tareas\Tarea 3';
nombre_archivo = 'Rectificador_trifasico.txt';

% Construir ruta completa
ruta_completa = fullfile(carpeta, nombre_archivo);

% Verificar si el archivo existe
if exist(ruta_completa, 'file')
    disp(['Archivo encontrado: ' ruta_completa]);
    
    % Primero ver el formato del archivo
    disp('=== PRIMERAS LÍNEAS DEL ARCHIVO ===');
    try
        fid = fopen(ruta_completa, 'r');
        for i = 1:5
            linea = fgetl(fid);
            if ischar(linea)
                disp(linea);
            else
                break;
            end
        end
        fclose(fid);
    catch
        disp('No se pudieron leer las primeras líneas');
    end
    
    % Intentar diferentes métodos de carga
    disp('=== CARGANDO DATOS ===');
    try
        % Método 1: Usar readmatrix (para datos numéricos sin encabezados)
        datos = readmatrix(ruta_completa);
        disp('Método: readmatrix - datos numéricos sin encabezados');
        
    catch
        try
            % Método 2: Usar importdata (para datos mixtos)
            datos_import = importdata(ruta_completa);
            datos = datos_import.data;
            disp('Método: importdata - datos con encabezados o mixtos');
            
        catch
            try
                % Método 3: Usar readtable (para datos tabulares)
                tabla = readtable(ruta_completa);
                datos = table2array(tabla);
                disp('Método: readtable - datos tabulares');
                
            catch ME
                error('No se pudo cargar el archivo: %s', ME.message);
            end
        end
    end
    
    % Verificar que tenemos al menos 5 columnas
    if size(datos, 2) < 5
        error('El archivo tiene menos de 5 columnas. Solo tiene %d columnas', size(datos, 2));
    end
    
    % Asignar a variables específicas
    Time = datos(:,1);    % Columna 1: Time
    Van = datos(:,2);     % Columna 2: Van
    Vbn = datos(:,3);     % Columna 3: Vbn
    Vcn = datos(:,4);     % Columna 4: Vcn
    VR = datos(:,5);      % Columna 5: VR
    
    % Crear matriz con todas las variables
    matriz_completa = [Time, Van, Vbn, Vcn, VR];
    
    % Mostrar información
    disp('=== CARGA EXITOSA ===');
    disp(['Tamaño de la matriz: ' num2str(size(matriz_completa))]);
    disp('Variables creadas: Time, Van, Vbn, Vcn, VR, matriz_completa');
    disp('Primeras 5 filas de la matriz:');
    disp(matriz_completa(1:5,:));
    
    % Guardar las variables en el workspace
    assignin('base', 'Time', Time);
    assignin('base', 'Van', Van);
    assignin('base', 'Vbn', Vbn);
    assignin('base', 'Vcn', Vcn);
    assignin('base', 'VR', VR);
    assignin('base', 'matriz_completa', matriz_completa);
    
    % Opcional: Guardar en un archivo .mat
    save('datos_rectificador.mat', 'Time', 'Van', 'Vbn', 'Vcn', 'VR', 'matriz_completa');
    disp('Datos guardados en: datos_rectificador.mat');
    
else
    error('El archivo no existe en la ruta: %s', ruta_completa);
end

% Mensaje final
disp('Proceso completado. Las variables están disponibles en el workspace.');



% Configuración de la figura
f = figure(); 
clf;
set(f,'Units','inches','Position',[1 1 8 6],'PaperPositionMode','auto');
grid on
box on
hold on;

% Graficar las cuatro señales
plot(Time, Van, 'b', 'LineWidth', 1.5, 'DisplayName', '$V_{an}$');
plot(Time, Vbn, 'r', 'LineWidth', 1.2, 'DisplayName', '$V_{bn}$');
plot(Time, Vcn, 'g' ,'LineWidth', 1.5, 'Color', [29/255, 185/255, 84/255], 'DisplayName', '$V_{cn}$');
plot(Time, VR, 'k', 'LineWidth', 1.8, 'DisplayName', '$V_R$');

% Configuración de ejes y leyenda
xlabel('Tiempo [s]', 'FontSize', 12);
ylabel('Voltaje [V]', 'FontSize', 12);
title('Voltajes del Rectificador Trifásico', 'FontSize', 14);

% Leyenda con LaTeX
legend('show', 'location', 'best', 'FontSize', 10, 'Interpreter', 'latex');
legend box off

% Mejorar la visualización
set(gca, 'FontSize', 11);
grid minor

hold off;
xlim([0 0.05])