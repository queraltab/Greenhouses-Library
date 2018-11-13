.. _cropyield:

Crop Yield
==========

Model variables and parameters
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Parameters
----------

.. table::

	======================================= ===============================	===============================================================================
	Name                                    Units   			Description
	======================================= =============================== ===============================================================================
	:math:`c_{\Gamma}`			umol{|CO2|} mol⁻¹{air} K⁻¹	Determines the effect of canopy temperature on the |CO2| compensation point
	:math:`C_{Buf}^{max}`			mg{|CH2O|} m⁻²			Maximum buffer capacity
	:math:`C_{Buf}^{min}`			mg{|CH2O|} m⁻²			Minimum amount of carbohydrates in the buffer
	:math:`c_{BufFruit_1}^{max}`		fruits plant⁻¹ s⁻¹		Regression coefficient
	:math:`c_{BufFruit_2}^{max}`		fruits plant⁻¹ s⁻¹ ºC⁻¹		Regression coefficient
	:math:`c_{Dev_1}`			s⁻¹				Regression coefficient
	:math:`c_{Dev_2}`			s⁻¹ ºC⁻¹			Regression coefficient
	:math:`c_{Fruit,g}`			--				Growth respiration coefficient of fruit
	:math:`c_{Fruit,m}`			s⁻¹				Maintenance respiration coefficient of fruit
	:math:`c_{Leaf,g}`			--				Growth respiration coefficient of leaf
	:math:`c_{Leaf,m}`			s⁻¹				Maintenance respiration coefficient of leaf
	:math:`c_{RGR}`				s				Regression coefficient for maintenance respiration
	:math:`c_{Stem,g}`			--				Growth respiration coefficient of stem
	:math:`c_{Stem,m}`			s⁻¹				Maintenance respiration coefficient of stem
	:math:`E_j`				J mol⁻¹				Activation energy for :math:`J^{POT}`
	:math:`G^{max}`				mg{|CH2O|} fruit⁻¹		Potential fruit weight
	:math:`H`				J mol⁻¹				Deactivation energy
	:math:`J_{25Leaf}^{max}`		umol{e-} m⁻²{leaf} s⁻¹		Maximum rate of electron transport at 25ºC for the leaf
	:math:`LAI^{max}`			m²{leaf} m⁻²			Maximum leaf area index
	:math:`M_{CH2O}`			mg umol⁻¹			Molar mass of |CH2O|
	:math:`M_{CO2}`				mg umol⁻¹			Molar mass of |CO2|
	:math:`n_{Dev}`				--				Number of development stages
	:math:`n_{Plants}`			plants m⁻²			Plants density in the greenhouse
	:math:`Q_{10,m}`			--				:math:`Q_{10}` value for temperature effect on maintenance respiration
	:math:`r_{BufFruit}^{max,FrtSet}`	mg{|CH2O|} m⁻² s⁻¹		Carbohydrate flow from buffer to the fruits above which fruit set is maximal
	:math:`R_g`				J mol⁻¹ K⁻¹			Molar gas constant
	:math:`rg_{Fruit}`			mg{|CH2O|} m⁻² s⁻¹		Potential fruit growth rate coefficient at 20ºC
	:math:`rg_{Leaf}`			mg{|CH2O|} m⁻² s⁻¹		Potential leaf growth rate coefficient at 20ºC
	:math:`rg_{Stem}`			mg{|CH2O|} m⁻² s⁻¹		Potential stem growth rate coefficient at 20ºC
	:math:`S`				J mol⁻¹ K⁻¹			Entropy term
	:math:`SLA`				m²{leaf} mg⁻¹{|CH2O|}		Specific leaf area index
	:math:`T_{25,K}`			K				Reference temperature at 25ºC
	:math:`\alpha`				umol{e⁻} umol⁻¹{photons}	Conversion factor from photons to electrons
	:math:`\eta_{CO2,Air-Stom}`		--				Conversion factor from the |CO2| concentration in the greenhouse air to the stomata
	:math:`\eta_{C-DM}`			mg{DM} mg⁻¹{|CH2O|}		Conversion factor from carbohydrate to dry matter
	:math:`\eta_{Glob-PAR}`			umol{photons} J⁻¹		Conversion factor from global radiation to PAR
	:math:`\theta`				--				Degree of curvature of the electron transport rate
	:math:`\tau`				s				Time constant to calculate the 24-h mean temperature
	======================================= =============================== ===============================================================================


