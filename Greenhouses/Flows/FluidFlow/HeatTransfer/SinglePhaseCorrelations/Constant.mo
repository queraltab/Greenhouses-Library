within Greenhouses.Flows.FluidFlow.HeatTransfer.SinglePhaseCorrelations;
model Constant "Constant: Constant heat transfer coefficient"
  extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialSinglePhaseCorrelation;
  extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialPipeCorrelation(
      final d_h=0, final A_cro=0);
  extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialPlateHeatExchangerCorrelation(
      final d_h=0, final A_cro=0);

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_c=1000
    "Heat transfer coefficient";
equation
  U = U_c;

annotation(Documentation(info="<html>

<p><big> The model <b>Constant</b> extends the partial model
 <a href=\"modelica://ThermoCycle.Components.HeatFlow.HeatTransfer.BaseClasses.PartialSinglePhaseCorrelation\">PartialSinglePhaseCorrelation</a> 
 and defines a constant heat transfer coefficient.
 
<p></p>
</html>"));
end Constant;
