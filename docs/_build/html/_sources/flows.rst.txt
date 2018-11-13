.. _flows:

Flows
=====


The **Flows** package contains models of the flows that are encountered in a greenhouse system. It is organized in eight sub-packages that model the heat, vapor mass and |CO2| mass transfer, as well as fluid flow. It also contains a sub-package of interfaces, which defined the type of connectors used in the library.


Heat flows
----------

The *HeatTransfer* sub-package models the heat flows in a greenhouse, which can originate from convection at surfaces, ventilation processes, conduction at the soil and long-wave infrared radiation (FIR). 

Convective and conductive heat flows are function of the heat exchange coefficient and are described by:

.. math::
	\dot{q}_{cnv,ij} = U_{ij}(T_i-T_j)


FreeConvection
^^^^^^^^^^^^^^
Typically, convective processes in greenhouses are governed by free convection. In this case, the Nusselt (Nu) number describing the convective exchange process can be defined as a function of the Rayleigh (Ra) number :cite:`balemans_assessment_1989`. The heat exchange coefficients are therefore modeled based on the Nu-Ra relation, as presented in :cite:`de_zwart_analyzing_1996`.

Upward or downward heat exchange by free convection from an horizontal or tilted surface. In the greenhouse, this comprises the convection at the cover, the thermal screen and at the floor. 

.. math::
	:nowrap:

   	\[
	U_{AirFlr} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		1.7(T_{Flr} - T_{Air})^{0.33},& T_{Flr} &> T_{Air} \\
		1.3(T_{Air} - T_{Flr})^{0.25},& T_{Flr} &\leq T_{Air}
	\end{array}
	\right.
	\]

.. math::
	U_{AirScr} = 1.7 u_{Scr} |T_{Air}-T_{Scr}|^{0.33}
.. math::
	U_{AirCov} = 1.7 (T_{Air}-T_{Cov})^{0.33} cos(\phi)^{-0.66}

.. figure:: figures/freeconvection.png
	:figclass: align-center

PipeConvection
^^^^^^^^^^^^^^
Free convection at the pipes with the greenhouse air. For the pipes situated close to the canopy and the floor, the heat exchange is considered to be hindered, compared to a pipe in free air. The heat exchange coefficients of these forced processes are modeled by experimental results :cite:`bot_greenhouse_1983`.

.. math::
	U_{FreePipeAir} = 1.28 \pi \psi_{Pipe}^{0.75} l_{Pipe} |T_{Pipe}-T_{Air}|^{0.25}
.. math::
	U_{HinderedPipeAir} = 1.99 \pi \psi_{Pipe} l_{Pipe} |T_{Pipe}-T_{Air}|^{0.32}

.. figure:: figures/pipeconvection.png
	:figclass: align-center

PipeConvection_N
^^^^^^^^^^^^^^^^
This model is a variant of the *PipeConvection* model, in which a single-port is replaced by a multi-port, thus enabling the computation of the heat flow when using discretized pipes models.

.. figure:: figures/pipeconvectionN.png
	:figclass: align-center 

CanopyFreeConvection
^^^^^^^^^^^^^^^^^^^^
The leaves heat exchange by free convection with the air is function of the Leaf Area Index (LAI) and the leaves heat transfer coefficient.

.. math::
	U_{CanAir} = 2 \alpha_{LeafAir} LAI

.. figure:: figures/canopyconvection.png
	:figclass: align-center

OutsideAirConvection
^^^^^^^^^^^^^^^^^^^^
Convective heat exchange at the cover with the outside air. Convection, driven by wind speed, is considered to be forced.

.. math::
	:nowrap:

   	\[
	U_{CovOut} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		(2.8+1.2 v_w) \dfrac{1}{cos(\phi)},& v_w &< 4 \\
		2.5 v_w^{0.8} \dfrac{1}{cos(\phi)},& v_w &\geq 4
	\end{array}
	\right.
	\]

.. figure:: figures/outsideairconvection.png
	:figclass: align-center

SoilConduction
^^^^^^^^^^^^^^
The only conductive flow considered in greenhouse modeling is the conduction through the greenhouse soil. The soil under the greenhouse floor represents a big thermal capacity with a poor thermal conductivity. The floor surface can show temperature variations of 10 K during a day. To be able to describe the temperature gradient, the soil is modeled in several layers, using the following heat exchange coefficient.