Variables
---------

.. table::

	===============================================	=======================	=================================================================================
	Name                                    	Units   		Description
	===============================================	======================= =================================================================================
	:math:`B`					d⁻¹			Steepness of the curve
	:math:`C_{Buf}`					mg m⁻²			Carbohydrates in the buffer
	:math:`C_{Fruit[j]}`				mg m⁻²			Amount of fruit carbohydrates in the development stages
	:math:`C_{Leaf}`				mg m⁻²			Carbohydrate weight of the leaves
	:math:`C_{Leaf}^{max}`				mg m⁻²			Maximum allowed carbohydrates stored in the leaves
	:math:`C_{Stem}`				mg m⁻²			Carbohydrate weight of stems and roots
	:math:`CO2_{Stom}`				umol{|CO2|} mol⁻¹{æir}	|CO2| concentration in the stomata
	:math:`DM_{Har}`				mg m⁻²			Accumulated harvested fruit dry matter
	:math:`FGP`					d			Fruit growth period
	:math:`GR[j]`					mg u⁻¹ d⁻¹		Daily potential growth rate per fruit in a development stage
	:math:`g_{T_{Can24}}`				--			Growth rate dependency to temperature
	:math:`h_{C_{Buf}}^{m_{C,AirBuf}}`		-- 			Inhibition coefficient of the photosynthesis rate by saturation of the leaves with carbohydrates
	:math:`h_{C_{Buf}}^{m_{C,BufOrg}}`		-- 			Inhibition coefficient of insufficient carbohydrates in the buffer
	:math:`h_{T_{Can}}`				--			Inhibition coefficient of non-optimal instantaneous canopy temperature
	:math:`h_{T_{Can24}}`				--			Inhibition coefficient of non-optimal 24-h mean canopy temperature
	:math:`h_{T_{CanSum}}`				--			Inhibition coefficient of crop development stage
	:math:`h_{T_{CanSum}}^{m_{N,Fruit}}`		-- 			Inhibition coefficient of fruit flow
	:math:`J`					umol{e-} m⁻² s⁻¹ 	Electron transportation rate
	:math:`J_{POT}`					umol{e-} m⁻² s⁻¹ 	Potential rate of electron transport at 25ºC for the canopy
	:math:`J_{25Can}^{max}`				umol{e-} m⁻² s⁻¹	Maximum rate of electron transport at 25ºC for the canopy
	:math:`LAI`					m²{leaf} m⁻²		Leaf area index
	:math:`M`					d			Fruit development time in days where GR is maximal
	:math:`\dot{m}_{C,AirBuf}`			mg m⁻² s⁻¹		Net photosynthesis rate
	:math:`\dot{m}_{C,AirCan}`			mg m⁻² s⁻¹		Carbohydrate flow between the air and the canopy
	:math:`\dot{m}_{C,BufAir}`			mg m⁻² s⁻¹		Growth respiration of the total plant
	:math:`\dot{m}_{C,BufFruit}`			mg m⁻² s⁻¹		Carbohydrate flow from the buffer to the fruits
	:math:`\dot{m}_{C,BufFruit[1]}`			mg m⁻² s⁻¹		Carbohydrate flow to the first development stage
	:math:`\dot{m}_{C,BufFruit[j]}`			mg m⁻² s⁻¹		Carbohydrate flow from the buffer to the remaining development stages
	:math:`\dot{m}_{C,BufLeaf}`			mg m⁻² s⁻¹		Carbohydrate flow from the buffer to the leaves
	:math:`\dot{m}_{C,BufStem}`			mg m⁻² s⁻¹		Carbohydrate flow from the buffer to the stems and roots
	:math:`\dot{m}_{C,Fruit[j]Fruit[j+1]}`		mg m⁻² s⁻¹		Carbohydrate flow through the fruit development stages
	:math:`\dot{m}_{C,FruitAir}`			mg m⁻² s⁻¹		Total maintenance respiration of the fruits
	:math:`\dot{m}_{C,FruitAir,g}`			mg m⁻² s⁻¹		Growth respiration of the fruits
	:math:`\dot{m}_{C,FruitAir[j]}`			mg m⁻² s⁻¹		Maintenance respiration of the fruits at the development stages
	:math:`\dot{m}_{C,FruitHar}`			mg m⁻² s⁻¹		Carbohydrate outflow of the last fruit development stage
	:math:`\dot{m}_{C,LeafAir}`			mg m⁻² s⁻¹		Maintenance respiration of the leaves	
	:math:`\dot{m}_{C,LeafAir,g}`			mg m⁻² s⁻¹		Growth respiration of the leaves
	:math:`\dot{m}_{C,LeafHar}`			mg m⁻² s⁻¹		Leaf haverst rate
	:math:`\dot{m}_{C,StemAir}`			mg m⁻² s⁻¹		Maintenance respiration of the stems and roots	
	:math:`\dot{m}_{C,StemAir,g}`			mg m⁻² s⁻¹		Growth respiration of the stems and roots
	:math:`\dot{m}_{N,BufFruit[1]}`			u m⁻² s⁻¹		Fruit set in the first development stage
	:math:`\dot{m}_{N,BufFruit[1]}^{max}`		u m⁻² s⁻¹		Maximum fruit set in the first development stage
	:math:`\dot{m}_{N,Fruit[j]Fruit[j+1]}`		u m⁻² s⁻¹		Fruit flow through the fruit development stages
	:math:`N_{Fruit[j]}`				u m⁻²			Number of fruits in the development stage *j*
	:math:`P`					umol m⁻² s⁻¹		Gross photosynthesis rate at canopy level
	:math:`PAR_{Can}`				umol{photon} m⁻² s⁻¹	Total PAR absorbed by the canopy computed in the solar model
	:math:`R`					umol m⁻² s⁻¹		Photorespiration during the photosynthesis process
	:math:`r_{dev}`					s⁻¹			Fruit development rate
	:math:`RGR_{Fruit[j]}`				s⁻¹			Net relative growth rate of fruits
	:math:`RGR_{Leaf}`				s⁻¹			Net relative growth rate of leaves
	:math:`RGR_{Stem}`				s⁻¹			Net relative growth rate of stems and roots
	:math:`T_{Can}` (:math:`T_{Can,K}`)		ºC (K)			Canopy temperature
	:math:`T_{Can}^{24}` (:math:`T_{Can,K}^{24}`)	ºC (K)			Mean 24-h canopy temperature
	:math:`T_{Can}^{Sum}` (:math:`T_{Can,K}^{Sum}`)	ºC (K)			Temperature sum
	:math:`t_{j,FGP}`				d			Number of days after fruit set for development stage *j*
	:math:`W_{Fruit_1}^{Pot}`			mg u⁻¹			Potential dry matter per fruit in first fruit development stage
	:math:`\Gamma`					umol{|CO2|} mol⁻¹{air}	|CO2| compensation point
	:math:`\eta` _BufFruit				d m² mg⁻¹		Conversion factor to ensure that :math:`\dot{m}_{C,BufFruit}` equals the sum of the carbohydrates that flow to the different fruit development stages
	===============================================	======================= =================================================================================


