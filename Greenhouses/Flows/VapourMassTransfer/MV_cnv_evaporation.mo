within Greenhouses.Flows.VapourMassTransfer;
model MV_cnv_evaporation
  "Vapour mass transfer (and possible evaporation) caused by convection at a surface. The model must be connected as following: surface (filled port) - air (empty port)"
  extends Greenhouses.Interfaces.Vapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.Units.SI.Area A "floor surface";

  /*********************** Varying inputs ***********************/
  Modelica.Units.SI.CoefficientOfHeatTransfer HEC_ab=0
    "Heat transfer coefficient between nodes a and b, provided by the adecuate model in HeatTransfer folder"
    annotation (Dialog(group="Varying inputs"));
  Real VEC_AirScr(unit="kg/(s.Pa.m2)")=0
    "Mass transfer coefficient at the lower part of the screen in contact with the main air zone"       annotation (Dialog(group="Varying inputs"));
  Modelica.Units.SI.Pressure VP_air=1e5 "Vapour pressure at the main air zone";

  /*********************** Variables ***********************/
  Real VEC_ab(unit="kg/(s.Pa.m2)") "Mass transfer coefficient";

equation
  // Port a: screen; Port b: air in top compartment
  // dP => VP_scr - VP_topAir

  if dP>0 then
    VEC_ab = min(6.4e-9*HEC_ab, VEC_AirScr*(VP_air-port_a.VP)/dP);
    MV_flow = A*VEC_ab*dP;
  else
    VEC_ab = 0;
    MV_flow=0
      "The fluxes due to evaporation are prohibited from being negative";
  end if;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-10,80},{10,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,-30},
          rotation=-90),
        Text(
          extent={{-180,19},{180,-19}},
          textString="%name",
          lineColor={0,0,255},
          origin={0,-79},
          rotation=360),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={50,26},
          rotation=90),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={0,26},
          rotation=90),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={-50,26},
          rotation=90)}),  Documentation(info="<html>
<p align=\"justify\">Mass&nbsp;transfer&nbsp;from&nbsp;the&nbsp;air&nbsp;to&nbsp;the&nbsp;cover&nbsp;(condensation)&nbsp;is governed&nbsp;by&nbsp;processes at&nbsp;the&nbsp;boundary&nbsp;layer&nbsp;at&nbsp;this</p>
<p align=\"justify\">surface.&nbsp;Because&nbsp;of&nbsp;the&nbsp;similarity&nbsp;of&nbsp;the&nbsp;transport&nbsp;mechanism&nbsp;for&nbsp;vapour&nbsp;and&nbsp;heat&nbsp;transfer&nbsp;through&nbsp;the&nbsp;boundary</p>
<p align=\"justify\">layer,&nbsp;the&nbsp;mass&nbsp;and&nbsp;heat&nbsp;transfer&nbsp;coefficients&nbsp;are&nbsp;correlated. In de Zwart (1996), a factor of 6.4e-9 kg/(kJPa)</p>
<p align=\"justify\">is found between the heat and mass transfer coefficients.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end MV_cnv_evaporation;