.. math::
	U_{So(j-1)So(j)} = \dfrac{2}{h_{So(j-1)}/\lambda_{So(j-1)}+h_{So(j)}/\lambda_{So(j)}}

.. figure:: figures/soilconduction.png
	:figclass: align-center


FreeVentilation
^^^^^^^^^^^^^^^
Convective flows caused by ventilation processes are modeled based on the air exchange rate f\ :sub:`ij` \ between two air volumes *i* and *j*, as described by:

.. math::
	U_{vent,AirOut} = \rho_{Air} c_{p,Air} (f_{AirOut}+f_{leakage})

The library offers two models (*NaturalVentilationRate_1* and *NaturalVentilationRate_2*) to compute the air ventilation rate caused by natural ventilation with the outside air. The models are based on two different models from the literature. By default, f\ :sub:`AirOut` \  is described by the model *NaturalVentilationRate_2*, which is based on Boulard and Baille (1993).

The leakage rate through the greenhouse structure is dependent on the wind speed and the leakage coefficient of the greenhouse, characteristic of its structure. It can be described by:

.. math::
	:nowrap:

   	\[
	f_{leakage} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		0.25 c_{leakage},& v_w &< 0.25 \\
		v_w c_{leakage},& v_w &\geq 0.25
	\end{array}
	\right.
	\]

.. figure:: figures/freeventilation.png
	:figclass: align-center


AirThroughScreen
^^^^^^^^^^^^^^^^
The air ventilation between the main and top air zones is caused by two mechanisms: the air through the openings in the fabric of the screen and the air through a gap when the screen is opened. Balemans, 1989studied the temperature driven air exchange through fully closed screens (u\ :sub:`Scr` \ =1) and derived a fitted function through experimental data. When the screen is open (u\ :sub:`Scr` \ <1), the air exchanged through the gap, caused by density difference, will dominate the exchange through the screen. This exchange was theoretically modeled by Miguel, 1998 using the Navier-Stokes equation. Combining the air flow through the screen and through the gap, the total air ventilation rate between the air and top zones is described by:

.. math::
	U_{vent,AirTop} = \rho_{Air} c_{p,Air} f_{AirTop}
.. math::
	f_{AirTop} = u_{Scr} K_{Scr} |T_{Air}-T_{Top}|^{0.66} +
        \dfrac{1-u_{Scr}}{\overline{\rho}_{Air}} \sqrt{0.5 \overline{\rho}_{Air} W (1-u_{Scr}) g |\rho_{Air}-\rho_{Top}|}

.. figure:: figures/airthroughscreen.png
	:figclass: align-center


Radiation_T4
^^^^^^^^^^^^
The thermal radiation, i.e. the electromagnetic radiation emitted between two bodies *i* and *j* as a result of their temperatures, is described by the Stefan-Boltzman equation:

.. math::
	\dot{q}_{rad,ij} = \epsilon_{i} \epsilon_{j} F_{ij} \sigma (T_i^4-T_j^4)

The view factors of the greenhouse elements are computed according to :cite:`de_zwart_analyzing_1996` in each component model (i.e. the components described in the :ref:`greenhouse` section). The exchange with the sky, whose temperature is estimated from meteorological data by an approach proposed in :cite:`de_zwart_analyzing_1996`, is also considered.The emission coefficients are characteristic of the surfaces. For the greenhouse elements, the following values are proposed:

	=============== =============== 
	Component       Value		
	=============== =============== 
	Glass cover	0.84		
	Pipes		0.88		
	Canopy leaves	1.00		
	Concrete floor	0.89		
	Thermal screen	1.00		
	=============== =============== 

.. figure:: figures/radiationT4.png
	:figclass: align-center 

Radiation_N
^^^^^^^^^^^
This model is a variant of the *Radiation_T4* model, in which a single-port is replaced by a multi-port, thus enabling the computation of the radiative flow when using discretized pipes models.

.. figure:: figures/radiationN.png
	:figclass: align-center 


Vapor flows
------------

MV_cnv_condensation
^^^^^^^^^^^^^^^^^^^
The vapor mass transfer caused by condensation at a surface is linearly related to its convective heat exchange coefficient by a conversion factor. In the greenhouse, condensation may occur at the lower side of the cover and the thermal screen. The model excludes evaporation at these surfaces.

