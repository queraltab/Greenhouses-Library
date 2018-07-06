within Greenhouse;
package Functions 
annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          fillPattern=FillPattern.None,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Text(
          extent={{-114,86},{86,-114}},
          lineColor={255,127,0},
          textString=
               "f"), Ellipse(extent={{-74,64},{72,-86}}, lineColor={255,128,0})}));
end Functions;
