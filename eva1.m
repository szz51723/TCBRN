function R2=eva1(T_train,T_sim1)

N = length(T_train);
R2=(N*sum(T_sim1.*T_train)-sum(T_sim1)*sum(T_train))^2/((N*sum((T_sim1).^2)-(sum(T_sim1))^2)*(N*sum((T_train).^2)-(sum(T_train))^2));
