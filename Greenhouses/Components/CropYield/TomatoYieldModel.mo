within Greenhouses.Components.CropYield;
model TomatoYieldModel

  //***************** Parameters *******************//
  parameter Integer n_dev=50 "Number of fruit development stages";
  parameter Real LAI_MAX=3.5 "Maximum leaf area index, m2 leaf/m2 greenhouse";

  //***************** Varying inputs *******************//
  Real R_PAR_can(unit="umol/(s.m2)")=460
    "Total PAR absorbed by the canopy computed in the solar and illumination model" annotation (Dialog(group="Varying inputs"));
  Real CO2_air(unit="umol/mol")=600
    "CO2 concentration of the greenhouse air, umol CO2/mol air" annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_canK=293.15 "Instantaneous canopy temperature" annotation (Dialog(group="Varying inputs"));

  //***************** Constant parameters characteristic of the plant ***************************//
  Real C_Buf_MAX(unit="mg/m2") = 20e3 "Maximum buffer capacity";
  Real C_Buf_MIN(unit="mg/m2") = 1e3
    "Minimum amount of carbohydrates in the buffer";

  //***************** Variables *******************//
  Real MC_AirBuf(unit="mg/(m2.s)") "Net photosynthesis rate";
  Real C_Buf(unit="mg/m2", start=0, fixed=true) "Carbohydrates in the buffer";
  Real CO2_stom(unit="umol/mol")
    "CO2 concentration in the stomata, umol CO2/ mol air";

  Real LAI(start=LAI_0) "Leaf Area Index, m2 leaf/m2 greenhouse";
  parameter Real LAI_0=0.4 annotation(Dialog(tab="Initialization"));

  Real MC_BufFruit(unit="mg/(m2.s)")
    "Carbohydrate flow from the buffer to the fruits";
  Real MC_BufLeaf(unit="mg/(m2.s)")
    "Carbohydrate flow from the buffer to the leaves";
  Real MC_BufStem(unit="mg/(m2.s)")
    "Carbohydrate flow from the buffer to the stems and roots";

  Real T_canC(unit="degC");
  Real T_can24C(unit="degC", start=0, fixed=true);
  Real T_canSumC(unit="degC", start=T_canSumC_0, fixed=true) "Temperature sum";
  parameter Real T_canSumC_0(unit="degC")=0 annotation(Dialog(tab="Initialization"));

  Real MN_BufFruit_1(unit="1/(m2.s)")
    "Fruit set in the first development stage, fruits/(m2.s)";
  Real MN_BufFruit_1_MAX(unit="1/(m2.s)") "Maximum fruit set, fruits/(m2.s)";
  Real MC_BufFruit_1(unit="mg/(m2.s)")
    "Carbohydrate flow to the first development stage";
  Real MC_FruitHar(unit="mg/(m2.s)");
  Real W_Fruit_1_Pot(unit="mg", start=0, fixed=true)
    "Potential dry matter per fruit in fruit development stage one, mg/fruit";

  Real MC_BufAir(unit="mg/(m2.s)") "Growth respiration of the total plant";
  Real MC_FruitAir_g(unit="mg/(m2.s)") "Growth respiration of the fruits";
  Real MC_LeafAir_g(unit="mg/(m2.s)") "Growth respiration of the leaves";
  Real MC_StemAir_g(unit="mg/(m2.s)")
    "Growth respiration of the stems and roots";
  Real MC_FruitAir(unit="mg/(m2.s)")
    "Total maintenance respiration of the fruits";
  Real MC_LeafAir(unit="mg/(m2.s)") "Maintenance respiration of the leaves";
  Real MC_StemAir(unit="mg/(m2.s)")
    "Maintenance respiration of the stems and roots";
  Real C_Leaf(unit="mg/m2",start=C_Leaf_0,fixed=true) "Carbohydrate weight of leaves";
  parameter Real C_Leaf_0(unit="mg/m2")=15e3 annotation(Dialog(tab="Initialization"));
  Real C_Stem(unit="mg/m2",start=C_Stem_0,fixed=true)
    "Carbohydrate weight of stems and roots";
  parameter Real C_Stem_0(unit="mg/m2")=15e3 annotation(Dialog(tab="Initialization"));

  Real C_Leaf_MAX(unit="mg/m2")
    "Maximum allowed carbohydrates stored in the leaves";
  Real MC_LeafHar(unit="mg/(m2.s)") "Leaf harvest rate";

  Real DM_Har(unit="mg/m2", start=0, fixed=true) "Accumulated harvested tomato dry matter";

  Real MC_AirCan(unit="mg/(m2.s)")
    "CH2O flux between the greenhouse air and the canopy, which depends on the canopy photosynthesis rate and respiration processes";
  Real MC_AirCan_mgCO2m2s(unit="mg/(m2.s)")
    "CO2 flux between the greenhouse air and the canopy, mg CO2/(m2.s)";

