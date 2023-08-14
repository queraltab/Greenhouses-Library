within Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses;
partial model PartialHeatTransferCorrelation
  "Base class for all heat transfer correlations"
      extends Greenhouses.Icons.HeatTransfer;

  input Modelica.Units.SI.MassFlowRate m_dot "Inlet massflow";
  input Modelica.Units.SI.HeatFlux q_dot "Heat flow rate per area [W/m2]";

  output Modelica.Units.SI.CoefficientOfHeatTransfer U;

annotation(Documentation(info="<html>
<p><b><font style=\"font-size: 11pt; color: #008000; \">Heat transfer correlations</font></b></p>
<p>The partial model <b>PartialHeatTransferCorrelation</b>is the base model for 
all calculations of heat transfer coefficients. It returns an HTC called U 
and requires a thermodynamic state, the inlet mass flow rate and the heat flux 
as inputs. 
</p>
</html>"));
end PartialHeatTransferCorrelation;
