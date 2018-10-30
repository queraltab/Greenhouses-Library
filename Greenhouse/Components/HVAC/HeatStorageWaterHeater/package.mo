within Greenhouses.Components.HVAC;
package HeatStorageWaterHeater 


  annotation (Icon(graphics={
        Ellipse(
          extent={{-40,52},{40,80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,64},{40,-92}},
          lineColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fillColor={215,215,215}),
        Line(
          points={{40,26},{-10,26},{20,14},{-10,4},{20,-6},{-8,-18},{22,-28},{
              -8,-40},{38,-40}},
          color={0,0,0},
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{28,-44},{40,-40},{28,-36}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-40,-92},{40,-92},{40,66}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-40,66},{-40,-92}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-40,58},{40,58}},
          color={0,0,0},
          smooth=Smooth.None)}));
end HeatStorageWaterHeater;
