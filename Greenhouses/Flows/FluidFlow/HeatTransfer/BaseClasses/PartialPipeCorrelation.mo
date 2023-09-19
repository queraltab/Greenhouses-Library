within Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses;
partial model PartialPipeCorrelation
  "Base class for heat transfer correlations for pipe flow"
      extends
    Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses.PartialHeatTransferCorrelation;

  parameter Modelica.Units.SI.Length d_h "Hydraulic diameter"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Area A_cro=Modelica.Constants.pi*d_h^2/4
    "Cross-sectional area" annotation (Dialog(group="Advanced geometry"));

annotation(Documentation(info="<html>
<p><b><font style=\"font-size: 11pt; color: #008000; \">Pipe flow correlations</font></b></p>
<p>The model <b>PartialPipeCorrelation</b>is the base model for the calculation of heat transfer coefficients for pipes. It returns an enhanced HTC U and requires the characteristic length (hydraulic diameter) as input. For non-circular cross sections, the additional parameter A_cro can be used to decaouple wetted perimeter and velocity calculations. </p>
</html>"));
end PartialPipeCorrelation;
