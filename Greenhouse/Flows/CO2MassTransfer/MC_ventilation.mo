within Greenhouses.Flows.CO2MassTransfer;
model MC_ventilation
  "CO2 mass flow exchange accompanying an air ventilation process. Distinguishes from the two different air zones on the presence of a thermal screen."
  extends Greenhouses.Flows.Interfaces.CO2.Element1D;

  /*********************** Parameters ***********************/
  parameter Boolean thermalScreen=false
    "presence of a thermal screen in the greenhouse";
  parameter Boolean topAir=false
    "False for: Main air zone; True for: Top air zone"                  annotation (Dialog(enable=(thermalScreen)));

  /*********************** Varying inputs ***********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(group="Varying inputs",enable=thermalScreen));
  Real U_vents(min=0,max=1)=0
    "From 0 to 1, control of the aperture of the roof vents"                             annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_a=300 "Temperature at port a (filled square)"
    annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Temperature T_b=300 "Temperature at port b (empty square)"
    annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.Velocity u= 0 "Wind speed"     annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Real f_vent;

  HeatAndVapourTransfer.VentilationRates.NaturalVentilationRate_2
    airExchangeRate(
    thermalScreen=thermalScreen,
    u=u,
    dT=T_a - T_b,
    U_roof=U_vents,
    SC=SC,
    T_a=T_a,
    T_b=T_b) annotation (Placement(transformation(extent={{-12,32},{8,52}})));
equation
  // CO2 exchange, dependent on the air exchange rate
  if thermalScreen then
    if not topAir then
      f_vent = airExchangeRate.f_vent_air;
    else
      f_vent = airExchangeRate.f_vent_top;
    end if;
  else
    f_vent = airExchangeRate.f_vent_air;
  end if;
  MC_flow = f_vent*dC;

  annotation (Icon(graphics={
        Text(
          extent={{-180,-60},{180,-100}},
          lineColor={0,0,0},
          textString="%name"),
        Line(
          points={{-90,-30}},
          color={191,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-90,0},{-80,0},{-70,-10},{-50,10},{-30,-10},{-10,10},{10,
              -10},{30,10},{50,-10},{70,10},{80,0},{90,0}},
          color={95,95,95},
          smooth=Smooth.Bezier),
                               Ellipse(
          extent={{-28,10},{-8,-10}},
          lineColor={191,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
                               Ellipse(
          extent={{10,10},{30,-10}},
          lineColor={191,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
                               Ellipse(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere)}),
                                  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end MC_ventilation;
