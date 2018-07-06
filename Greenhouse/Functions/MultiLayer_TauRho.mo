within Greenhouse.Functions;
function MultiLayer_TauRho
  "Transmission and reflection coefficient of a double layer"
  input Real tau_1;
  input Real tau_2;
  input Real rho_1;
  input Real rho_2;
  output Real tau_12;
  output Real rho_12;

algorithm
  tau_12:= tau_1*tau_2/(1-rho_1*rho_2);
  rho_12:= rho_1 + tau_1^2*rho_2/(1-rho_1*rho_2);

end MultiLayer_TauRho;