.. math::
	:nowrap:

   	\[
	\dot{m}_{v,ij} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		0,& P_{v,i} &< P_{v,j} \\
		6.4·10^{-9} U_{ij} (P_{v,i}-P_{v,j}),& P_{v,i} &\geq P_{v,j}
	\end{array}
	\right.
	\]


Because of the direction nature of this flow, the model is not reversible and must be connected as following: air (filled port) - surface (empty port).

.. figure:: figures/mvcondensation.png
	:figclass: align-center 

MV_cnv_evaporation
^^^^^^^^^^^^^^^^^^
The vapor mass transfer caused by evaporation at a surface is linearly related to its convective heat exchange coefficient by a conversion factor. In the greenhouse, evaporation may occur at the upper side of the thermal screen. The model excludes condensation at this surface. By allowing a mass flow rate from the upper surface of the screen to the top air compartment, the model assumes that the screen is capable of transporting water through its fabric. Water is transported from the lower side to the upper and storage of water in the screen is neglected. Therefore, evaporation from the upper side is only possible when condensation takes place at the lower side. Moreover, the evaporation rate must be lower or equal than the condensation rate.

.. math::
	:nowrap:

   	\[
	\dot{m}_{v,ScrTop} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		0,& P_{v,Scr} &< P_{v,Top} \\
		min \left( 6.4·10^{-9} U_{ScrTop}, 6.4·10^{-9} U_{AirTop} \dfrac{P_{v,Air}-P_{v,Scr}}{P_{v,Scr}-P_{v,Top}} \right) (P_{v,Scr}-P_{v,Top}),& P_{v,Scr} &\geq P_{v,Top}
	\end{array}
	\right.
	\]

Because of the direction nature of this flow, the model is not reversible and must be connected as following: surface (filled port) - air (empty port).

.. figure:: figures/mvevaporation.png
	:figclass: align-center 


MV_Ventilation
^^^^^^^^^^^^^^
Mass transfer also occurs in ventilation processes. The computation of the vapor flow exchanged by ventilation from the indoor to outdoor air is modeled by:

.. math::
	\dot{m}_{v,ij} = \dfrac{M_{Water} f_{ij}}{R} \left( \dfrac{P_{v,i}}{T_i}-\dfrac{P_{v,j}}{T_j} \right)

where f\ :sub:`ij` \ can be f\ :sub:`AirOut` \ or f\ :sub:`TopOut`\.

.. figure:: figures/mvventilation.png
	:figclass: align-center 

MV_AirThroughScreen
^^^^^^^^^^^^^^^^^^^
The computation of the vapor flow exchanged by ventilation between the main and top air zones is described similarly than in *MV_Ventilation*, but applying the air exchange coefficient f\ :sub:`AirTop`\.

.. figure:: figures/mvairthroughscreen.png
	:figclass: align-center 

MV_CanopyTranspiration
^^^^^^^^^^^^^^^^^^^^^^
The vapor flow from the canopy to the greenhouse air originates from a phase interface somewhere inside the cavities of a leaf. The resistance to vapor transport from the canopy leaves to the greenhouse air is made of an internal resistance and a boundary layer resistance :cite:`stanghellini_transpiration_1987`. According to the latter, the canopy transpiration can be defined by:

.. math::
	\dot{m}_{v,CanAir} = \dfrac{2 \rho_{Air} c_{p,Air} LAI}{ \Delta H \gamma (r_b+r_s)} (P_{v,Can}-P_{v,Air})

.. figure:: figures/mvcanopytranspiration.png
	:figclass: align-center 



Heat and Vapor Flows
--------------------
In the vapor model, all flows result from convective exchange processes and in order to compute them, the heat exchange coefficient of these convective processes is used. Therefore, in order to reduce the number of connections and inputs when building a greenhouse model, the heat and vapor models of convective processes are lumped into single models in which both computations are performed simultaneously. The *HeatAndVaporTransfer* sub-package includes the lumped models.

Convection_Condensation
^^^^^^^^^^^^^^^^^^^^^^^
Combines the equations of *FreeConvection* and *MV_cnv_condensation*.

.. figure:: figures/convectioncondensation.png
	:figclass: align-center 

Convection_Evaporation
^^^^^^^^^^^^^^^^^^^^^^
Combines the equations of *FreeConvection* and *MV_cnv_evaporation*.

.. figure:: figures/convectionevaporation.png
	:figclass: align-center 

