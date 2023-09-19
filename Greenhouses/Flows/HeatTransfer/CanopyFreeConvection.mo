within Greenhouses.Flows.HeatTransfer;
model CanopyFreeConvection "Leaves heat exchange by free convection with air"
  extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.Units.SI.Area A "floor surface";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U=5
    "Leaves heat transfer coefficient ";

  /*********************** Varying inputs ***********************/
  Real LAI = 1 "Leaf Area Index"
    annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Modelica.Units.SI.CoefficientOfHeatTransfer HEC_ab;

equation
  HEC_ab = 2*LAI*U;
  Q_flow = A*HEC_ab*dT;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-16,38},{-6,48},{-6,58},{14,58},{14,78},{34,78},{34,88},{40,94}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{2,0},{14,0},{24,10},{44,-10},{64,10},{76,-2},{76,-2},{86,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-10,-34},{0,-44},{0,-54},{20,-54},{20,-74},{40,-74},{40,-84},{46,
              -90}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-180,-84},{180,-124}},
          textString="%name",
          lineColor={0,0,255}),
        Polygon(
          points={{-68,-48},{-28,-28},{-28,-12},{-40,-18},{-30,0},{-22,8},{-22,16},
              {-32,14},{-26,22},{-22,30},{-18,42},{-30,40},{-42,24},{-44,30},{-48,
              34},{-56,26},{-58,4},{-62,6},{-62,14},{-68,14},{-74,-2},{-68,-48}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics),
    Documentation(info="<html>
<p><big>The heat exchange coefficient on the leaves of tomato crop was derived 
experimentally by [1]. However, due to the lack of required input 
data to compute it, in this model it is simplified to a constant value. Given that 
this coefficient is expressed per unit of leaf area, in order to compute the global 
heat exchange coefficient, the LAI, defined as the leaf area per unit of ground area,
is a required input.</p>
<p>[1] C. Stanghellini. Transpiration of greenhouse crops : an aid to climate
management. PhD thesis, Wageningen University, 1987.</p>
</html>"));
end CanopyFreeConvection;