Model description
^^^^^^^^^^^^^^^^^

A dynamic tomato crop yield model was implemented to account for the effects of the indoor
climate on crop growth and thereby on the harvested dry matter. Although crop growth is
related to photosynthesis, most of the existent crop models directly relate these two with the
absence of a carbohydrate buffer. The function of the buffer is to store the carbohydrates from
the photosynthesis (inflow) and to distribute them to the plant organs (outflow). It has a
maximum capacity, above which carbohydrates cannot be stored anymore, and a lower limit,
below which the carbohydrate outflow stops. Thus, the in- and out-flows depend on the level
of carbohydrates in the buffer and thereby, may not be simultaneous. An approach based on
not considering the buffer neglects the non-simultaneous character of the flows. For example,
it can neglect the crop growth after dusk, when photosynthesis stops but there may still be
carbohydrate distribution if the buffer level is higher than its lower limit. The presence of a
carbohydrate buffer is thus important when modeling crop growth.

Models with a common carbohydrate buffer are available in the current literature (e.g. :cite:`dayan_development_1993`, :cite:`heuvelink_tomato_1996`, :cite:`linker_description_2004`, :cite:`marcelis_modelling_1998`, :cite:`seginer_optimal_1994`). In this work, a recent yield model :cite:`vanthoor_methodology_2011_crop` developed and validated for a variety of temperatures has been implemented. The model computes the carbohydrates distribution
flows in the presence of a buffer, as shown in the figure below. 