//   Real W_Fruit_t1[n_dev](start=zeros(n_dev));
//   Real W_Leaf_t1(start=0);
//   Real W_Stem_t1(start=0);
//   Real RGR_Fruit_3[n_dev](each unit="1/s");
//   Real RGR_Leaf_3(unit="1/s");
//   Real RGR_Stem_3(unit="1/s");
  /******************** Parameters *********************/
protected
  Real M_CH2O(unit="mg/umol") = 30e-3 "Molar mass of CH2O";
  Real M_CO2(unit="mg/umol") = 44e-3 "Molar mass of CO2";
  Real alpha=0.385
    "Conversion factor from photons to electrons, umol e-/umol photons";
  Real theta=0.7 "Degree of curvature of the electron transport rate";
  Real E_j(unit="J/mol")=37e3 "Activation energy for J_POT";
  Real H(unit="J/mol")=22e4 "Deactivation energy";
  Modelica.SIunits.Temperature T_25K=298.15 "Reference temperature at 25ºC";
  Real Rg(unit="J/(mol.K)")=8.314 "Molar gas constant";
  Real S(unit="J/(mol.K)")=710 "Entropy term";
  Real J_25Leaf_MAX(unit="umol/(m2.s)")=210
    "Maximum rate of electron transport at 25ºC for the leaf, umol e-/(m2 leaf.s)";
  Real eta_CO2airStom=0.67
    "Conversion factor from the CO2 concentration of the greenhouse air";
  Real c_Gamma(unit="umol/(mol.K)")=1.7
    "Determines the effect of canopy temperature on the CO2 compensation point";
  Real eta_Glob_PAR(unit="umol/J")=2.3
    "Conversion factor from global radiation to PAR, umol photols/J";

  Real T_can_MIN(unit="degC")=10;
  Real T_can_MAX(unit="degC")=34;
  Real T_can24_MIN(unit="degC")=15;
  Real T_can24_MAX(unit="degC")=24.5;
  Real T_endSumC(unit="degC")=1035
    "Temperature sum when the fruit growth rate is at full potential";
  Real rg_Fruit(unit="mg/(m2.s)")=0.328
    "Potential fruit growth rate coefficient at 20ºC";
  Real rg_Leaf(unit="mg/(m2.s)")=0.095
    "Potential leaf growth rate coefficient at 20ºC";
  Real rg_Stem(unit="mg/(m2.s)")=0.074
    "Potential stem growth rate coefficient at 20ºC";

  Real r_BufFruit_MAXFrtSet(unit="mg/(m2.s)")=0.05
    "Carbohydrate flow from buffer to the fruits above which fruit set is maximal";
  Real n_plants(unit="1/m2") "Plant density in the greenhouse, plants/m2";
  Real c_BufFruit_1_MAX(unit="1/s")=-1.71e-7
    "Regression coefficient, fruits/(plant.s)";
  Real c_BufFruit_2_MAX(unit="1/(s.degC)")=7.31e-7
    "Regression coefficient, fruits/(plant.s.degC)";

  Real c_dev_1(unit="1/s")=-7.64e-9 "Regression coefficient";
  Real c_dev_2(unit="1/(s.degC)")=1.16e-8 "Regression coefficient";
  Real G_MAX(unit="mg")=1e4 "Potential fruit weight";

  Real c_Fruit_g=0.27 "Growth respiration coefficient of fruit";
  Real c_Leaf_g=0.28 "Growth respiration coefficient of leaf";
  Real c_Stem_g=0.3 "Growth respiration coefficient of stem";
  Real c_Fruit_m=1.16e-7 "Maintenance respiration coefficient of fruit";
  Real c_Leaf_m=3.47e-7 "Maintenance respiration coefficient of leaf";
  Real c_Stem_m=1.47e-7 "Maintenance respiration coefficient of stem";
  Real Q_10_m=2 "Q_10 value for temperature effect on maintenance respiration";
  Real c_RGR(unit="s")=2.85e6
    "Regression coefficient for maintenance respiration";

  Real SLA(unit="m2/mg")=2.66e-5 "Specific leaf area index, m2 leaf/mg CH2O";

  Real eta_C_DM=1 "Conversion factor from carbohydrate to dry matter";
  Real tau(unit="s")=86400
    "Time constant to calculate the 24 hour mean temperature";
  Real k=1 "Gain of the process to calculate the 24 hour mean temperature";

  /**************************** Variables ************************/
  Modelica.SIunits.Temperature T_can24K;

  Real h_CBuf_MCairBuf "Inhibition coefficient";
  Real P(unit="umol/(m2.s)") "Gross photosynthesis rate at canopy level";
  Real R(unit="umol/(m2.s)")
    "Photoresipiration during the photosynthesis process";
  Real Gamma(unit="umol/mol") "CO2 compensation point, umol CO2/ mol air";
  Real J(unit="umol/(m2.s)") "Electron transportation rate, umol e-/(m2.s)";
  Real J_POT(unit="umol/(m2.s)")
    "Potential rate of electron transport, umol e-/(m2.s)";
  Real J_25Can_MAX(unit="umol/(m2.s)")
    "Maximum rate of electron transport at 25ºC for the canopy";
  Real PAR_can(unit="umol/(m2.s)")
    "Total PAR absorbed by the canopy computed in the solar model, umol photon/(m2.s)";
  Real h_CBuf_MCBufOrg "Inhibition coefficient";
  Real h_Tcan;
  Real h_Tcan24;
  Real h_TcanSum;
  Real g_Tcan24;

  Real r_dev(unit="1/s") "Fruit development rate";
  Real h_T_canSum_MN_Fruit;
  Real eta_BufFruit(unit="d.m2/mg")
    "Conversion factor to ensure that MC_BufFruit equals the sum of the carbohydrates that flow to the different fruit development stages";
  Real GR[n_dev](each unit="mg/d")
    "Daily potential growth rate per fruit in a development stage, mg CH2O/(fruit.day)";
  Real B(unit="1/d") "Steepness of the curve";
  Real t_j_FGP[n_dev](each unit="d")
    "Number of days after fruit set for development stage j";
  Real M(unit="d") "Fruit development time in days where GR is maximal";
  Real FGP(unit="d") "Fruit Growth period";
  Real RGR_Fruit[n_dev](each unit="1/s") "Net relative growth rate";
  Real RGR_Leaf(unit="1/s") "Net relative growth rate";
  Real RGR_Stem(unit="1/s") "Net relative growth rate";
  Real RGR_Fruit_2[n_dev](each unit="1/s") "Net relative growth rate";

  Real MN_Fruit[n_dev-1,n_dev](each unit="1/(m2.s)", each start=0, each fixed=true)
    "Fruit flow through the fruit development stages";
  Real N_Fruit[n_dev](each unit="1/m2")
    "Number of fruits in the development stage i, fruits/m2";
  Real MC_Fruit[n_dev,n_dev+1](each unit="mg/(m2.s)")
    "Fruit carbohydrates flow through the fruit development stages";
  Real C_Fruit[n_dev](each unit="mg/m2", each start=0, each fixed=true)
    "Amount of fruit carbohydrates in the development stage i";
  Real MC_BufFruit_j[n_dev](each unit="mg/(m2.s)")
    "Carbohydrate flow from the buffer to the remaining development stages";
  Real MC_FruitAir_j[n_dev](each unit="mg/(m2.s)")
    "Maintenance respiration of the fruits";

