within Greenhouse.Flows;
package FluidFlow 


  annotation (Documentation(info="<html>
</html>"),
         Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          fillPattern=FillPattern.None,
          extent={{-100,-100},{100,100}},
          radius=25.0),
      Polygon(
        origin={11.533,37.938},
        lineColor = {0,128,255},
        fillColor = {0,128,255},
        fillPattern = FillPattern.Solid,
        points = {{-80,10},{-60,-10},{-80,-30},{-20,-30},{0,-10},{-20,10},{-80,10}}),
      Polygon(
        origin={11.533,37.938},
        lineColor = {255,0,0},
        fillColor = {255,0,0},
        fillPattern = FillPattern.Solid,
        points = {{-40,-90},{-20,-70},{0,-90},{0,-50},{-20,-30},{-40,-50},{-40,-90}}),
      Polygon(
        origin={11.533,37.938},
        lineColor = {255,128,0},
        fillColor = {255,128,0},
        fillPattern = FillPattern.Solid,
        points = {{-20,10},{0,-10},{-20,-30},{40,-30},{60,-10},{40,10},{-20,10}})}));
end FluidFlow;
