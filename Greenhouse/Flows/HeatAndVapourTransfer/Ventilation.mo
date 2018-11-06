within Greenhouses.Flows.HeatAndVapourTransfer;
model Ventilation
  "Heat and vapour mass flows exchanged from the greenhouse air to the outside air by ventilation"
  extends Greenhouses.Interfaces.HeatAndVapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "Greenhouse floor surface";
//   parameter Real c_leakage=1.5e-4 "Greenhouse leakage coefficient";
  parameter Boolean thermalScreen=false
    "presence of a thermal screen in the greenhouse";
  parameter Boolean topAir=false
    "False for: Main air zone; True for: Top air zone"                  annotation (Dialog(enable=(thermalScreen and upward)));
  parameter Boolean forcedVentilation=false
    "presence of a thermal screen in the greenhouse";
  parameter Modelica.SIunits.VolumeFlowRate phi_VentForced=0
    "Air flow capacity of the forced ventilation system" annotation(Dialog(enable=forcedVentilation));

  /*********************** Varying inputs ***********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(enable=(thermalScreen), group="Varying inputs"));
  Modelica.SIunits.Velocity u= 0 "Wind speed"     annotation (Dialog(group="Varying inputs"));
  Real U_vents(min=0,max=1)=0
    "From 0 to 1, control of the aperture of the roof vents"                             annotation (Dialog(group="Varying inputs"));
  Real U_VentForced=0 "From 0 to 1, control of the forced ventilation"   annotation (Dialog(group="Varying inputs",enable=forcedVentilation));

  /*********************** Variables ***********************/
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_ab;
  Modelica.SIunits.Density rho_air=1.2;
  Modelica.SIunits.SpecificHeatCapacity c_p_air=1005;
  Real f_vent
    "Air exchange rate from the greenhouse air to the outside air function of wind and temperature";
//   Real f_leakage "Air exchange rate due to leakage";
  Real R=8314 "gas constant";
  Modelica.SIunits.MolarMass M_H = 18;
  Real f_vent_total;
  Real f_ventForced;
  //Real VEC_TopOut(unit="kg/(s.Pa.m2)") "Mass transfer coefficient";
  //Real MV_flow2;

  VentilationRates.NaturalVentilationRate_2 NaturalVentilationRate(
    thermalScreen=thermalScreen,
    u=u,
    dT=dT,
    T_a=HeatPort_a.T,
    T_b=HeatPort_b.T,
    U_roof=U_vents,
    SC=SC) annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  VentilationRates.ForcedVentilationRate ForcedVentilationRate(
    A=A,
    phi_VentForced=phi_VentForced,
    U_VentForced=U_VentForced)
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
equation
  // Natural ventilation rate
  if not topAir then
    f_vent = NaturalVentilationRate.f_vent_air;
  else
    f_vent = NaturalVentilationRate.f_vent_top;
  end if;

//   // Leakage rate
//   f_leakage = max(0.25,u)*c_leakage;

  // Forced ventilation rate
  if forcedVentilation then
    if not topAir then
      f_ventForced = ForcedVentilationRate.f_ventForced
        "Forced ventilation is always in the main air zone";
    else
      f_ventForced = 0;
    end if;
  else
    f_ventForced=0;
  end if;
  //f_vent_total = f_vent+f_leakage+f_ventForced;
  f_vent_total = f_vent+f_ventForced;

  // Heat transfer
//   if thermalScreen then
//     if topAir then
//       HEC_ab=rho_air*c_p_air*f_vent_total;
//     else
//       HEC_ab=0;
//     end if;
//   else
//     HEC_ab=rho_air*c_p_air*f_vent_total;
//   end if;
  HEC_ab=rho_air*c_p_air*f_vent_total;

  Q_flow = A*HEC_ab*dT;

  //Mass transfer
//   if not topAir then
//     VEC_TopOut=0;
//     MV_flow = A*M_H*f_vent_total/R*(MassPort_a.VP/HeatPort_a.T - MassPort_b.VP/HeatPort_b.T);
//     MV_flow2=0;
//   else
//     VEC_TopOut=M_H*f_vent_total/R/283;
//     MV_flow = A*M_H*f_vent_total/R/283*dP;
//     MV_flow2 = A*M_H*f_vent_total/R*(MassPort_a.VP/HeatPort_a.T - MassPort_b.VP/HeatPort_b.T);
//   end if;
  MV_flow = A*M_H*f_vent_total/R*(MassPort_a.VP/HeatPort_a.T - MassPort_b.VP/HeatPort_b.T);

  annotation (Icon(graphics={
        Text(
          extent={{-180,-40},{180,-76}},
          lineColor={0,0,255},
          textString="%name"),
        Line(
          points={{-90,-30}},
          color={191,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-90,0},{-80,0},{-70,-10},{-50,10},{-30,-10},{-10,10},{10,
              -10},{30,10},{50,-10},{70,10},{80,0},{90,0}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Polygon(
          points={{-38,48},{-48,10},{-48,4},{-48,-2},{-42,-8},{-34,-10},{-28,-8},
              {-24,0},{-24,4},{-24,10},{-36,40},{-38,48}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{4,14},{-6,-24},{-6,-30},{-6,-36},{0,-42},{8,-44},{14,-42},{18,
              -34},{18,-30},{18,-24},{6,6},{4,14}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{42,50},{32,12},{32,6},{32,0},{38,-6},{46,-8},{52,-6},{56,2},{
              56,6},{56,12},{44,42},{42,50}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None)}),
                                   Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>Ventilation replaces greenhouse air by outdoor air. In most cases this exchange is governed by natural ventilation through windows, from which the aperture of the windws is controlled by the greenhouse climate controller. However, since greenhouses are not completely air tight, there is also a small uncontrolable ventilation flux caused by leakage.</p>
<p>The greenhouse leakage rate depends on wind speed and is described by:</p>
<p><img src=\"modelica://Greenhouse/Images/equations/equation-idob13KG.png\" alt=\"f_leakage = 0.25*c_leakage
\"/>, <img src=\"modelica://Greenhouse/Images/equations/equation-mMOn6mQp.png\" alt=\"u_wind < 0.25\"/></p>
<p><img src=\"modelica://Greenhouse/Images/equations/equation-BmZXe19S.png\" alt=\"f_leakage = u_wind*c_leakage\"/>, <img src=\"modelica://Greenhouse/Images/equations/equation-eCDlvOlE.png\" alt=\"u_wind > 0.25\"/></p>
<p>where <img src=\"modelica://Greenhouse/Images/equations/equation-9meGKjTB.png\" alt=\"c_leakage\"/> (-) is the leakage coefficient which depends in the greenhouse type.</p>
<p>The indoor air with a heat content <img src=\"modelica://Greenhouse/Images/equations/equation-i1Rs2Q2I.png\" alt=\"rho*Cp_air*T_air\"/> is replaced by outdoor air with a heat content <img src=\"modelica://Greenhouse/Images/equations/equation-CDv0ddvc.png\" alt=\"rho*Cp_air*T_out\"/>. Therefore, when the difference in density is neglected, the heat exchange coefficient for ventilation heat exchange is defined by:</p>
<p><img src=\"modelica://Greenhouse/Images/equations/equation-EaiGn1qY.png\" alt=\"HEC_AirOut = rho*Cp_air*(f_vent + u*f_leakage)\"/> <img src=\"modelica://Greenhouse/Images/equations/equation-r2aQHcKW.png\" alt=\"[W*m^(-2)*K^(-1)]\"/></p>
</html>"));
end Ventilation;
