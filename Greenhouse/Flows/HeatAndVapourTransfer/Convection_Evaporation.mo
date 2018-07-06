within Greenhouse.Flows.HeatAndVapourTransfer;
model Convection_Evaporation
  "Upward heat exchange by free convection between the thermal screen (filled port) and top air (empty port). Mass transfer by evaporation from upper side of the screen to the air at the top compartment"
  extends Greenhouse.Flows.Interfaces.HeatAndVapour.Element1D;

  /*********************** Parameters ***********************/
  parameter Modelica.SIunits.Area A "floor surface";

  /*********************** Varying inputs ***********************/
  Real SC=0 "Screen closure 1:closed, 0:open" annotation (Dialog(group="Varying inputs"));
  Modelica.SIunits.MassFlowRate MV_AirScr=0
    "Mass flow rate from the main air zone to the screen" annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Modelica.SIunits.CoefficientOfHeatTransfer HEC_ab;
  Real VEC_ab(unit="kg/(s.Pa.m2)") "Mass transfer coefficient";

equation
  //Heat Transfer: Exchange air-screen
  HEC_ab=SC*1.7*max(1e-9,abs(dT))^0.33;
  Q_flow = A*HEC_ab*dT;

  //Mass Transfer
  VEC_ab = max(0,min(6.4e-9*HEC_ab, MV_AirScr/A/max(1e-9,dP)));
  MV_flow = max(0, A*VEC_ab*dP)
    "The fluxes due to evaporation are prohibited from being negative";
//   if dP>0 then
//     VEC_ab = min(6.4e-9*HEC_ab, MV_AirScr/A/max(1e-9,dP));
//     MV_flow = A*VEC_ab*dP;
//   else
//     VEC_ab = 0;
//     MV_flow=0
//       "The fluxes due to evaporation are prohibited from being negative";
//   end if;

  annotation (Icon(graphics={
        Line(
          points={{-16,6},{2,-14},{40,-10},{48,8},{48,20}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.Filled,Arrow.None},
          origin={-60,18},
          rotation=-90),
        Text(
          extent={{-180,20},{180,-20}},
          textString="%name",
          lineColor={0,0,255},
          origin={0,-104},
          rotation=360),
        Line(
          points={{-16,-6},{2,14},{40,10},{48,-8},{48,-20}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          origin={-26,18},
          rotation=-90),
        Line(
          points={{-90,-50},{-80,-50},{-70,-60},{-50,-40},{-30,-60},{-10,-40},{10,
              -60},{30,-40},{50,-60},{70,-40},{80,-50},{90,-50}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={70,6},
          rotation=90),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={40,6},
          rotation=90),
        Line(
          points={{-42,0},{-30,0},{-20,10},{0,-10},{20,10},{32,-2},{32,-2},{42,-2}},
          color={0,0,255},
          smooth=Smooth.Bezier,
          arrow={Arrow.None,Arrow.Filled},
          origin={10,6},
          rotation=90)}),  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics));
end Convection_Evaporation;
