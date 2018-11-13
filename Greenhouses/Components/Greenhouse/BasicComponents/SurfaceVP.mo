within Greenhouses.Components.Greenhouse.BasicComponents;
model SurfaceVP
  "Vapour pressure at a surface defined by the saturated vapour pressure for its temperature"

  /*********************** Varying inputs ***********************/
  Real T(unit="K")=300 "Saturation temperature"
    annotation (Dialog(group="Varying inputs"));

  /*********************** Variables ***********************/
  Real VP(unit="Pa");

  /******************** Connectors ********************/
  Interfaces.Vapour.WaterMassPort_a port "Saturation pressure" annotation (
      Placement(transformation(extent={{-10,-10},{10,10}}), iconTransformation(
          extent={{-10,-10},{10,10}})));

equation
  VP = Functions.SaturatedVapourPressure(T - 273.15);
  port.VP = VP;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-106,74},{106,42}},
          lineColor={170,213,255},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Rectangle(
          extent={{-20,80},{20,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward,
          origin={0,0},
          rotation=90)}));
end SurfaceVP;
