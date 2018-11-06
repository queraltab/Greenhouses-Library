within Greenhouses.Flows.CO2MassTransfer;
model MC_AirCan
  "Greenhouse CO2 net assimilation rate by the canopy. The value computed in a yield model is used as input."

  /*********************** Varying inputs ***********************/
  Real MC_AirCan(unit="mg/(m2.s)")=3
    "CO2 flux between the greenhouse air and the canopy (computed in the tomato yield model), mg CO2/(m2.s)"
                                                                                                        annotation (Dialog(group="Varying inputs"));

  /******************** Connectors ********************/
  Greenhouses.Interfaces.CO2.CO2Port_a port "Partial CO2 pressure" annotation (
      Placement(transformation(extent={{-10,80},{10,100}}), iconTransformation(
          extent={{-10,80},{10,100}})));

equation
  port.MC_flow = MC_AirCan;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                                           Text(
          extent={{-160,-64},{160,-98}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Polygon(
          points={{22,-45},{-18,-25},{-18,-9},{-6,-15},{-16,3},{-24,11},{-24,19},
              {-14,17},{-20,25},{-24,33},{-28,45},{-16,43},{-4,27},{-2,33},{2,37},
              {10,29},{12,7},{16,9},{16,17},{22,17},{28,1},{22,-45}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid,
          origin={-2,-35},
          rotation=-90),       Ellipse(
          extent={{-20,76},{20,36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
                               Ellipse(
          extent={{-28,66},{-8,46}},
          lineColor={191,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
                               Ellipse(
          extent={{10,66},{30,46}},
          lineColor={191,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Sphere),
        Line(
          points={{0,34},{0,-16}},
          color={95,95,95},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled})}));
end MC_AirCan;
