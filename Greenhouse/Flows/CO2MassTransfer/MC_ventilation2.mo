within Greenhouse.Flows.CO2MassTransfer;
model MC_ventilation2
  "CO2 mass flow accompanying an air flow caused by ventilation processes"
  extends Greenhouse.Flows.Interfaces.CO2.Element1D;

  /*********************** Parameters ***********************/

  /*********************** Varying inputs ***********************/
  Real f_vent=0  annotation (Dialog(group="Varying inputs"));

equation
  // CO2 exchange, dependent on the air exchange rate
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
end MC_ventilation2;
