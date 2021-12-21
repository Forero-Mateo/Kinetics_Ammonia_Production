clear;
% Range of Optimized Parameters
L1 = linspace(1,10,15)';
L2 = linspace(1,10,15)';
To = linspace(600,750);
T2 = linspace(650,750)';
N = linspace(1,40)';
% Storing zero value arrays
Xa_out1  = zeros(100,2);
Xa_out2  = zeros(100,3);
Xa_out3  = zeros(100,3);
Xa_out4  = zeros(100,2);
k = 1;
% Iterating through Parameters for To

for i = drange(1:length(T2))
    [V, Y, V2, Z] = HX_Reactor(8.1,10,606,T2(i),17);    
     Xa_out1(i,1) = Z(100,1);
     Xa_out1(i,2) = T2(i);
end
[~, idx1] = max(Xa_out1(:,1));
fprintf('Ideal Tin: %.2f  \nConversion: %.4f \n\n',[Xa_out1(idx1,2),Xa_out1(idx1,1)]) 



for i = drange(1:length(To))
    [V, Y, V2, Z] = HX_Reactor(8.1,10,To(i),Xa_out1(idx1,2),17);    
     Xa_out2(i,1) = Z(100,1);
     Xa_out2(i,2) = To(i);
end
[~, idx2] = max(Xa_out2(:,1));
fprintf('Ideal To: %.2f  \nConversion: %.4f \n\n',[Xa_out2(idx2,2),Xa_out2(idx2,1)]) 

for i = drange(1:length(L1))
    for j = drange(1:length(L2))
        [V, Y, V2, Z] = HX_Reactor(L1(i),L2(j),Xa_out2(idx2,2),Xa_out1(idx1,2),17);    
        Xa_out3(k,1) = Z(100,1);
        Xa_out3(k,2) = L1(i);
        Xa_out3(k,3) = L2(j);
        k = k+1;
    end
end
[~, idx3] = max(Xa_out3(:,1));

fprintf('Ideal L1: %.4f  \nideal L2:  %.4f \nConversion: %.4f \n\n',...
    [Xa_out3(idx3,2),Xa_out3(idx3,3),Xa_out3(idx3,1)]) 


for i = drange(1:length(N))
    [V, Y, V2, Z] = HX_Reactor(Xa_out3(idx3,2),Xa_out3(idx3,3),...
        Xa_out2(idx2,2),Xa_out1(idx1,2),N(i));    
    
     Xa_out4(i,1) = Z(100,1);
     Xa_out4(i,2) = N(i);
end
[~, idx4] = max(Xa_out4(:,1));
fprintf('Ideal N of Pipes: %.2f  \nConversion: %.4f \n\n',[Xa_out4(idx4,2),Xa_out4(idx4,1)])


figure(2)
plot(To,Xa_out2(:,1))
title('Conversion vs Initial Temperature')
xlabel('To')
ylabel('Xa')

figure(3)
plot(T2,Xa_out1(:,1))
title('Conversion vs Cool Temperature')
xlabel('T2')
ylabel('Xa')