within Greenhouses.Interfaces.Vapour;
connector WaterMassPort_a
  "Water mass port for 1-dim. water vapour mass transfer (filled rectangular icon)"

  extends Greenhouses.Interfaces.Vapour.WaterMassPort;

  annotation(defaultComponentName = "port_a",
    Documentation(info="<HTML>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <b>positive</b> heat flow
rate <b>Q_flow</b> is considered to flow <b>into</b> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <b>HeatPort_a</b> and
<b>HeatPort_b</b> are identical with the only exception of the different
<b>icon layout</b>.</p></html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-106,120},{114,60}},
          lineColor={0,0,255},
          textString="%name",
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
end WaterMassPort_a;
