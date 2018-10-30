within Greenhouses.Components.Greenhouse;
model Illumination "Artificial Illumination of the greenhouse"
  /******************** Parameters ********************/
  parameter Boolean power_input=false
    "True if input is a power flux, False if input is the total power and greenhouse floor surface";
  parameter Modelica.SIunits.Power P_el "Total electrical power" annotation(Dialog(enable=not power_input));
  parameter Modelica.SIunits.Area A "floor surface" annotation(Dialog(enable=not power_input));
  parameter Real p_el(unit="W/m2")= 55 annotation(Dialog(enable=power_input));

  parameter Real K1_PAR=0.7 annotation (Dialog(group="Canopy"));
  parameter Real K2_PAR=0.7 annotation (Dialog(group="Canopy"));
  parameter Real K_NIR=0.27 annotation (Dialog(group="Canopy"));
  parameter Real rho_CanPAR=0.07 annotation (Dialog(group="Canopy"));
  parameter Real rho_CanNIR=0.35 annotation (Dialog(group="Canopy"));

  parameter Real rho_FlrPAR=0.07 annotation (Dialog(group="Floor"));
  parameter Real rho_FlrNIR=0.07 annotation (Dialog(group="Floor"));

  /******************** Varying inputs ********************/
  Real LAI = 1 "Leaf Area Index"
    annotation (Dialog(group="Varying inputs"));

  /******************** Variables ********************/
  Modelica.SIunits.HeatFlux R_NIR "near infrared radiation";
  Modelica.SIunits.HeatFlux R_PAR "visible light";
  Real tau_CF_NIR;
  Real rho_CF_NIR;
  Real alpha_CanNIR;
  Real alpha_FlrNIR;
  Modelica.SIunits.HeatFlux R_IluCan_PAR;
  Modelica.SIunits.HeatFlux R_FlrCan_PAR;
  Modelica.SIunits.HeatFlux R_IluCan_NIR;
  Modelica.SIunits.HeatFlux R_IluFlr_PAR;
  Modelica.SIunits.HeatFlux R_IluFlr_NIR;
  Modelica.SIunits.HeatFlux R_PAR_Can;
  Real P(unit="W/m2");
  Modelica.SIunits.Power W_el;
  Real eta_GlobPAR(unit="umol/J")= 1.8
    "umol PAR / J global radiation, High pressure sodium lamps";
  Real R_PAR_Can_umol(unit="umol/(s.m2)");

  /******************** Connectors ********************/
  Modelica.Blocks.Interfaces.RealInput switch
    annotation (Placement(transformation(extent={{-42,44},{-2,84}})));

  Flows.Interfaces.Heat.HeatFluxOutput R_IluAir_Glob annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={74,-70}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-70})));
  Flows.Interfaces.Heat.HeatFluxOutput R_IluCan_Glob annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,-70}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-70})));
  Flows.Interfaces.Heat.HeatFluxOutput R_IluFlr_Glob annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,-70}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-70})));
equation
  if cardinality(switch)==0 then
    switch=0;
  end if;

  if power_input then
    P=p_el;
  else
    P=P_el/A;
  end if;

  // Long-wave radiation
  R_IluAir_Glob = 0.58*P*switch
    "Power of transmitted radiation absorbed by obstacles and released to the air";

  // Short-wave radiation
  R_NIR = 0.17*P*switch;
  R_PAR = 0.25*P*switch;

  // Absorbed by the canopy: PAR Ilu(downwards), PAR Floor(upwards), NIR Ilu and Floor multi-layer model
  R_IluCan_Glob = R_IluCan_PAR + R_FlrCan_PAR + R_IluCan_NIR;
  R_IluCan_PAR = R_PAR*(1-rho_CanPAR)*(1-exp(-K1_PAR*LAI));
  R_FlrCan_PAR = R_PAR*exp(-K1_PAR*LAI)*rho_FlrPAR*(1-rho_CanPAR)*(1-exp(-K2_PAR*LAI));
  R_IluCan_NIR = R_NIR*alpha_CanNIR;
  R_PAR_Can = R_IluCan_PAR+R_FlrCan_PAR;
  R_PAR_Can_umol = R_PAR_Can/0.25*eta_GlobPAR;

  //Multi layer model for NIR (CF: canopy-floor; cover: Roof-ThermalScreen, CCF: cover-CF)
  (tau_CF_NIR,rho_CF_NIR) = .Greenhouses.Functions.MultiLayer_TauRho(
    exp(-K_NIR*LAI),
    1 - rho_FlrNIR,
    rho_CanNIR*(1 - exp(-K_NIR*LAI)),
    rho_FlrNIR);
  alpha_FlrNIR = tau_CF_NIR;
  alpha_CanNIR = 1-tau_CF_NIR-rho_CF_NIR;

  // Absorbed by floor
  R_IluFlr_Glob = R_IluFlr_NIR + R_IluFlr_PAR;
  R_IluFlr_NIR = R_NIR*alpha_FlrNIR;
  R_IluFlr_PAR = R_PAR*exp(-K1_PAR*LAI)*(1-rho_FlrPAR);

  // Electrical consumption
  W_el = P*A*switch;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={Line(
          points={{0,100},{0,20}},
          color={0,0,0},
          smooth=Smooth.None), Polygon(
          points={{-80,-60},{0,20},{80,-60},{-80,-60}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}));
end Illumination;