.. figure:: figures/TYM_valves.png
	:figclass: align-center
	:scale: 40%

	Schematic representation of the crop yield model adapted from :cite:`vanthoor_methodology_2011_crop`. Boxes define state
	variables (blocks), semi-state variables (dotted blocks) and carbohydrate flows (valves). Arrows
	define mass fluxes (solid lines) and information fluxes (dotted lines). For the purpose of readability,
	the grey box is a simplified scheme of the mass flows in the fruit development stages. A more
	detailed scheme of the latter can be found in the next figure.


To that end, the model applies carbohydrates mass balances on the buffer, fruits, stems and leaves.
The mass balance on the buffer is defined by:

.. math::
	\dot{C}_{Buf} = \dot{m}_{C,AirBuf} - \dot{m}_{C,BufFruit} - \dot{m}_{C,BufLeaf} - \dot{m}_{C,BufStem} - \dot{m}_{C,BufAir}

The carbohydrates produced by the photosynthesis are stored in the buffer. Whenever carbohydrates are available in the buffer, carbohydrates flow to the fruits, leaves and stems. This flow stops when the buffer reaches its capacity lower limit. In a similar way, the carbohydrate inflow from photosynthesis stops if the buffer reaches its maximum capacity.

The available carbohydrates for fruit growth are distributed to the different fruit development stages. 
The fruit growth period, defined as the time between fruit set and fruit harvest, is modeled using the “fixed boxcar train” method :cite:`leffelaar_elements_1989`. With this method, fruit development is modeled by distinguishing several successive fruit development stages, at which the number of fruits and the amount of carbohydrates are described. As shown in the figure below, the number of fruits and carbohydrates are considered to flow from one stage to the next with a specific development rate.

.. figure:: figures/fruitdevelopment.png
	:figclass: align-center
	:scale: 70%

	Schematic representation of the fruit development model adapted from :cite:`vanthoor_methodology_2011_crop`. Boxes define state
	variables (blocks) and carbohydrate flows (valves). Arrows define mass fluxes (solid lines) and information fluxes (dotted lines).


The carbohydrates stored in a fruit development stage *j* are described by:

.. math::
	\dot{C}_{Fruit[j]} = \dot{m}_{C,BufFruit[j]} + \dot{m}_{C,Fruit[j-1]Fruit[j]} - \dot{m}_{C,Fruit[j]Fruit[j+1]} - \dot{m}_{C,FruitAir[j]}

for *j* = 1,2 ... n\ :sub:`dev`\, where n\ :sub:`dev` \ is the total number of fruit development stages.
For the first development stage, the carbohydrate inflow from the previous stage :math:`\dot{m}_{C,Fruit[j-1]Fruit[j]}` is zero.
For the last development stage, the carbohydrate outflow to the next stage :math:`\dot{m}_{C,Fruit[j]Fruit[j+1]}` is :math:`\dot{m}_{C,FruitHar}`.


The evolution of the number of fruits at a fruit development stage j is described by:

.. math::
	\dot{N}_{Fruit[j]} = \dot{m}_{N,Fruit[j-1]Fruit[j]} - \dot{m}_{N,Fruit[j]Fruit[j+1]}

for *j* = 1,2 ... n\ :sub:`dev`\.

The evolution of the carbohydrates stored in the leaves is described by:

.. math::
	\dot{C}_{Leaf} = \dot{m}_{C,BufLeaf} - \dot{m}_{C,LeafAir} - \dot{m}_{C,LeafHar}

The Leaf Area Index (LAI), defined as the leaf area per unit of ground area, i.e. of greenhouse floor,
is a semi-state variable of the model and determined by:

.. math::
	LAI = SLA \cdot C_{Leaf}

where SLA is the specific leaf area, whose value can be found in the literature.

The evolution of carbohydrates stored in the stems and roots is defined by:

.. math::
	\dot{C}_{Stem} = \dot{m}_{C,BufStem} - \dot{m}_{C,StemAir}

