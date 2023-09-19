within Greenhouses.Flows.FluidFlow.HeatTransfer.BaseClasses;
partial model PartialHeatTransfer_IdealFluid
                                              extends
    Greenhouses.Icons.HeatTransfer;
// Partial heat transfer model

  parameter Integer n=1 "Number of heat transfer segments";
  // Inputs provided to heat transfer model

  //Outputs defined by the heat transfer model
  output Modelica.Units.SI.HeatFlux q_dot "Heat flux";

  Greenhouses.Interfaces.Heat.ThermalPortL thermalPortL annotation (Placement(
        transformation(extent={{-24,56},{20,76}}), iconTransformation(extent={{
            -24,56},{20,76}})));

equation
  q_dot = thermalPortL.phi;

annotation(Documentation(info="<html>
<p><big> The Partial model <b>PartialHeatTransfer_IdealFluid</b> is the basic model for heat transfer of an ideal fluid in the library. It calculates the
heat flux, q_dot, exchanged through the thermal port, ThermalPortL.
<p><big> In order to complete the model - from <FONT COLOR=blue>partial model</FONT>  to <FONT COLOR=blue> model</FONT> -
 one equation relating the exchanged heat flux, q_dot, with the fluid temperature, T_fluid,
and the temperature at the boundary thermalPortL.T has to be provided.
</html>"));
end PartialHeatTransfer_IdealFluid;
