within Greenhouses.ControlSystems.Climate.Utilities;
block SC_crack
  "Timer measuring the time from the time instant where the Boolean input became true"

  extends Modelica.Blocks.Icons.PartialBooleanBlock;
  parameter Real SC_value "From 0 to 1";

  Modelica.Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}, rotation=0)));

  //Modelica.SIunits.Time startTime;
protected
  discrete Modelica.SIunits.Time entryTime "Time instant when u became true";
initial equation
  pre(entryTime) = 0;
  //pre(startTime)=0;
equation
  when u then
    entryTime = time;
    //startTime=time;
  end when;
  y = if u then SC_value else 0.0;
  annotation (
    Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}},
        initialScale=0.1),
        graphics={
      Line(visible=true,
        points={{-90.0,-70.0},{82.0,-70.0}},
        color={192,192,192}),
      Line(visible=true,
        points={{-80.0,68.0},{-80.0,-80.0}},
        color={192,192,192}),
      Polygon(visible=true,
        lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90.0,-70.0},{68.0,-62.0},{68.0,-78.0},{90.0,-70.0}}),
      Polygon(visible=true,
        lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
      Line(visible=true,
        points={{-80.0,-70.0},{-60.0,-70.0},{-60.0,-26.0},{38.0,-26.0},{38.0,-70.0},{66.0,-70.0}},
        color={255,0,255}),
      Line(visible=true,
        points={{-80.0,0.0},{-62.0,0.0},{40.0,90.0},{40.0,0.0},{68.0,0.0}},
        color={0,0,127})}),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}}),     graphics),
    Documentation(info="<HTML>
<p> When the Boolean input \"u\" becomes <b>true</b>, the timer is started
and the output \"y\" is the time from the time instant where u became true.
The timer is stopped and the output is reset to zero, once the
input becomes false.
</p>
</html>"));
end SC_crack;