The harvested tomato dry matter (DM) is assumed to evolve with a continuous harvest rate. Thus,
the accumulated DM equals the carbohydrate outflow from the last fruit development stage:

.. math::
	\dot{DM}_{Har} = \eta_{C-DM} \dot{m}_{C,FruitHar}

The development stages of the crop are defined by the evolution of the canopy temperature:

.. math::
	\dot{T}_{Can}^{Sum} = 86400^{-1} T_{Can}

Finally, the 24 hour mean canopy temperature is determined by a 1 st order approach:

.. math::
	\dot{T}_{Can}^{24} = \tau^{-1} (T_{Can}-T_{Can}^{24})




Model flows
^^^^^^^^^^^

Canopy photosynthesis
---------------------

The net photosynthesis rate, which is equal to the gross photosynthesis rate minus the photorespiration, is described by:

.. math::
	\dot{m}_{C,AirBuf} = M_{CH2O} h_{C_{Buf}}^{m_{C,AirBuf}} (P-R)

The inhibition of the photosynthesis rate by saturation of the leaves with carbohydrates occurs when the carbohydrate amount in the buffer exceeds its maximum storage capacity. The inhibition is described by:

.. math::
	:nowrap:

   	\[
	h_{C_{Buf}}^{m_{C,AirBuf}} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		0,& C_{Buf} &> C_{Buf}^{max} \\
		1,& C_{Buf} &\leq C_{Buf}^{max}
	\end{array}
	\right.
	\]


Photosynthesis rate at the canopy level is described by:

.. math:: 
	P = \dfrac{J(CO2_{Stom}-\Gamma)}{4(CO2_{Stom}+2\Gamma)}

The photorespiration is described by:

.. math::
	R = P \dfrac{\Gamma}{CO2_{Stom}}

The electron transport rate is function of the potential rate and the PAR absorbed by the canopy, which is computed in the solar model and used in xx umol{photons} m⁻² s⁻¹.

.. math::
	J = \dfrac{J^{POT} + \alpha PAR_{Can} - \sqrt{(J^{POT}+\alpha PAR_{Can})^2 - 4 \theta J^{POT} \alpha PAR_{Can}}}{2\theta}

The potential electron transport rate depends on temperature:

.. math::
	J^{POT} = J_{25Can}^{max} e^{E_j \dfrac{T_{Can,K}-T_{25,K}}{R_g T_{Can,K} T_{25,K}}} \dfrac{1+e^\dfrac{S T_{25,K}-H}{R_g T_{25,K}}}{1+e^\dfrac{S T_{Can,K}-H}{R_g T_{Can,K}}}

where

.. math::
	J_{25Can}^{max} = LAI \cdot J_{25Leaf}^{max}


The |CO2| concentration in the stomata is expressed as a fraction of the |CO2| concentration in the greenhouse air :cite:`evans_modelling_1991`:

.. math::
	CO2_{Stom} = \eta_{CO2,Air-Stom} CO2_{Air}

Finally, the |CO2| compensation point (:math:`\Gamma`) is described by:

.. math::
	\Gamma = \dfrac{J_{25Leaf}^{max}}{J_{25Can}^{max}} c_{\Gamma} T_{Can} + 20 c_{\Gamma} \left( 1 - \dfrac{J_{25Leaf}^{max}}{J_{25Can}^{max}} \right)



The carbohydrate flow to the fruits, leaves and stems
-----------------------------------------------------

The carbohydrate flow from the buffer to the fruits is function of the potential of fruit growth coefficient, the effect of temperature on the flow and the inhibition factors (:math:`0<h<1`):

.. math::
	\dot{m}_{C,BufFruit} = h_{C_{Buf}}^{m_{C,BufOrg}} h_{T_{Can}} h_{T_{Can24}} h_{T_{CanSum}} g_{T_{Can24}} rg_{Fruit}

The carbohydrate flows from the buffer to the leaves and stem are not influenced by the instantaneous temperature and are therefore described by:

.. math::
	\dot{m}_{C,BufLeaf} = h_{C_{Buf}}^{m_{C,BufOrg}} h_{T_{Can24}} g_{T_{Can24}} rg_{Leaf}

.. math::
	\dot{m}_{C,BufStem} = h_{C_{Buf}}^{m_{C,BufOrg}} h_{T_{Can24}} g_{T_{Can24}} rg_{Stem}

