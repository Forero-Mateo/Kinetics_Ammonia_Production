clear;

% Range of Optimized Parameters
L = linspace(1,20)';
To = linspace(400,800)';
N = linspace(1,25)';


% Storing zero value arrays
Xa_out1  = zeros(100,1);
Xa_out2  = zeros(100,1);
Xa_out3  = zeros(100,1);
Ta_in1    = zeros (100,1);
Ta_in2    = zeros (100,1);
Ta_in3    = zeros (100,1);
% Iterating through Parameters for To
for i = drange(1:length(L))
    [V,Y] = PD_Reactor(L(i),600,20);
    Xa_out1(i) = Y(100,1);
    Ta_in1(i)  = Y(100,3);
end
[~, idx1] = max(Xa_out1);

fprintf('Ideal Length: %.4f  \n Total Xa: %.4f \n\n',[L(idx1),Xa_out1(idx1)]) 

% % Iterating through Parameters for ratio Fso/Fao
for i = drange(1:length(L))
    [V,Y] = PD_Reactor(L(idx1),To(i),20);
    Xa_out2(i) = Y(100,1);  
    Ta_in2(i)  = Y(100,3);
end
[~, idx2] = max(Xa_out2);
fprintf('Ideal Temperature: %.4f  \n Total Xa: %.4f \n\n',[To(idx2),Xa_out2(idx2)])


for i = drange(1:length(L))
    [V,Y] = PD_Reactor(L(idx1),To(idx2),N(i));
    Xa_out3(i) = Y(100,1);  
    Ta_in3(i)  = Y(100,3);
end
[val, idx3] = max(Xa_out3);
fprintf('Ideal Number of Pipes: %.1f  \n Total Xa: %.4f \n\n',[round(N(idx3)),Xa_out3(idx3)])




figure(1);
subplot(1,2,1)
plot(L,Xa_out1)
title('Conversion Vs Length of Reactor')
xlabel('Length [X]')
ylabel('Xa')
subplot(1,2,2)
plot(L, Ta_in1)
title('Ta_in vs Length of Reactor')
xlabel('L')
ylabel('Ta_in 2')

figure(2)
subplot(1,2,1)
plot(To,Xa_out2)
title('Conversion vs Initial Temperature')
xlabel('To')
ylabel('Xa')
subplot(1,2,2)
plot(To, Ta_in2)
title('Ta_in 2 vs To')
xlabel('To')
ylabel('Ta_in 2')

figure(3)
subplot(1,2,1)
plot(N,Xa_out3)
title('Conversion Vs Number of Pipes')
xlabel('N')
ylabel('Xa')
subplot(1,2,2)
plot(N, Ta_in3)
title('Ta_in vs Number of Pipes')
xlabel('N')
ylabel('Ta_in 3')








