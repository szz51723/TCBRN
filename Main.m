clc;clear;
%% X轴
load B2.mat 
load Xmodel.mat

data=B2;

%% 用三车预测另外一车
input =data(:,1:3)';%获取三车车轨迹； 转置为一行
output=data(:,4)';%获取第四车轨迹； 转置为一行

%%  

numFeatures = size(input,1);  % 特征个数，即特征变量的个数
outdim=size(output,1); %输出的维度

nwhole =size(data,1);
train_ratio=0.8;
M=round(nwhole*train_ratio);%获取最近的整数
N =nwhole-M;

P_train =input;
T_trainX=output;


P_test =input(:, M+1:M+N);
T_test=output(:,M+1:M+N);


%%  数据归一化
[pc_train, ps_input] = mapminmax(P_train);
pc_test = mapminmax('apply', P_test, ps_input);

[tc_train, ps_output] = mapminmax(T_trainX);
tc_test = mapminmax('apply', T_test, ps_output);



%%  结果数据预测
t_sim1 = predict(Xmodel, pc_train); 
T_sim1 = t_sim1;

%%  数据反归一化
T_sim1 = mapminmax('reverse', T_sim1, ps_output);


%%  
error1 = sqrt(sum((T_sim1- T_trainX).^2)./M); %均方根误差 RMSE
R1=eva1(T_trainX,T_sim1);  %决定系数
mse1 = sum((T_sim1- T_trainX).^2)./M; %均方误差 MSE



%%  绘图
figure
plot(1:500,T_trainX,'r-o',1:500,T_sim1,'b-*','LineWidth',1.5)
legend('真实值','预测值')
xlabel('X轴预测样本')
ylabel('X轴结果')
string={['(R^2 =' num2str(R1) ' RMSE= ' num2str(error1) ' MSE= ' num2str(mse1) '' ]};
title(string)


%% Y轴

load C2.mat
load Ymodel.mat
data=C2;
%% 用三车预测另外一车
input =data(:,1:3)';%获取三车车轨迹； 转置为一行
output=data(:,4)';%获取第四车轨迹； 转置为一行

%%  

numFeatures = size(input,1);  % 特征个数，即特征变量的个数
outdim=size(output,1); %输出的维度

nwhole =size(data,1);
train_ratio=0.8;
M=round(nwhole*train_ratio);%获取最近的整数
N =nwhole-M;

P_train =input;
T_trainY=output;


P_test =input(:, M+1:M+N);
T_test=output(:,M+1:M+N);


%%  数据归一化
[pc_train, ps_input] = mapminmax(P_train);
pc_test = mapminmax('apply', P_test, ps_input);

[tc_train, ps_output] = mapminmax(T_trainY);
tc_test = mapminmax('apply', T_test, ps_output);



%%  结果数据预测
t_sim2 = predict(Ymodel, pc_train); 
T_sim2 = t_sim2;

%%  数据反归一化
T_sim2 = mapminmax('reverse', T_sim2, ps_output);


%%  
error2 = sqrt(sum((T_sim2- T_trainY).^2)./M); %均方根误差 RMSE
R2=eva1(T_trainY,T_sim2);  %决定系数
mse2 = sum((T_sim2- T_trainY).^2)./M; %均方误差 MSE



%%  绘图
figure
plot(1:500,T_trainY,'r-o',1:500,T_sim2,'b-*','LineWidth',1.5)
legend('真实值','预测值')
xlabel('Y轴预测样本')
ylabel('Y轴结果')
string={['(R^2 =' num2str(R2) ' RMSE= ' num2str(error2) ' MSE= ' num2str(mse2) '' ]};
title(string)


Ture=[T_trainX;T_trainY];
Tpre=[T_sim1;T_sim2];
T=[Tpre;  Ture];
A=T(:,313-187:313+187);



x1=A(3,:)-A(1,:);
y1=A(4,:)-A(2,:);

dx = (x1).^2;
dy = (y1).^2;
L=sqrt(dx+dy);

disp(['平均绝对误差MAE为：',num2str(mean(L))])
disp(['均方根误差RMSE为：  ',num2str(sqrt(mean(L.^2)))])


figure
subplot(1,3,1)
set(gcf,'Position',[20 100 1300 550]);	    
set(gcf,'Color','w'); 

plot(x1,'r','Linewidth', 2);

xlabel('X-axis piont number','FontSize',15,'FontName','Times New Roman');
ylabel('Error (m)','FontSize',15,'FontName','Times New Roman');
set(gca,'FontSize',15)

subplot(1,3,2)    
set(gcf,'Color','w'); 
plot(y1,'r','Linewidth', 2);

xlabel('Y-axis piont number','FontSize',15,'FontName','Times New Roman');
ylabel('Error (m) ','FontSize',15,'FontName','Times New Roman');
set(gca,'FontSize',15)

subplot(1,3,3)
set(gcf,'Color','w'); 


plot(A(1,:),A(2,:),'r','Linewidth', 2);
hold on;
plot(A(3,:),A(4,:),'k--','Linewidth', 2);


xlabel('X-axis (m)','FontSize',15,'FontName','Times New Roman');
ylabel('Y-axis (m)','FontSize',15,'FontName','Times New Roman');
set(gca,'FontSize',15)

legend(['IDBO-TCCBRN' newline ''],['Target' newline ''],'Orientation','horizontal');

