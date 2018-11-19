within Greenhouses;
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
      <h4>Important remark!</h4>
      <p>All the examples make use of data from input files (e.g., weather data, climate set-points). These data is contained in '.txt' files that are accessed by means of the <a href=\"modelica://Modelica.Blocks.Sources.CombiTimeTable\">CombiTimeTable</a> block from the Modelica Standard Library.</p>
</html>"));
end Examples;
