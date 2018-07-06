within Greenhouse;
package Examples 



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
        Polygon(
          origin={8,14},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
      Documentation(info="<html>
<p><big>Most examples of the Greenhouse library make use of some thermal systems models from the ThermoCycle library e.g., pumps, pressure drops, thermal energy storage.</p>
<p><big>The user can download the ThermoCycle library here: <a href=\"http://thermocycle.net\">http://thermocycle.net</a></p>
</html>"));
end Examples;
