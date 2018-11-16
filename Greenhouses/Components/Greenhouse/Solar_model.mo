within Greenhouses.Components.Greenhouse;
model Solar_model "Global, PAR and NIR heat fluxes"

  /********************* Parameters ***********************/
  parameter Modelica.SIunits.HeatCapacity Cap_leaf=1200
    "heat capacity of a square meter of canopy leaves";
  parameter Modelica.SIunits.Area A "floor surface";
  parameter Real eta_glob_air=0.1
    "Ratio of global radiation absorbed by greenhouse construction elements";

  parameter Real K1_PAR=0.7 annotation (Dialog(group="Canopy"));
  parameter Real K2_PAR=0.7 annotation (Dialog(group="Canopy"));
  parameter Real K_NIR=0.27 annotation (Dialog(group="Canopy"));
  parameter Real rho_CanPAR=0.07 annotation (Dialog(group="Canopy"));
  parameter Real rho_CanNIR=0.35 annotation (Dialog(group="Canopy"));

  parameter Real rho_FlrPAR=0.07 annotation (Dialog(group="Floor"));
  parameter Real rho_FlrNIR=0.07 annotation (Dialog(group="Floor"));

  parameter Real tau_RfPAR=0.85 annotation (Dialog(group="Roof"));
  parameter Real rho_RfPAR=0.13 annotation (Dialog(group="Roof"));
  parameter Real tau_RfNIR=0.85 annotation (Dialog(group="Roof"));
  parameter Real rho_RfNIR=0.13 annotation (Dialog(group="Roof"));

  parameter Real tau_thScrPAR=0.6 annotation (Dialog(group="Thermal Screen"));
  parameter Real rho_thScrPAR=0.35 annotation (Dialog(group="Thermal Screen"));
  parameter Real tau_thScrNIR=0.6 annotation (Dialog(group="Thermal Screen"));
  parameter Real rho_thScrNIR=0.35 annotation (Dialog(group="Thermal Screen"));

  /******************** Varying inputs ********************/
  Real LAI = 1 "Leaf Area Index"
    annotation (Dialog(group="Varying inputs"));
  Real SC=0 "Thermal screen closure" annotation (Dialog(group="Varying inputs"));

  /********************** Variables ***********************/
//   Modelica.SIunits.HeatFlux R_SunCov_Glob;
//   Modelica.SIunits.HeatFlux R_SunAir_Glob;
  Modelica.SIunits.HeatFlux R_t_PAR "Transmited flux of the cover";
  Modelica.SIunits.HeatFlux R_NIR "Incident flux on the cover";
  Modelica.SIunits.HeatFlux R_t_Glob
    "Total transmitted flux, radiation above the canopy";

//   Modelica.SIunits.HeatFlux R_SunCan_Glob "total short-wave radiation to the canopy";
  Modelica.SIunits.HeatFlux R_SunCan_PAR;
  Modelica.SIunits.HeatFlux R_FlrCan_PAR;
  Modelica.SIunits.HeatFlux R_SunCan_NIR;
  Modelica.SIunits.HeatFlux R_PAR_Can "Total PAR absorbed by the canopy";
  Real R_PAR_Can_umol(unit="umol/(s.m2)") "Total PAR absorbed by the canopy";
