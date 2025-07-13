%决定系数
function R2=eva1(T_test,T_sim2)

N = length(T_test);
R2=(N*sum(T_sim2.*T_test)-sum(T_sim2)*sum(T_test))^2/((N*sum((T_sim2).^2)-(sum(T_sim2))^2)*(N*sum((T_test).^2)-(sum(T_test))^2));