The inhibition of the carbohydrate flow to the fruits, leaves or stems caused by insufficient carbohydrates in the buffer is defined by its lower limit, which is equal to 5% of the buffer's maximum capacity:

.. math::
	:nowrap:

   	\[
	h_{C_{Buf}}^{m_{C,BufOrg}} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		0,& C_{Buf} &\leq C_{Buf}^{min} \\
		1,& C_{Buf} &> C_{Buf}^{min}
	\end{array}
	\right.
	\]

Crop growth is also inhibited by non-optimal levels of the instantaneous and 24-hour mean temperature. The inhibitions coefficients for these temperatures (:math:`h_{T_{Can}}` and :math:`h_{T_{Can24}}`) can be described by two trapezoid functions (solid lines in figure below). Since the functions are non-differentiable, they have been smoothed (dotted lines in figure below) to make them suitable for dynamic simulation.

.. figure:: figures/htcan.png
	:figclass: align-center

At the first development stage of the plant, all carbohydrates are used for leaf and stem growth. The first development stage is thus a vegetative stage. When a given temperature sum is reached, the generative stage starts and the carbohydrates are divided over the fruits, leaves and stems. The fruit growth rate is assumed to start at zero and increase linearly to full potential with increasing temperature sum:

.. math::
	:nowrap:

   	\[
	h_{T_{CanSum}} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		0,& T_{Can}^{Sum} &\leq T_{Start}^{Sum} & \\
		\dfrac{T_{Can}^{Sum}}{T_{End}^{Sum}},& T_{Start}^{Sum} &< T_{Can}^{Sum} &\leq T_{End}^{Sum} \\
		1,& T_{Can}^{Sum} &> T_{End}^{Sum} & 
	\end{array}
	\right.
	\]

Since at the start of the generative stage :math:`T_{Can}^{Sum}` is zero, the temperature sum when the generative stage starts :math:`T_{Start}^{Sum}` is zero. Moreover, it is assumed that the fruit growth rate is maximal after one fruit growth period. Thus, the temperature sum when the fruit growth rate is at full potential :math:`T_{End}^{Sum}` is 1035 ºC.


The temperature effect on the growth rate coefficient is considered to be linear, as described by :cite:`koning_development_1994`:

.. math::
	g_{T_{Can24}} = 0.047 T_{Can24} + 0.060

The coefficient is 1 at 20ºC beacause the growth rate coefficients were defined at 20ºC.




The fruit flow to fruit development stages
------------------------------------------

The number of fruits in the development stages (:math:`N_{Fruit[j]}`) depend on the fruit set of the first development stage (:math:`\dot{m}_{N,BufFruit[1]}`) and the fruit flow to the remaining development stages (:math:`\dot{m}_{N,Fruit[j]Fruit[j+1]}`). The fruit set of the first development stage depends on the carbohydrate flow from the buffer to the fruits and on the maximum fruit set:

.. math::
	:nowrap:

   	\[
	\dot{m}_{N,BufFruit[1]} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		\dfrac{\dot{m}_{C,BufFruit}}{r_{BufFruit}^{max,FrtSet}} \dot{m}_{N,BufFruit[1]}^{max},& \dot{m}_{C,BufFruit} &\leq r_{BufFruit}^{max,FrtSet} \\
		\dot{m}_{N,BufFruit[1]}^{max},& \dot{m}_{C,BufFruit} &> r_{BufFruit}^{max,FrtSet}
	\end{array}
	\right.
	\]


where the maximum fruit set is depends on the plant density and the canopy temperature:

.. math::
	\dot{m}_{N,BufFruit[1]}^{max} = n_{Plants} \left( c_{BufFruit_1}^{max} + c_{BufFruit_2}^{max} T_{Can24} \right)

The fruit flow through the fruit development stages is computed based on the *fixed boxcar train mechanism* of :cite:`leffelaar_elements_1989`:

.. math::
	\dot{m}_{N,Fruit[j]Fruit[j+1]} = r_{Dev} n_{Dev} h_{T_{CanSum}}^{m_{N,Fruit}} N_{Fruit[j]}

for :math:`j=1,2...n_{Dev}`. The fruit development rate is defined by :cite:`koning_development_1994`:

