clc;clear;
%% X-axis
load B2.mat 
load Xmodel.mat

data = B2;

%% Predicting the trajectory of one vehicle using three others
input = data(:, 1:3)'; % Get the trajectories of the three vehicles; transpose to one row
output = data(:, 4)'; % Get the trajectory of the fourth vehicle; transpose to one row

%%  

numFeatures = size(input, 1);  % Number of features, i.e., the number of feature variables
outdim = size(output, 1); % Output dimensions

nwhole = size(data, 1);
train_ratio = 0.8;
M = round(nwhole * train_ratio); % Get the nearest integer
N = nwhole - M;

P_train = input;
T_trainX = output;

P_test = input(:, M+1:M+N);
T_test = output(:, M+1:M+N);

%% Data normalization
[pc_train, ps_input] = mapminmax(P_train);
pc_test = mapminmax('apply', P_test, ps_input);

[tc_train, ps_output] = mapminmax(T_trainX);
tc_test = mapminmax('apply', T_test, ps_output);

%% Prediction of result data
t_sim1 = predict(Xmodel, pc_train); 
T_sim1 = t_sim1;

%% Data reverse normalization
T_sim1 = mapminmax('reverse', T_sim1, ps_output);

%%  
error1 = sqrt(sum((T_sim1 - T_trainX).^2) ./ M); % Root Mean Squared Error (RMSE)
R1 = eva1(T_trainX, T_sim1);  % Coefficient of Determination (R^2)
mse1 = sum((T_sim1 - T_trainX).^2) ./ M; % Mean Squared Error (MSE)

%% Plotting
figure
plot(1:500, T_trainX, 'r-o', 1:500, T_sim1, 'b-*', 'LineWidth', 1.5)
legend('True values', 'Predicted values')
xlabel('X-axis prediction samples')
ylabel('X-axis results')
string = {['(R^2 = ' num2str(R1) ' RMSE = ' num2str(error1) ' MSE = ' num2str(mse1) '' ]};
title(string)

%% Y-axis

load C2.mat
load Ymodel.mat
data = C2;

%% Predicting the trajectory of one vehicle using three others
input = data(:, 1:3)'; % Get the trajectories of the three vehicles; transpose to one row
output = data(:, 4)'; % Get the trajectory of the fourth vehicle; transpose to one row

%%  

numFeatures = size(input, 1);  % Number of features, i.e., the number of feature variables
outdim = size(output, 1); % Output dimensions

nwhole = size(data, 1);
train_ratio = 0.8;
M = round(nwhole * train_ratio); % Get the nearest integer
N = nwhole - M;

P_train = input;
T_trainY = output;

P_test = input(:, M+1:M+N);
T_test = output(:, M+1:M+N);

%% Data normalization
[pc_train, ps_input] = mapminmax(P_train);
pc_test = mapminmax('apply', P_test, ps_input);

[tc_train, ps_output] = mapminmax(T_trainY);
tc_test = mapminmax('apply', T_test, ps_output);

%% Prediction of result data
t_sim2 = predict(Ymodel, pc_train); 
T_sim2 = t_sim2;

%% Data reverse normalization
T_sim2 = mapminmax('reverse', T_sim2, ps_output);

%%  
error2 = sqrt(sum((T_sim2 - T_trainY).^2) ./ M); % Root Mean Squared Error (RMSE)
R2 = eva1(T_trainY, T_sim2);  % Coefficient of Determination (R^2)
mse2 = sum((T_sim2 - T_trainY).^2) ./ M; % Mean Squared Error (MSE)

%% Plotting
figure
plot(1:500, T_trainY, 'r-o', 1:500, T_sim2, 'b-*', 'LineWidth', 1.5)
legend('True values', 'Predicted values')
xlabel('Y-axis prediction samples')
ylabel('Y-axis results')
string = {['(R^2 = ' num2str(R2) ' RMSE = ' num2str(error2) ' MSE = ' num2str(mse2) '' ]};
title(string)

Ture = [T_trainX; T_trainY];
Tpre = [T_sim1; T_sim2];
T = [Tpre; Ture];
A = T(:, 313-187:313+187);

x1 = A(3, :) - A(1, :);
y1 = A(4, :) - A(2, :);

dx = (x1).^2;
dy = (y1).^2;
L = sqrt(dx + dy);

disp(['Mean Absolute Error (MAE) is: ', num2str(mean(L))])
disp(['Root Mean Squared Error (RMSE) is:  ', num2str(sqrt(mean(L.^2)))])

figure
subplot(1, 3, 1)
set(gcf, 'Position', [20 100 1300 550]);	    
set(gcf, 'Color', 'w'); 

plot(x1, 'r', 'LineWidth', 2);

xlabel('X-axis point number', 'FontSize', 15, 'FontName', 'Times New Roman');
ylabel('Error (m)', 'FontSize', 15, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 15)

subplot(1, 3, 2)    
set(gcf, 'Color', 'w'); 
plot(y1, 'r', 'LineWidth', 2);

xlabel('Y-axis point number', 'FontSize', 15, 'FontName', 'Times New Roman');
ylabel('Error (m)', 'FontSize', 15, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 15)

subplot(1, 3, 3)
set(gcf, 'Color', 'w'); 

plot(A(1, :), A(2, :), 'r', 'LineWidth', 2);
hold on;
plot(A(3, :), A(4, :), 'k--', 'LineWidth', 2);

xlabel('X-axis (m)', 'FontSize', 15, 'FontName', 'Times New Roman');
ylabel('Y-axis (m)', 'FontSize', 15, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 15)

legend(['IDBO-TCCBRN' newline ''], ['Target' newline ''], 'Orientation', 'horizontal');
