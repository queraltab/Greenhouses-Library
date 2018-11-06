within Greenhouses.Flows.VapourMassTransfer;
model MV_CanopyTranspiration
  "Vapour mass flow released by the canopy due to transpiration processes. The model must be connected like the following: canopy (filled port) - air (unfilled port)"
  extends Greenhouses.Interfaces.Vapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "floor surface";
//   parameter Boolean rb_constant=true
//     "if true, constant boundary layer resistance of the canopy for vapour transport, else, computed with d and u";
//  parameter Modelica.SIunits.Length d=0.5 "characteristic length of the leaf" annotation (Dialog(enable=not rb_constant));

  /*********************** Varying inputs ***********************/
  Real CO2_ppm(unit="umol/mol")=350 "CO2 concentration in ppm of internal air"  annotation (Dialog(group="Varying inputs"));
  Real LAI = 1 "Leaf Area Index"
    annotation (Dialog(group="Varying inputs"));
//  Modelica.SIunits.Velocity u = 0.04 "Local air velocity"   annotation (Dialog(group="Varying inputs",enable=not rb_constant));
//  Modelica.SIunits.HeatFlux I_g = 300 "outside global solar radiation"  annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.HeatFlux R_can = 100 "Global irradiation above the canopy"  annotation (Dialog(group="Varying inputs"));

  Modelica.SIunits.Temperature T_can=300 "Temperature of the canopy (port a)"
    annotation (Dialog(group="Varying inputs"));
//  Modelica.SIunits.Temperature T_air=300
//    "Temperature of the inside air (port b)"
//    annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Real E_kgsm2(unit="kg/(s.m2)") "Canopy transpiration";
  Real E_Wm2(unit="W/m2") "Canopy transpiration";
  Modelica.SIunits.PressureCoefficient gamma=65.8 "psychometric constant";
  Real r_s(unit="s/m") "stomatal resistance of the leaves";
  Real r_bV(unit="s/m") "boundary layer resistance to heat mass of the leaves";
//  Real r_bH(unit="s/m") "boundary layer resistance to heat transfer of the leaves";
  Modelica.SIunits.Density rho=1.23 "of the air";
  Modelica.SIunits.SpecificHeatCapacity C_p=1005 "of the air";

  Real Le=0.89 "Lewis number for vapour";
  Real r_min(unit="s/m") "minimum possible canopy resistance";
  Real r_I "short-wave radiation resistance";
  Real r_T "temperature resistance";
  Real r_CO2 "CO2 resistance";
  Real r_VP "vapour pressure deficit resistance";
  Modelica.SIunits.Pressure VP_can "vapour pressure of the canopy";
  Modelica.SIunits.Pressure VP_air "vapour pressure of interior air";
  Real C_1(unit="W/m2");
  Real C_2(unit="W/m2");
  Real C_3(unit="1/K2");
  Real C_4;
  Real C_5(unit="1/Pa2");
  Modelica.SIunits.Temperature T_m
    "temperature at which the resistance on the leave is minimal";
  Real VEC_canAir(unit="kg/(s.Pa.m2)") "Mass transfer coefficient";
  Real S_rs;
  Modelica.SIunits.SpecificEnergy DELTAH=2.45e6
    "latent heat of water vaporization";

  Real r_s2(unit="s/m");

equation
  VP_can = port_a.VP;
  VP_air = port_b.VP;

  // Boundary layer resistance to heat mass (determined by micro-climatic conditions)
//   // r_bV computed from the resistance to heat transport r_bH
//   r_bV = Le^(2/3)*r_bH;
//   r_bH = 1174*d^0.5 / (d*abs(T_can - T_air) + max(1e-9,207*u^2))^0.25;

  // Since no wind speed in the greenhouse is measured, a constant value is used
  r_bV = 275;

  // Stomatal resistance (actively regulated by the canopy)
//  r_T = 1 + C_3*(T_can - T_m)^2;
//   r_CO2 = min(1.5,1 + C_4*(CO2_ppm - 200)^2);
//   r_VP = min(3.8,1 + C_5*(VP_can - VP_air)^2);
//   if I_g==0 then
//     //Nighttime
//     r_min = 658.5;
//     C_1 = 0;
//     C_2 = -999 "avoid division by 0";
//     C_3 = 0.5e-2;
//     T_m = 273.15+33.6;
//     C_4 = 1.1e-11;
//     C_5 = 5.2e-6;
//     r_I = -999;
//     r_s = r_min * r_T * r_CO2 * r_VP "Stanghellini (1987)";
//   else
//     //Daytime
//     r_min = 82;
//     C_1 = 4.3;
//     C_2 = 0.54;
//     C_3 = 2.3e-2;
//     T_m = 273.15+24.5;
//     C_4 = 6.1e-7;
//     C_5 = 4.3e-6;
//     r_I = (P_can/(2*LAI) + C_1) / (P_can/(2*LAI) + C_2)
//       "P_can/LAI is the radiation flux per m2 of leaf";
//     r_s = r_min * r_I * r_T * r_CO2 * r_VP "Stanghellini (1987)";
//   end if;

  // Simplification
  r_s2 = r_min * r_I * r_CO2 * r_VP "Stanghellini (1987) eq 3.51";
  r_min = 82;
  r_I = (R_can/(2*LAI) + C_1) / (R_can/(2*LAI) + C_2)
    "R_can/(2*LAI) is the mean irradiation per unit leaf area";
  r_CO2 = min(1.5,1 + C_4*(CO2_ppm - 200)^2);
  r_VP = min(3.8,1 + C_5*(VP_can - VP_air)^2);

  r_T = 1+C_3*(T_can-T_m)^2;
  C_3 = 0.5e-2*(1-S_rs) + 2.3e-2*S_rs;
  T_m = (33.6+273.15)*(1-S_rs) + (24.5+273.15)*S_rs;
  r_s = r_min * r_I * r_CO2 * r_VP * r_T;

  C_1 = 4.3;
  C_2 = 0.54;
  S_rs = 1/(1+exp(-(R_can-5)))
    "Value of the differentiable switch to make the condition above a differentiable equation. 0: nightttime, 1: daytime";
  C_4 = 1.1e-11*(1-S_rs) + 6.1e-7*S_rs;
  C_5 = 5.2e-6*(1-S_rs) + 4.3e-6*S_rs;

  // Canopy transpiration
  VEC_canAir = 2*rho*C_p*LAI / (DELTAH*gamma*(r_bV + r_s));

  MV_flow = A*VEC_canAir*(VP_can - VP_air);

  E_kgsm2 = MV_flow/A;
  E_Wm2 = E_kgsm2*DELTAH;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Polygon(
          points={{22,-45},{-18,-25},{-18,-9},{-6,-15},{-16,3},{-24,11},{-24,19},
              {-14,17},{-20,25},{-24,33},{-28,45},{-16,43},{-4,27},{-2,33},{2,37},
              {10,29},{12,7},{16,9},{16,17},{22,17},{28,1},{22,-45}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid,
          origin={-2,-21},
          rotation=-90),
        Text(
          extent={{-180,20},{180,-20}},
          textString="%name",
          lineColor={0,0,255},
          origin={0,-86},
          rotation=360),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={-28,48},
          rotation=90),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={2,48},
          rotation=90),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={32,48},
          rotation=90)}),         Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end MV_CanopyTranspiration;