.. math::
	r_{Dev} = c_{Dev_1} + c_{Dev_2} T_{Can24}

The fruit flow inhibition coefficient, used to ensure that the fruits stay in vegetative stage at the first development stage, is described by:

.. math::
	:nowrap:

   	\[
	h_{T_{CanSum}}^{m_{N,Fruit}} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		0,& T_{Can}^{Sum} &\leq T_{Start}^{Sum} \\
		1,& T_{Can}^{Sum} &> T_{Start}^{Sum}
	\end{array}
	\right.
	\]



The carbohydrate flow to fruit development stages
-------------------------------------------------

The amount of fruit carbohydrates in the development stages (:math:`C_{Fruit[j]}`) depend on the carbohydrate flow from the buffer to a development stage (:math:`\dot{m}_{C,BufFruit[j]}`) and the carbohydrate flow through the development stages (:math:`\dot{m}_{C,Fruit[j]Fruit[j+1]}`). 

The carbohydrate flow through the development stages is described by:

.. math::
	\dot{m}_{C,Fruit[j]Fruit[j+1]} = r_{Dev} n_{Dev} C_{Fruit[j]}

The carbohydrate flow to the first fruit development stage depends on the fruit set and the potential dry matter per fruit in the development stage one, as described by:

.. math::
	\dot{m}_{C,BufFruit[1]} = W_{Fruit[1]}^{POT} \dot{m}_{N,BufFruit[1]}

The carbohydrate flow from the buffer to the remaining fruit development stages, depends on the number of fruits, the fruit growth rate and the available carbohydrates for fruit growth (i.e. the total amount from the buffer minus the amount used in the first stage):

.. math::
	\dot{m}_{C,BufFruit[j]} = \eta_{BufFruit} N_{Fruit[j]} GR[j] \left( \dot{m}_{C,BufFruit} - \dot{m}_{C,BufFruit[1]} \right)

for :math:`j=2,3...n_{Dev}`, where the conversion factor :math:`\eta_{BufFruit}` is described by:

.. math::
	\eta_{BufFruit} = \dfrac{1}{\sum\limits_{j=1}^{j=n_{Dev}} N_{Fruit[j]} GR[j]}

The fruit growth rate depends on the fruit development stage and is described by :cite:`koning_development_1994`:

.. math::
	GR[j] = G^{max} e^{-e^{-B(t_{[j]}^{FGP}-M)}} B e^{-B(t_{[j]}^{FGP}-M)}

where

.. math::
	FGP = \dfrac{1}{r_{Dev} 86400}

.. math::
	M = -4.93 + 0.548 FGP

.. math::
	B = \dfrac{1}{2.44 + 0.403 M}

.. math::
	t_{[j]}^{FGP} = \dfrac{(j-1)+0.5}{n_{Dev}} FGP



Growth and maintenance respiration
----------------------------------

The growth respiration of the total plant (:math:`\dot{m}_{C,BufAir}`) is equal to the sum of the growth respiration of the fruits, leaves and stems. For the leaves, the growth respiration is defined by:

.. math::
	\dot{m}_{C,LeafAir,g} = c_{Leaf,g} \dot{m}_{C,BufLeaf}


The maintenance respiration of the leaves is described by:

.. math::
	\dot{m}_{C,LeafAir} = c_{Leaf,m} Q_{10,m}^{0.1(T_{Can24} - 25)} C_{Leaf} \left( 1-e^{-c_{RGR} RGR} \right)

The growth and maintenance respirations of the fruits and stems are described analogously to the previous equations.


Leaf pruning
------------

It is assumed that leaves are pruned if the simulated LAI exceeds the maximum allowed value. The maximum allowed amount of stored carbohydrate in the leaves is described by:

.. math::
	C_{Leaf}^{max} = \dfrac{LAI^{max}}{SLA}

The leaf harvest rate is determined by:

.. math::
	:nowrap:

   	\[
	\dot{m}_{C,LeafHar} =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		0,& C_{Leaf} &< C_{Leaf}^{max} \\
		C_{Leaf}-C_{Leaf}^{max},& C_{Leaf} &\geq C_{Leaf}^{max}
	\end{array}
	\right.
	\]



.. |CO2| replace:: CO\ :sub:`2`
.. |CH2O| replace:: CH\ :sub:`2`\O

