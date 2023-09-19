within Greenhouses.Flows.HeatTransfer;
model FreeVentilation "Heat exchange by ventilation"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.Units.SI.Area A "floor surface";
  parameter Modelica.Units.SI.Angle phi=25/180*Modelica.Constants.pi
    "inclination of the roof (0 if horizontal, 25 for typical cover)";
  parameter Real fr_window=0.078 "number of windows per m2 greenhouse";
  parameter Modelica.Units.SI.Length l "length of the window";
  parameter Modelica.Units.SI.Length h "width of the window";
  parameter Real f_leakage=1.5e-4 "Greenhouse leakage coefficient";
  parameter Boolean thermalScreen=false
    "presence of a thermal screen in the greenhouse";
  parameter Boolean topAir=false
    "False for: Main air zone; True for: Top air zone" annotation (Dialog(enable=(thermalScreen)));

  /*********************** Varying inputs ***********************/

  Modelica.Units.SI.Angle theta_l=0 "window opening at the leeside side"
    annotation (Dialog(group="Varying inputs"));
  Modelica.Units.SI.Angle theta_w=0 "window opening at the windward side"
    annotation (Dialog(group="Varying inputs"));
  Modelica.Units.SI.Velocity u=0 "Wind speed"
    annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Modelica.Units.SI.CoefficientOfHeatTransfer HEC_ab;
  Modelica.Units.SI.Density rho_air=1.2;
  Modelica.Units.SI.SpecificHeatCapacity c_p_air=1005;
  Real f_vent;

  HeatAndVapourTransfer.VentilationRates.NaturalVentilationRate_1
                                                           airExchangeRate(
    phi=phi,
    fr_window=fr_window,
    l=l,
    h=h,
    thermalScreen=thermalScreen,
    u=u,
    theta_l=theta_l,
    theta_w=theta_w,
    dT=dT) annotation (Placement(transformation(extent={{-10,22},{10,42}})));
equation
  if not topAir then
    f_vent = airExchangeRate.f_vent_air;
  else
    f_vent = airExchangeRate.f_vent_top;
  end if;

  if thermalScreen then
    if topAir then
      HEC_ab=rho_air*c_p_air*(f_vent + max(0.25,u)*f_leakage);
    else
      HEC_ab=0;
    end if;
  else
    HEC_ab=rho_air*c_p_air*(f_vent + max(0.25,u)*f_leakage);
  end if;

  // Heat exchange coefficient and heat exchange
  //HEC_ab=rho_air*c_p_air*(f_vent + u*f_leakage);
  Q_flow = A*HEC_ab*dT;

  annotation (Icon(graphics={
        Text(
          extent={{-180,-28},{180,-64}},
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
          smooth=Smooth.Bezier)}), Diagram(coordinateSystem(preserveAspectRatio=
           false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
    <p><big>The heat transfer between the inside and outside air due to natural ventilation 
    is computed as a function of the air exchange rate. </p>
    <p><big>This model also takes into account the leakage rate through the 
    greenhouse structure, which is dependent on the wind speed (input of the model) 
    and the leakage coefficient of the greenhouse (parameter of the model, 
    characteristic of its structure).</p>
</html>"));
end FreeVentilation;
