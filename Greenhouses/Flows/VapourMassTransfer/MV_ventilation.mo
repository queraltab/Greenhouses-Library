within Greenhouses.Flows.VapourMassTransfer;
model MV_ventilation
  "Vapour mass flow exchanged from the greenhouse air to the outside air by ventilation"
  extends Greenhouses.Interfaces.Vapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "floor surface";
  parameter Modelica.SIunits.Angle phi=25/180*Modelica.Constants.pi
    "inclination of the roof (0 if horizontal, 25 for typical cover)";
  parameter Real fr_window=0.078 "number of windows per m2 greenhouse";
  parameter Modelica.SIunits.Length l "length of the window";
  parameter Modelica.SIunits.Length h "width of the window";
  parameter Boolean thermalScreen=false
    "presence of a thermal screen in the greenhouse";
  parameter Boolean topAir=false
    "False for: Main air zone; True for: Top air zone"                  annotation (Dialog(enable=(thermalScreen and upward)));

  /*********************** Varying inputs ***********************/

  Modelica.SIunits.Angle theta_l=0 "window opening at the leeside side" annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Angle theta_w=0 "window opening at the windward side" annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_a=300 "Temperature at port a (filled square)"
    annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_b=300 "Temperature at port b (empty square)"
    annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Velocity u= 0 "Wind speed"     annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Real f_vent;
  Real R=8314 "gas constant";
  Modelica.SIunits.MolarMass M_H = 18 "kg/kmol";

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
    dT=T_a - T_b)
    annotation (Placement(transformation(extent={{-12,32},{8,52}})));
equation
  // Mass exchange coefficient and mass exchange
  if not topAir then
    f_vent = airExchangeRate.f_vent_air;
    MV_flow = A*M_H*f_vent/R*(port_a.VP/T_a - port_b.VP/T_b);
  else
    f_vent = airExchangeRate.f_vent_top;
    MV_flow = A*M_H*f_vent/R/283*dP;
  end if;

  annotation (Icon(graphics={
        Text(
          extent={{-180,-60},{180,-100}},
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
          points={{-42,38},{-52,0},{-52,-6},{-52,-12},{-46,-18},{-38,-20},{-32,-18},
              {-28,-10},{-28,-6},{-28,0},{-40,30},{-42,38}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{38,40},{28,2},{28,-4},{28,-10},{34,-16},{42,-18},{48,-16},{52,
              -8},{52,-4},{52,2},{40,32},{38,40}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{0,4},{-10,-34},{-10,-40},{-10,-46},{-4,-52},{4,-54},{10,
              -52},{14,-44},{14,-40},{14,-34},{2,-4},{0,4}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None)}),
                                  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end MV_ventilation;
