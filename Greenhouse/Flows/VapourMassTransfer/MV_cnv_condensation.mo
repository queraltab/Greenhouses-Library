within Greenhouses.Flows.VapourMassTransfer;
model MV_cnv_condensation
  "Vapour mass transfer (and possible condensation) caused by convection at a surface. The model must be connected as following: air (filled port) - surface (empty port)"
  extends Greenhouses.Interfaces.Vapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "floor surface";

  /*********************** Varying inputs ***********************/
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_ab=0
    "Heat transfer coefficient between nodes a and b, provided by the adecuate model in HeatTransfer folder"
                                                                                                        annotation (Dialog(group="Varying inputs"));
  /*********************** Variables ***********************/
  Real VEC_ab(unit="kg/(s.Pa.m2)") "Mass transfer coefficient";

equation
  if dP>0 then
    VEC_ab = 6.4e-9*HEC_ab;
    MV_flow = A*VEC_ab*dP;
  else
    VEC_ab = 0;
    MV_flow=0
      "The fluxes due to condensation are prohibited from being negative";
  end if;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,62},
          rotation=-90),
        Text(
          extent={{-180,19},{180,-19}},
          textString="%name",
          lineColor={0,0,255},
          origin={0,-63},
          rotation=360),
        Polygon(
          points={{-36,50},{-46,12},{-46,6},{-46,0},{-40,-6},{-32,-8},{-26,
              -6},{-22,2},{-22,6},{-22,12},{-34,42},{-36,50}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{34,44},{24,6},{24,0},{24,-6},{30,-12},{38,-14},{44,-12},
              {48,-4},{48,0},{48,6},{36,36},{34,44}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None),
        Polygon(
          points={{0,18},{-10,-20},{-10,-26},{-10,-32},{-4,-38},{4,-40},{10,
              -38},{14,-30},{14,-26},{14,-20},{2,10},{0,18}},
          smooth=Smooth.Bezier,
          fillPattern=FillPattern.Solid,
          fillColor={0,0,255},
          pattern=LinePattern.None)}),
                           Documentation(info="<html>
<p align=\"justify\">Mass&nbsp;transfer&nbsp;from&nbsp;the&nbsp;air&nbsp;to&nbsp;the&nbsp;cover&nbsp;(condensation)&nbsp;is governed&nbsp;by&nbsp;processes at&nbsp;the&nbsp;boundary&nbsp;layer&nbsp;at&nbsp;this</p>
<p align=\"justify\">surface.&nbsp;Because&nbsp;of&nbsp;the&nbsp;similarity&nbsp;of&nbsp;the&nbsp;transport&nbsp;mechanism&nbsp;for&nbsp;vapour&nbsp;and&nbsp;heat&nbsp;transfer&nbsp;through&nbsp;the&nbsp;boundary</p>
<p align=\"justify\">layer,&nbsp;the&nbsp;mass&nbsp;and&nbsp;heat&nbsp;transfer&nbsp;coefficients&nbsp;are&nbsp;correlated. In de Zwart (1996), a factor of 6.4e-9 kg/(kJPa)</p>
<p align=\"justify\">is found between the heat and mass transfer coefficients.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end MV_cnv_condensation;
