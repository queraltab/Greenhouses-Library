within Greenhouses.Interfaces.Heat;
model HeatPortConverter_ThermoCycle_Modelica
  "Heat port converter from the Modelica Library to the ThermoCycle Library heat port models"
  parameter Modelica.SIunits.Area A "Heat transfer area";
  parameter Integer N(min=1)=2 "Number of ports in series";
  parameter Integer Nt(min=1)=1 "Number of cells in parallel";
  ThermalPort                                     thermocyclePort(N=N)
    annotation (Placement(transformation(extent={{-32,-40},{28,-20}}),
        iconTransformation(extent={{-40,-40},{40,-20}})));
public
  Greenhouses.Interfaces.Heat.HeatPorts_a[N] heatPorts annotation (
      Placement(transformation(extent={{-10,22},{10,42}}),
        iconTransformation(extent={{-40,20},{40,40}})));
equation
  for i in 1:N loop
    heatPorts[i].T = thermocyclePort.T[i];
    heatPorts[i].Q_flow = -thermocyclePort.phi[i]*A/N*Nt;
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end HeatPortConverter_ThermoCycle_Modelica;
