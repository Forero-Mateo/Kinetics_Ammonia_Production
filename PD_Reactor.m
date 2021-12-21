function [V, Y] = PD_Reactor(L,To,N)
  % Constants
   Fto  = 2500;
   Cat_Density = 5;
   D_Vessel =  1.1;
   V_Pipes = N*(pi*0.0508^2*L)/4;
   V_total = (pi*D_Vessel^2*L)/4;
   V_cat = V_total - V_Pipes;
   HX_Area = N*pi*0.0381*L;
   alpha = 0.0075;
   
   Po = 225;  % Atm
   yAo = 0.35;
   yBo = 0.65;
   yCo = 1 - yBo - yAo;
   Fao = Fto*yAo; 
   
   U = 2094.4;   
   a1 = (HX_Area/V_cat); 
   
   % ODE Initial Value and Range
   y0 = [0.00085; To; To; 1];
   Vspan = linspace(0.001,V_cat);
  

   [V,Y] = ode15s(@(V,Y)fun(V,Y,yAo,yBo,yCo,Fao,U,a1,Po,...
       Cat_Density,To,alpha,Fto),Vspan,y0);
   
   subplot(2,2,1)
   plot(V,Y(:,2),V,Y(:,3))
   legend('T','Tf')
   subplot(2,2,2)
   plot(V,Y(:,1))
   subplot(2,2,3)
   plot(V,Y(:,4)*Po)
end
% Y = [ Xa ]  Y(1)
%     [ T  ]  Y(2)
%     [ Ta ]  Y(3)
%     [ y  ]  Y(4)
%
% dY = [ dXa/dV  ]
%      [ dT/dV   ]
%      [ dTa/dV  ]
%      [ dy/dV  ]
function dY = fun(~,Y,yAo,yBo,yCo,Fao,U,a1,Po,...
       Cat_Density,To,alpha,Fto)
    
  % ODE Solutions
  Xa = Y(1);
  T  = Y(2);
  Ta = Y(3);
  y  = Y(4);
  % do all algebraic equations 1st
  Fa = Fao*(1-Xa);
  Fb = Fao*((yBo/yAo) - 3*Xa);
  Fc = Fao*((yCo/yAo) +2*Xa);
  Ft  = Fa + Fb + Fc;
  
  yA = Fa/Ft;
  yB = Fb/Ft;
  yC = Fc/Ft;
  
  P = Po*y;
  Pa = P*yA;
  Pb = P*yB;
  Pc = P*yC;
  
  k1 = 1.78954e4*exp(-87090/(8.314*T));
  k2 = 2.5714e16*exp(-198464/(8.314*T));
  %ra = -2*((k1*Pa*Pb^1.5 - k2*Pc^2/Pb^1.5)/(1+2*Pc));
  ra = -(k1*(Pa*Pb^(3/2)/Pc) - k2*(Pc/Pb^1.5));
  Cpa = 27.196 + 0.004184*T;
  Cpb = 27.6981 + 0.003389*T;
  Cpc = 28.03 + 0.02636*T;
  
  Hrxn = -92380 + integral(@(X)-54.23+0.0383*X,298,T);
  
  dY = [(-ra/Fao)
      (U*a1*(Ta - T) + (ra*Hrxn))/(Fa*Cpa+Fb*Cpb+Fc*Cpc)
      (U*a1*(Ta - T))/(Fa*Cpa+Fb*Cpb+Fc*Cpc)
      (-alpha*Cat_Density)/(2*y)*(T/To)*(Ft/Fto)];
end