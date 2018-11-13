within Greenhouses.Flows.FluidFlow.HeatTransfer;
model Ideal "Ideal: Heat transfer without thermal resistance"

  extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialHeatTransferZones;
equation
  T_fluid = thermalPortL.T;
  annotation(Documentation(info="<html>
<p><big>Ideal heat transfer without thermal resistance. </p>
<p></p>
</html>"));
end Ideal;