public
  Modelica.Blocks.Sources.Ramp plant_density(
    height=1,
    duration=5356800,
    offset=2.5,
    startTime=2678400)
    "Plant density increases after 1 month, and reaches 3.5 after 2 months"
    annotation (Placement(transformation(extent={{-12,0},{8,20}})));
equation
  T_canC=T_canK-273.15;
  T_can24K=T_can24C+273.15;
  n_plants = plant_density.y;
  // STATE VARIABLES //

  der(C_Buf) = MC_AirBuf - MC_BufFruit - MC_BufLeaf - MC_BufStem - MC_BufAir;

  der(C_Fruit[1]) = MC_BufFruit_1 - MC_Fruit[1,2] - MC_FruitAir_j[1];
  for j in 2:n_dev loop
    der(C_Fruit[j]) = MC_BufFruit_j[j] + MC_Fruit[j-1,j] - MC_Fruit[j,j+1] - MC_FruitAir_j[j];
  end for;

  der(N_Fruit[1]) = MN_BufFruit_1 - MN_Fruit[1,2];
  for j in 2:(n_dev-1) loop
    der(N_Fruit[j]) = MN_Fruit[j-1,j] - MN_Fruit[j,j+1];
  end for;
  der(N_Fruit[n_dev]) = MN_Fruit[n_dev-1,n_dev];

  der(C_Leaf) = MC_BufLeaf - MC_LeafAir - MC_LeafHar;

  LAI = SLA*C_Leaf;

  der(C_Stem) = MC_BufStem - MC_StemAir;

  der(DM_Har) = eta_C_DM * MC_FruitHar;

  der(T_canSumC) = 1/86400*T_canC;

  der(T_can24C) = 1/tau*(k*T_canC - T_can24C);

  // MODEL FLOWS //

  //***************** Canopy photosynthesis *******************//
  // Net photosynthesis rate
  MC_AirBuf = M_CH2O*h_CBuf_MCairBuf*(P-R);
  h_CBuf_MCairBuf = 1/(1+exp(5e-3*(C_Buf-C_Buf_MAX))) "5e-4, 1e-3";

  P = J/4*(CO2_stom - Gamma)/(CO2_stom+2*Gamma);
  R = P*Gamma/CO2_stom;

  // Electron transport rate
  PAR_can = R_PAR_can;
  J = (J_POT + alpha*PAR_can - sqrt((J_POT+alpha*PAR_can)^2-4*theta*J_POT*alpha*PAR_can))/(2*theta);
  J_POT = J_25Can_MAX*exp(E_j*(T_canK-T_25K)/(Rg*T_canK*T_25K))*(1+exp((S*T_25K-H)/(Rg*T_25K)))/(1+exp((S*T_canK-H)/(Rg*T_canK)));
  J_25Can_MAX = LAI*J_25Leaf_MAX;

  // CO2 relationships in the photosynthetic tissue
  CO2_stom = eta_CO2airStom*CO2_air;
  Gamma = J_25Leaf_MAX/J_25Can_MAX*c_Gamma*T_canC + 20*c_Gamma*(1-J_25Leaf_MAX/J_25Can_MAX);

  //***************** The carbohydrate flow to the individual plant organs *******************//
  MC_BufFruit = h_CBuf_MCBufOrg*h_Tcan*h_Tcan24*h_TcanSum*g_Tcan24*rg_Fruit;
  MC_BufLeaf = h_CBuf_MCBufOrg*h_Tcan24*g_Tcan24*rg_Leaf;
  MC_BufStem = h_CBuf_MCBufOrg*h_Tcan24*g_Tcan24*rg_Stem;

  // Insufficient carbohydrates in the buffer
  h_CBuf_MCBufOrg = 1/(1+exp(-5e-2*(C_Buf-C_Buf_MIN))) "-5e-3, -1e-2";
  // Non-optimal instantaneous and 24 hour mean temperature
  h_Tcan = 1/(1+exp(-0.869*(T_canC-T_can_MIN))) * 1/(1+exp(0.5793*(T_canC-T_can_MAX)));
  h_Tcan24 = 1/(1+exp(-1.1587*(T_can24C-T_can24_MIN))) * 1/(1+exp(1.3904*(T_can24C-T_can24_MAX)));

  // Start of the generative phase
  h_TcanSum = 0.5*(1/T_endSumC*T_canSumC + sqrt(abs(1/T_endSumC*T_canSumC)^2+1e-4)) - 0.5*(1/T_endSumC*(T_canSumC-T_endSumC) + sqrt(abs(1/T_endSumC*(T_canSumC-T_endSumC))^2+1e-4));
  // Temperature effect on structural carbon flow to organs
  g_Tcan24 = 0.047*T_can24C + 0.06;

  //***************** Fruit number and carbohydrate flows to fruit development stages *******************//
  // Fruit set in the first development stage
  MN_BufFruit_1 = 1/(1+exp(-58.9*(MC_BufFruit-r_BufFruit_MAXFrtSet))) * MN_BufFruit_1_MAX;
  MN_BufFruit_1_MAX = n_plants*(c_BufFruit_1_MAX + c_BufFruit_2_MAX*T_can24C);
  // Fruit flow to the remaining development stages