//   Modelica.SIunits.HeatFlux R_SunFlr_Glob "total short-wave radiation to the floor";
  Modelica.SIunits.HeatFlux R_SunFlr_PAR;
  Modelica.SIunits.HeatFlux R_SunFlr_NIR;

  Modelica.SIunits.Power P_SunCov_Glob;
  Modelica.SIunits.Power P_SunCan_Glob;
  Modelica.SIunits.Power P_SunAir_Glob;
  Modelica.SIunits.Power P_SunFlr_Glob;

  Real tau_CF_NIR;
  Real rho_CF_NIR;
  Real tau_CCF_NIR;
  Real rho_CCF_NIR;
  Real alpha_CanNIR;
  Real alpha_FlrNIR;
  Real tau_ML_covNIR;
  Real rho_ML_covNIR;
  Real tau_covNIR;
  Real rho_covNIR;
  Real alpha_covNIR;
  Real tau_ML_covPAR;
  Real rho_ML_covPAR;
  Real tau_covPAR;
  Real rho_covPAR;
  Real alpha_covPAR;
  Real eta_glob_PAR=0.5;
  Real eta_glob_NIR=0.5;
  Real eta_GlobPAR(unit="umol/J")= 2.3
    "Conversion factor from global radiation to PAR, umol photols/J";

  /********************* Connectors *********************/

  Interfaces.Heat.HeatFluxInput I_glob
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.Heat.HeatFluxOutput R_SunCov_Glob annotation (Placement(
        transformation(extent={{100,40},{120,60}}), iconTransformation(extent={
            {100,40},{120,60}})));
  Interfaces.Heat.HeatFluxOutput R_SunAir_Glob annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent=
            {{100,-10},{120,10}})));
  Interfaces.Heat.HeatFluxOutput R_SunCan_Glob annotation (Placement(
        transformation(extent={{100,-60},{120,-40}}), iconTransformation(extent=
           {{100,-60},{120,-40}})));
  Interfaces.Heat.HeatFluxOutput R_SunFlr_Glob annotation (Placement(
        transformation(extent={{100,-110},{120,-90}}), iconTransformation(
          extent={{100,-110},{120,-90}})));
