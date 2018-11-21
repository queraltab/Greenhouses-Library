.. _hvac:

HVAC
====

CHP
---

The CHP model is a performance-based model that assumes constant natural gas consumption and constant
total efficiency. The electrical efficiency is described by the second-law efficiency and the efficiency of Carnot:

.. math::
	\eta_{el} = \eta_{II} \eta_{Carnot}

The second law efficiency is assumed constant and is defined by the previous equation at the nominal conditions. The electrical and thermal power are computed by:

.. math::
	\dot{W}_{CHP} = \eta_{el} \dot{Q}_{nom,gas} U_{ONOFF}

.. math::
	\dot{Q}_{CHP} = \eta_{th} \dot{Q}_{nom,gas} U_{ONOFF}

where the thermal efficiency is described by:

.. math::
	\eta_{th} = \eta_{tot} - \eta_{el}

The heat source is assumed to be at a constant temperature. The properties of the primary fluid are computed using the incompressible *Cell1Dim* model. The model includes a boolean input connector, which defines the operational state of the CHP, and a real output connector for the electrical power.  In the equations, the boolean input is translated to the variable U\ :sub:`ONOFF`\.

.. figure:: figures/chp.png
	:figclass: align-center


Heat Pump
---------

This heat pump model does not consider part-load operation (ON/OFF regulation is assumed). The nominal heat flow is an input of the model, characteristic of the size of the heat pump. The COP is described by: 

.. math::
	COP = \dfrac{\eta_{II}}{\eta_{Carnot}}

The second-law efficiency is assumed to remain unchanged in part-load operation. The electrical power consumed by the heat pump is described by:

.. math::
	\dot{W} = \dfrac{\dot{Q}}{COP}	

In order to account for the lower heat capacity of the heat pump at lower evaporating temperature, the heating power and the heat soure temperature are computed by assuming a linear correlation between their actual and nominal values:

.. math::
	\dfrac{\dot{Q}}{\dot{Q}_{nom}} = \dfrac{T_c}{T_{c,nom}}

The primary fluid is modeled by means of 1-D incompressible fluid flow model (*Cell1DimInc*), in which a dynamic energy balance and static mass and momentum balances are applied on the fluid. The heat transfer in the primary fluid is modeled with a constant heat transfer coefficient. However, it can be changed to other heat transfer models through the *HeatTransfer* parameter in the fluid model.

Furthermore, the model includes a Boolean input connector *on_off*, which defines the operational state of the heat pump. In the equations, the Boolean input is translated to a variable value together with a first order block, which can take into account a start-up time constraint.

.. figure:: figures/hp.png
	:figclass: align-center


Heat Pump Consoclim
-------------------
This model is used to determine the performances of a heat pump for different operating conditions. The ConsoClim model developed by the Ecole de Mines (Paris) is used. The model predicts the performances of the system with three polynomial laws. The parameters of the model are identified with manufacturer data. 

The first and the second law (EIRFT and CAPFT) are used respectively to determine
the COP and the heating capacity of the machine at full load. These two polynomial
laws depend on the outside air temperature (T_a_out) and the temperature of the 
water at the exhaust of the condenser (T_w). The third law is used to determine 
the performances of the system at part load.

The primary side fluid is modeled by means of 1-D incompressible fluid flow model , 
in which a dynamic energy balance and static mass and momentum balances are applied 
on the fluid. The heat transfer in the primary fluid is modeled with a constant 
heat transfer coefficient. However, it can be changed to other heat transfer models 
through the *HeatTransfer* parameter in the fluid model.

Furthermore, the model includes a Boolean input connector *on_off*, which defines 
the operational state of the heat pump. In the equations, the Boolean input is translated 
to a variable value together with a first order block, which can take into account a start-up 
time constraint. The model also includes a real input connector *W_dot_set* to define the
power that is injected to the heat pump. This connector is useful, for example, in the case 
where a heat pump is powered by the CHP electrical generation.


.. figure:: figures/hpconsoclim.png
	:figclass: align-center


Thermal energy storage
----------------------

Nodal model of a stratified tank with an internal heat exchanger and ambient heat losses. The following hypothesis are applied:

* No heat transfer between the different nodes.
* The internal heat exchanger is discretized in the same way as the tank: each cell of the heat exchanger corresponds to one cell of the tank and exchanges heat with that cell only.
* Incompressible fluid in bboth the tank and the heat exchanger.

The tank is discretized using a modified version of the incompressible *Cell1Dim* model adding an additional heat port, which acts as a heating resistance. The model also includes a temperature sensor, whose height can be adjusted. The energy balance of the fluid in the tank is described by:

.. math::
	\dfrac{V_{tank}}{N} \rho \dfrac{dh}{dt} + \dot{M} (h_{ex}-h_{su}) - A_{hx} \dot{q}_{hx} = \dfrac{A_{amb}}{N} \dot{q}_{amb} + \dot{Q}_{res}


The heat exchanger is modeled using the *Flow1Dim* component and a wall component. The energy balance of the fluid in the heat exchanger is described by:

.. math::
	V_i \rho \dfrac{dh}{dt} + \dot{M} (h_{ex}-h_{su}) = A_i \dot{q}


.. figure:: figures/tes.png
	:figclass: align-center

.. 
	Dehumidifier
	------------
	Performance-based model of a thermodynamic dehumidifier based on the characteristics of the industrial dehumidifier `Caldor CD520`_. The warm saturated air of the greenhouse is passed by the evaporator, where it is cooled down and dehumidified by condensation. Afterwards, the air is heated up by passing through the condenser. The air is sent back to the greenhouse at 25-30ºC.
	The heat port of the model accounts for the heat power released to the greenhouse air. The mass flow rate of the vapor mass port, i.e. the water removed from the air by condensation, is computed according to the device performance, which is function of the indoor air characteristics. The model includes a boolean input connector, which sets the operational state of the system (ON-OFF), and a real input connector, which defines the operational power of the system (in case the system is desired to operate at partial-load).
	.. figure:: figures/dehumidifier.png
	:figclass: align-center
	.. _Caldor CD520: https://caldor.fr/deshumidificateur-de-serres/