algorithm
  //MN_Fruit = zeros(n_dev-1,n_dev);
  for j in 1:(n_dev-1) loop
    MN_Fruit[j,j+1] :=r_dev*n_dev*h_T_canSum_MN_Fruit*N_Fruit[j];
  end for;
equation
  r_dev = c_dev_1 + c_dev_2*T_can24C;
  h_T_canSum_MN_Fruit = 1/(1+exp(-5e-2*T_canSumC));

  // Carbohydrate flow to the first fruit development stage
  MC_BufFruit_1 = W_Fruit_1_Pot*MN_BufFruit_1;
  der(W_Fruit_1_Pot) = GR[1]/86400;
  // Carbohydrate flow from carbohydrate buffer to different fruit development stages
algorithm
  MC_Fruit :=zeros(n_dev, n_dev + 1);
  for j in 1:n_dev loop
    MC_Fruit[j,j+1] := r_dev*n_dev*C_Fruit[j];
  end for;
equation
  MC_FruitHar = MC_Fruit[n_dev,n_dev+1];
  // Carbohydrate flow from the carbohydrate buffer into the remaining fruit development stages
  MC_BufFruit_j[1]=MC_BufFruit_1;
  for j in 2:n_dev loop
    MC_BufFruit_j[j] =  eta_BufFruit * N_Fruit[j]*GR[j]*(MC_BufFruit - MC_BufFruit_1);
  end for;
  eta_BufFruit = 1/(N_Fruit*GR-N_Fruit[1]*GR[1]+1e-9) "j=2...n_dev";
  //GR[1]=0;
  for j in 1:n_dev loop
    t_j_FGP[j] = ((j-1)+0.5)/n_dev*FGP;
    GR[j] = G_MAX*exp(-exp(-B*(t_j_FGP[j]-M)))*B*exp(-B*(t_j_FGP[j]-M));
  end for;
  FGP = 1/(r_dev*86400);
  M = -4.93+0.548*FGP;
  B = 1/(2.44+0.403*M);

  //***************** Growth and maintenance respiration *******************//
  MC_BufAir = MC_FruitAir_g + MC_StemAir_g + MC_LeafAir_g;
  MC_FruitAir_g = c_Fruit_g*MC_BufFruit;
  MC_LeafAir_g = c_Leaf_g*MC_BufLeaf;
  MC_StemAir_g = c_Stem_g*MC_BufStem;

