within Greenhouses.Flows.FluidFlow.HeatTransfer.TwoPhaseCorrelations;
model Constant "Constant: Constant heat transfer coefficient"
  extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialTwoPhaseCorrelation;
  extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialPipeCorrelation(
      final d_h=0, final A_cro=0);
  extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialPlateHeatExchangerCorrelation(
      final d_h=0, final A_cro=0);

  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_c = 3000
    "Heat transfer coefficient";
equation
  U = U_c;

   annotation(Documentation(info="<html>

<p><big> The model <b>Constant</b> extends the partial model
 <a href=\"modelica://ThermoCycle.Components.HeatFlow.HeatTransfer.BaseClasses.PartialTwoPhaseCorrelation\">PartialTwoPhaseCorrelation</a> and 
 impose a constant heat transfer coefficient.
 </p>


<p></p>

</html>"));
end Constant;
