within Greenhouses.Flows.HeatAndVapourTransfer;
model Ventilation
  "Heat and vapour mass flows exchanged from the greenhouse air to the outside air by ventilation"
  extends Greenhouses.Interfaces.HeatAndVapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "Greenhouse floor surface";
  parameter Boolean thermalScreen=false
    "presence of a thermal screen in the greenhouse";
  parameter Boolean topAir=false
    "False for: Main air zone; True for: Top air zone" annotation (Dialog(enable=(thermalScreen)));
  parameter Boolean forcedVentilation=false
    "presence of a mechanical ventilation system in the greenhouse";
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
  Real f_vent(unit="m3/(m2.s)")
    "Air exchange rate from the greenhouse air to the outside air function of wind and temperature";
  Real R=8314 "gas constant";
  Modelica.SIunits.MolarMass M_H = 18;
  Real f_vent_total(unit="m3/(m2.s)");
  Real f_ventForced(unit="m3/(m2.s)");

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
  // Natural ventilation rate (including leakage)
  if not topAir then
    f_vent = NaturalVentilationRate.f_vent_air;
  else
    f_vent = NaturalVentilationRate.f_vent_top;
  end if;

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

  // Total ventilation
  f_vent_total = f_vent+f_ventForced;

  // Heat transfer
  HEC_ab=rho_air*c_p_air*f_vent_total;
  Q_flow = A*HEC_ab*dT;

  // Moisture transfer
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
    <p><big>Ventilation replaces greenhouse air by outdoor air. In most cases this exchange 
    is governed by natural ventilation through windows, from which the aperture of the 
    windws is controlled by the greenhouse climate controller. However, since greenhouses 
    are not completely air tight, there is also a small uncontrolable ventilation flux caused by leakage.</p>
    <p><big>The heat transfer between the inside and outside air due to natural ventilation 
    is computed as a function of the air exchange rate by using the 
    <a href=\"modelica://Greenhouses.Flows.HeatAndVapourTransfer.VentilationRates.NaturalVentilationRate_2\">NaturalVentilationRate_2</a> 
    model. This rate, derived by [1], 
    depends mainly on two factors. The first one is the windows opening, a required input 
    which is set by the climate controller. The latter are characteristics of the windows 
    (e.g. the wind pressure coefficient and the coefficient of energy discharge caused by 
    friction at the windows), which in order to simplify the model, have been set to 
    constant values relative to standard roof windows. </p>
    <p><big>If a mechanical ventilation system is installed, the heat flow caused by 
    this system also needs to be taken into acount. The heat flow from forced ventilation is also computed as
a function of the air exchange rate, which depends on the
capacity of the mechanical ventilation system (parameter
of the model) and the position of the control valve (required
input set by the climate controller). This computation is done in the 
<a href=\"modelica://Greenhouses.Flows.HeatAndVapourTransfer.VentilationRates.ForcedVentilationRate\">ForcedVentilationRate</a> model.
</p>
    <p><big>Depending on the status of the thermal screen, the heat flow can 
    originate either from the top or the main air zones. Therefore, the user must indicate which
    zone is being modeled through a Boolean parameter. The screen closure 
    (control variable from the climate controller) is a required input. 
    </p>
    <p><big>This model also takes into account the leakage rate through the 
    greenhouse structure, which is dependent on the wind speed (input of the model) 
    and the leakage coefficient of the greenhouse (parameter of the model, 
    characteristic of its structure).</p>
    
<p>[1] T. Boulard and A. Baille. A simple greenhouse climate control model
incorporating effects of ventilation and evaporative cooling. Agricultural
and Forest Meteorology, 65(3):145–157, August 1993. ISSN
0168-1923. doi:10.1016/0168-1923(93)90001-X.
</p>
</html>"));
end Ventilation;
