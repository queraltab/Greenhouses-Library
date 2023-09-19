within Greenhouses.Flows.FluidFlow.HeatTransfer;
model MassFlowDependence_IdealFluid

extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialHeatTransferZones_IdealFluid;
  input Modelica.Units.SI.CoefficientOfHeatTransfer Unom
    "Nominal heat transfer coefficient- Average of liquid two phase and vapor";
  Modelica.Units.SI.CoefficientOfHeatTransfer U "Heat transfer coefficient";

equation
    U = Unom*noEvent(0.00001 + abs(M_dot/Mdotnom)^0.8);
  /* Insert Qflow and T */
q_dot = U*(thermalPortL.T - T_fluid);
end MassFlowDependence_IdealFluid;