equation
  if cardinality(I_glob)==0 then
    I_glob=0;
  end if;

  //Paremeters characteristic of the greenhouse components
  // Cover: Multi-layer model Roof-ThermalScreen
  (tau_ML_covPAR,rho_ML_covPAR) = .Greenhouses.Functions.MultiLayer_TauRho(
    tau_RfPAR,
    tau_thScrPAR,
    rho_RfPAR,
    rho_thScrPAR);
  (tau_ML_covNIR,rho_ML_covNIR) = .Greenhouses.Functions.MultiLayer_TauRho(
    tau_RfNIR,
    tau_thScrNIR,
    rho_RfNIR,
    rho_thScrNIR);

  tau_covPAR = (1-SC)*tau_RfPAR + SC*tau_ML_covPAR;
  rho_covPAR = (1-SC)*rho_RfPAR + SC*rho_ML_covPAR;
  tau_covNIR = (1-SC)*tau_RfNIR + SC*tau_ML_covNIR;
  rho_covNIR = (1-SC)*rho_RfNIR + SC*rho_ML_covNIR;

  alpha_covPAR = 1-tau_covPAR-rho_covPAR;
  alpha_covNIR = 1-tau_covNIR-rho_covNIR;

  // Absorbed power by the cover (from the sun)
  R_SunCov_Glob = (alpha_covPAR*eta_glob_PAR+alpha_covNIR*eta_glob_NIR)*I_glob;
  P_SunCov_Glob = R_SunCov_Glob*A;

  // Transmitted PAR
  R_t_PAR = I_glob*eta_glob_PAR*tau_covPAR*(1-eta_glob_air);
  // Incident NIR
  R_NIR = I_glob*eta_glob_NIR*(1-eta_glob_air);
  // Total transmitted radiation above the canopy
  R_t_Glob = I_glob*(1-eta_glob_air)*(eta_glob_PAR*tau_covPAR+eta_glob_NIR*(alpha_CanNIR+alpha_FlrNIR));

  // Absorbed by the canopy: PAR Sun(downwards), PAR Floor(upwards), NIR Sun and Floor multi-layer model
  R_SunCan_Glob = R_SunCan_PAR + R_FlrCan_PAR + R_SunCan_NIR;
  R_SunCan_PAR = R_t_PAR*(1-rho_CanPAR)*(1-exp(-K1_PAR*LAI));
  R_FlrCan_PAR = R_t_PAR*exp(-K1_PAR*LAI)*rho_FlrPAR*(1-rho_CanPAR)*(1-exp(-K2_PAR*LAI));
  R_SunCan_NIR = R_NIR*alpha_CanNIR;
  P_SunCan_Glob = R_SunCan_Glob*A;
  R_PAR_Can = R_SunCan_PAR + R_FlrCan_PAR;
  R_PAR_Can_umol = R_PAR_Can/eta_glob_PAR*eta_GlobPAR;
  (tau_CF_NIR,rho_CF_NIR) = .Greenhouses.Functions.MultiLayer_TauRho(
    exp(-K_NIR*LAI),
    1 - rho_FlrNIR,
    rho_CanNIR*(1 - exp(-K_NIR*LAI)),
    rho_FlrNIR);

  //Multi layer model for NIR (CF: canopy-floor; cover: Roof-ThermalScreen, CCF: cover-CF)
  (tau_CCF_NIR,rho_CCF_NIR) = .Greenhouses.Functions.MultiLayer_TauRho(
    tau_covNIR,
    tau_CF_NIR,
    rho_covNIR,
    rho_CF_NIR);
  alpha_FlrNIR = tau_CCF_NIR;
  alpha_CanNIR = 1-tau_CCF_NIR-rho_CCF_NIR;

  // Absorbed by floor
  R_SunFlr_Glob = R_SunFlr_NIR +R_SunFlr_PAR;
  R_SunFlr_NIR = R_NIR*alpha_FlrNIR;
  R_SunFlr_PAR = R_t_PAR*exp(-K1_PAR*LAI)*(1-rho_FlrPAR);
  P_SunFlr_Glob = R_SunFlr_Glob*A;

  // Outputs
  R_SunAir_Glob = eta_glob_air*I_glob*(tau_covPAR*eta_glob_PAR + (alpha_CanNIR+alpha_FlrNIR)*eta_glob_NIR);
  P_SunAir_Glob = R_SunAir_Glob*A
    "Power of transmitted radiation absorbed by obstacles and released to the air";

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-100,120}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-88,96},{-60,42}},
          color={255,128,0},
          smooth=Smooth.None,
          thickness=1,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-100,40},{100,40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-100,-50},{100,-50}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-100,-100},{100,-100}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-56,36},{-14,-46}},
          color={255,128,0},
          smooth=Smooth.None,
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-12,-52},{12,-96}},
          color={255,128,0},
          smooth=Smooth.None,
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-56,42},{-30,94}},
          color={255,128,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-10,-46},{32,36}},
          color={255,128,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{34,42},{60,94}},
          color={255,128,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{16,-96},{40,-52}},
          color={255,128,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Ellipse(
          extent={{-124,136},{-64,76}},
          lineColor={255,128,0},
          fillColor={255,226,6},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,76},{100,36}},
          lineColor={0,128,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="cover"),
        Text(
          extent={{-100,34},{100,-6}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="air"),
        Text(
          extent={{-100,-14},{100,-54}},
          lineColor={0,128,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="canopy"),
        Text(
          extent={{-100,-64},{100,-104}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="floor"),
        Line(
          points={{42,-46},{84,36}},
          color={255,128,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled})}),
    Documentation(info="<html>
<p><big>The solar radiation incident in a greenhouse can be split in three spectral parts: ultra violet (UV, from 0.3 to 0.4 μm), visible light (from 0.4 to 0.7 μm) and near infrared light (NIR, from 0.7 to 3 μm). The visible light has an interest for biological growth and is referred as photosynthetically active radiation (PAR) in greenhouse modeling. The fraction of UV is 6- 10% and of PAR is 45-60% of the global radiation. However, for plant growth it is common to assign 50% to PAR, neglect the UV and assign the other 50% to NIR. Besides the spectral division, the solar radiation can be divided in direct and diffuse radiation. The solar model of this work is simplified by making no distinction between diffuse and direct solar radiation and by assuming that the transmission coefficient of the greenhouse cover does not depend on the solar angle.</p>
<p><big>This model computes the short-wave radiation originated from the sun absorbed by the different components of a greenhouse. Therefore, the optical properties of the greenhouse components are parameters of the model. The user can set the parameters according to their case study. In case the user does not have this data, the default values, which are related to typical materials, can be used. Default values of the parameters are given for tomato crop, single-glass cover, concrete floor and aluminised screen.</p>
<p><big>A detailed description of the model equations can be found in the online documentation of the library <a href=\"https://greenhouses-library.readthedocs.io/en/latest\">https://greenhouses-library.readthedocs.io/en/latest</a> </p>
<p><big>The solar model icon has one input connector, for the global irradiation, and four output connectors, whose output values are equal to the absorbed global radiation by (from top to bottom): the cover, the air, the canopy and the floor. Each output connector must be connected to the short-wave input connector of its corresponding component. The model outputs the radiation values in Wm⁻². However, the PAR absorbed values are also available in the model in μmol{photons}m⁻²s⁻¹, for which a conversion factor from global radiation to PAR equal to 2.3 μmol{photons} J⁻¹ is used.</p>
</html>"));
end Solar_model;
