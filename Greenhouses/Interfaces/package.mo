within Greenhouses;
package Interfaces 






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
        Polygon(origin={20,0},
          lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          points={{-10.0,70.0},{10.0,70.0},{40.0,20.0},{80.0,20.0},{80.0,-20.0},{40.0,-20.0},{10.0,-70.0},{-10.0,-70.0}}),
        Polygon(fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-100,20},{-60,20},{-30,70},{-10,70},{-10,-70},{-30,-70},{-60,
            -20},{-100,-20}})}), Documentation(info="<html>
<p>
Licensed by Thermodynamics Laboratory (University of Liege) under the Modelica License 2<br>
Copyright &copy; 2017-2018, Thermodynamics Laboratory (University of Liege).
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>"));
end Interfaces;