Ventilation
^^^^^^^^^^^
Combines the equations of *FreeVentilation* and *MV_ventilation*.

.. figure:: figures/lumpedventilation.png
	:figclass: align-center 

AirThroughScreen
^^^^^^^^^^^^^^^^
Combines the equations of *AirThroughScreen* from the *HeatTransfer* sub-package and *MV_AirThroughScreen*.

.. figure:: figures/lumpedairthroughscreen.png
	:figclass: align-center 


VentilationRates
^^^^^^^^^^^^^^^^
This sub-package contains two different models for computing the air exchange rate in convective processes, and a model for computing the air rate due to a forced ventilation system.

* **NaturalVentilationRate_1**: based on :cite:`jong_1991`. The air exchange rate is modeled in function of the wind and temperature. The contribution of the temperature driven ventilation in the total ventilation is small but can be important during nighttime and winter. The wind speed driven ventilation is computed differently for vents in the windward side and the leeside side. The air exchange is related to the wind speed and the opening of a window. 

.. math::
	f_{AirOut} = 0.5 fr_{window} \sqrt{ \Phi_{wind}^2 + \Phi_{temp}^2}
.. math::
	\Phi_{wind} = \left( 2.29·10^{-2} (1- exp(-\theta /21.1) + 1.2·10^{-3} \theta exp(\theta /211) \right) A_{window} u_{wind}
.. math::
	\Phi_{temp} = C_f l/3 \sqrt{|g \beta \Delta T|} h^{1.5} \left[ \left( sin(\psi)-sin(\psi-\theta_l) \right)^{1.5} + \left( sin(\psi)-sin(\psi-\theta_w) \right)^{1.5} \right]

* **NaturalVentilationRate_2**: based on :cite:`boulard_simple_1993`. The air ventilation ratedepends mainly on the windows opening (u\ :sub:`vent`\) and is influenced by the wind pressure coefficient and the coefficient of energy discharge caused by friction at the windows.

.. math::
	f_{AirOut} = \dfrac{u_{vent} A_{Roof} C_{d}}{2 A_{Flr}} \sqrt{g \dfrac{h_{vent}}{2} \dfrac{T_{Air}-T_{Out}}{\overline{T}} + C_w v_w^2 } 

.. figure:: figures/f_vent.png
	:figclass: align-center 

* **ForcedVentilationRate**: The air exchange rate caused by a mechanical ventilation system is function of the speficic air flow capacity of the ventilation system and its control.

.. math::
	f_{ventForced} = U_{VentForced} \dfrac{\phi_{VentForced}}{A_{Floor}}

.. figure:: figures/f_forced.png
	:figclass: align-center 

|CO2| flows
-----------
In the greenhouse, there are three |CO2| flows associated to the ventilation processes and two forced flows, i.e. the canopy consumption and the |CO2| enrichment. 

MC_ventilation
^^^^^^^^^^^^^^
The |CO2| flow accompanying an air flow is function of the air flow rate and can be described by:

.. math::
	\dot{m}_{c,ij} = f_{ij}(CO_{2,i}-CO_{2,j})

.. figure:: figures/mcventilation.png
	:figclass: align-center 

MC_AirCan
^^^^^^^^^
The greenhouse |CO2| net assimilation rate by the canopy is computed in the yield model and used as an input in this model.

.. figure:: figures/mcaircan.png
	:figclass: align-center 


Fluid flows
-----------

Cell1DimInc
^^^^^^^^^^^
Fluid flows are modeled using the finite volume approach by means of a discretized model for incompressible flow, adapted from :cite:`quoilin_thermocycle:_2014`. The model distinguishes between two types of variables: cell and node variables. The basic fluid flow component is a cell in which the dynamic energy balance and static mass and momentum balances are applied. Node variables correspond to the inlet and outlet nodes of each cell. The relation between the cell and node values depend on the selected discretization scheme (upwind or central differences). In the cell, uniform velocity through the cross section and constant pressure are assumed. Axial thermal energy transfer is neglected. 

.. figure:: figures/fluidcell.png
	:figclass: align-center 

Flow1DimInc
^^^^^^^^^^^
The overall flow model can be build by connecting several cells in series. The model is compatible with the \textit{Media} package of the Modelica Standard Library, at the condition that the considered fluid is incompressible.

.. figure:: figures/fluidflow.png
	:figclass: align-center 



.. |CO2| replace:: CO\ :sub:`2`