// algorithm
//   // RGR = (ln(W2)-ln(W1))/(t2-t1)
//   for j in 1:n_dev loop
//     RGR_Fruit_3[j] :=(Modelica.Math.log(C_Fruit[j] + 0.1) - Modelica.Math.log(
//       W_Fruit_t1[j] + 0.1));
//   end for;
//   RGR_Leaf_3 :=(Modelica.Math.log(C_Leaf) - Modelica.Math.log(W_Leaf_t1));
//   RGR_Stem_3 :=(Modelica.Math.log(C_Stem) - Modelica.Math.log(W_Stem_t1));
//
// algorithm
//   for j in 1:n_dev loop
//     W_Fruit_t1[j] := C_Fruit[j];
//   end for;
//   W_Leaf_t1 := C_Leaf;
//   W_Stem_t1 := C_Stem;

  for j in 1:n_dev loop
    MC_FruitAir_j[j] = c_Fruit_m*Q_10_m^(0.1*(T_can24C-25))*C_Fruit[j]*(1-exp(-c_RGR*RGR_Fruit[j]));
    RGR_Fruit_2[j] = 1/max(1e-9,C_Fruit[j])*rg_Fruit;
    RGR_Fruit[j] = GR[j]/G_MAX/86400;
  end for;

  MC_FruitAir = sum(MC_FruitAir_j);
  MC_LeafAir = c_Leaf_m*Q_10_m^(0.1*(T_can24C-25))*C_Leaf*(1-exp(-c_RGR*RGR_Leaf));
  RGR_Leaf = 1/C_Leaf*rg_Leaf;
  MC_StemAir = c_Stem_m*Q_10_m^(0.1*(T_can24C-25))*C_Stem*(1-exp(-c_RGR*RGR_Stem));
  RGR_Stem = 1/C_Stem*rg_Stem;

  //***************** Leaf pruning *******************//
  C_Leaf_MAX = LAI_MAX / SLA;
  MC_LeafHar = 1/(1+exp(-5e-5*(C_Leaf-C_Leaf_MAX))) * (C_Leaf-C_Leaf_MAX);

  //***************** Air exchange *****************//
  MC_AirCan = MC_AirBuf - MC_BufAir - MC_FruitAir - MC_LeafAir - MC_StemAir;
  MC_AirCan_mgCO2m2s = MC_AirCan/M_CH2O*M_CO2;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          extent={{-22,22},{-78,-28}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{32,-2},{72,18},{72,34},{60,28},{70,46},{78,54},{78,62},{68,60},
              {74,68},{78,76},{82,88},{70,86},{58,70},{56,76},{52,80},{44,72},{42,
              50},{38,52},{38,60},{32,60},{26,44},{32,-2}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,98},{2,-80}},
          lineColor={0,0,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-54,24},{-64,20},{-70,16},{-70,14},{-62,16},{-56,20},{-60,14},
              {-64,6},{-60,10},{-56,14},{-54,16},{-56,10},{-56,4},{-52,0},{-50,8},
              {-52,16},{-46,10},{-44,6},{-44,12},{-48,16},{-48,20},{-44,18},{-38,
              16},{-36,16},{-34,20},{-40,22},{-47.4805,23.4961},{-50,24},{-50.1463,
              32.0511},{-52,38},{-54,24},{-54,24}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4,58},{-6,58},{-16,58},{-24,56},{-34,54},{-40,48},{-46,46},{
              -50,40},{-54,36},{-56,34},{-58,34},{-58,32},{-56,32},{-54,32},{-52,
              34},{-48,38},{-44,44},{-40,46},{-36,50},{-34,52},{-28,54},{-18,56},
              {-14,56},{-6,56},{-4,56},{-4,58}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{2,10},{4,10},{14,10},{22,12},{32,14},{38,20},{44,22},{48,28},
              {52,32},{54,34},{56,34},{56,36},{54,36},{52,36},{50,34},{46,30},{42,
              24},{38,22},{34,18},{32,16},{26,14},{16,12},{12,12},{4,12},{2,12},
              {2,10}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-180,-80},{180,-112}},
          lineColor={0,128,0},
          textString="%name")}), Documentation(info="<html>
          <p><big>
          In this work, a recent yield model  developed and validated for a 
          variety of temperatures is implemented. The carbohydrate assimilation 
          is modeled by distinguishing three crop parts: the leaves, the fruits,
          and the stems (roots are considered together with the stems). Mass balances 
          are applied on each part and on the buffer. Carbohydrate flows are computed
          as a function of fixed parameters related to the tomato crop.
          </p>
          <p><big>
          The inputs of the model are the instantaneous temperature of the canopy, 
          the CO2 concentration of the greenhouse air and the PAR absorbed by the canopy.
          Their values are retrieved from the greenhouse climate simulation model,
          in which the former two are state variables from the <a href=\"modelica://Greenhouses.Components.Greenhouse.Canopy\">Canopy</a>
          and the <a href=\"modelica://Greenhouses.Components.Greenhouse.Air\">Air</a> models, 
          and the latter is function of the global irradiation (computed in the 
          <a href=\"modelica://Greenhouses.Components.Greenhouse.Solar_model\">Solar_model</a> model). 
          </p>
          <p><big>
          A detailed description of the model equations can be found in the online documentation of the library 
          <a href=\"https://greenhouses-library.readthedocs.io/en/latest\">https://greenhouses-library.readthedocs.io/en/latest</a> </p>
</html>"));
end TomatoYieldModel;
