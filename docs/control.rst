.. _control:

Control Systems
===============

Greenhouses have high requirements on indoor climate control. The climate controller adjusts
heating, ventilation and |CO2| supply to attain the desired climate. In this work, several control
systems are developed, based on the control strategies proposed in the literature. In the library, depending on the nature of the strategies, two implementation approaches are distinguished: 

- State graphs: using the *StateGraph* package from the Modelica Standard Library, and 
- Proportional-integral-derivative (PID) controllers: using an ISA PID controller with anti-windup (*PID* model in the *ControlSystems* package of the Greenhouses Lirary), adapted from :cite:`quoilin_thermocycle:_2014`).

The presented control strategies have been tested in :cite:`altes-buch_modeling_2018-1`, where  several climate simulation results are presented and compared for three different cases.


Set-points definition
---------------------

The determination of set-points is at the top of the functionality of the climate controller.
Temperature set-points differ from day-time to night-time and are sometimes adapted to the
level of radiation. |CO2| is supplied during daylight to enhance photosynthesis. As measured in
xx Nilsen et al., 1983, different combinations of |CO2| concentration and air temperature lead to
different photosynthesis rates. Although a sharp reduction in photosynthesis is measured at
non-optimal temperatures, similar values are measured for close-to-optimal temperatures (i.e.
optimal temperature ±5ºC). Therefore, temperature and |CO2| set-points can be optimized not
only in terms of crop growth but also in terms of energy use. In fact, the definition of
temperature set-points for optimal crop growth and energy use has been the subject of a
substantial literature (e.g. :cite:`elings_multiple-day_2006`; :cite:`aaslyng_intelligrow:_2003`; :cite:`dieleman_energy_2006`;
:cite:`dieleman_optimisation_2005`). However, since this work does not focus on climate set-points
optimization, no innovative control is proposed. Instead, the strategy proposed in :cite:`aaslyng_intelligrow:_2003` is implemented in *Python* and the set-points are inputted as a time-series “.txt” file in
the model. This strategy consists in minimizing energy consumption while maintaining a crop
growth close to the maximal growth rate by:

* computing a 2-D array of photosynthesis rates for a range of |CO2| and temperature values at a given PAR,
* selecting the pairs of |CO2| and temperature that ensure at least 80% of the photosynthesis rate (being 100% the maximum value of the 2-D array), and
* defining the temperature and |CO2| set-point (:math:`T_{Air,SP}` and :math:`CO2_{Air,SP,th}`) as the pair in the previous selection with the lowest temperature.

In this work, a PI controller is responsible for adjusting the heating power output by varying
the mass flow rate of the heating pipes according to the difference between the air temperature
set-point and the actual value. The control strategy for |CO2| is based on a maximal supply rate,
defined by the capacity of the |CO2| enrichment system. This capacity is function of the |CO2|
source, which is commonly a combination of fossil fuel combustion gases and |CO2| stored in
liquid phase. While respecting the enrichment capacity, the supply rate is adapted to attain the
|CO2| set-point. However, in high ventilation conditions, |CO2| enrichment is commonly reduced
due to the high exchange rate to the outside air. To take this into account, the theoretical |CO2|
set-point proposed by the control strategy is modified so that it decreases proportionally with
the increase in the ventilation rate. This is done as defined by:

.. math::
	CO2_{Air,SP} = f(u_{vent}) \cdot \left( CO2_{Air,SP,th} - CO2_{Ext}^{Min} \right) + CO2_{Ext}^{Min}

where

.. math::
	:nowrap:

   	\[
	f(u_{vent}) =
	\left\{
	\begin{array}{
		@{}% no padding
		l@{\quad}% some padding
		r@{}% no padding
		>{{}}r@{}% no padding
		>{{}}l@{}% no padding
	}
		1- \dfrac{u_{vent}}{u_{vent}^{Max}},& u_{vent} &< u_{vent}^{Max} \\
		0,& u_{vent} &\geq u_{vent}^{Max}
	\end{array}
	\right.
	\] 


Supplementary lighting
----------------------

The most popular lamp type for commercial supplementary lighting in horticulture is high
pressure sodium (HPS) lamps. HPS lamps are the most efficient in the PAR spectrum range,
with an emission highly concentrated between 500 and 650 nm. HPS lighting is not designed
for frequent cycling because it dramatically reduces lamp lifespan. Thus, regardless of the
control method, it is best to set up constraints to operate lighting for extended periods. The
implemented control strategy for the lighting is based on the following:

* *Lighting window*: allow lights to be turned on between :math:`h_{illu,ON}^{min}` and :math:`h_{illu,ON}^{max}` (e.g. 5 AM and 10 PM).
* *Lighting set-point*: allow lights to be turned on during the lighting window if light levels decrease below :math:`I_{illu,ON}` (e.g. 40 Wm-2) and to be turned off when light levels increase above :math:`I_{illu,OFF}` (e.g. 120 Wm-2).
* *Light accumulation*: turn off lights or do not allow turning them on if the daily accumulated light exceeds :math:`I_{acc}^{max}` (e.g. 5 kWh).
* *Proving time*: light levels must be below the set-point for at least :math:`t_{illu,proving}` (e.g. 30 minutes).
* *Minimum on time*: to prevent cycling, lights must remain on for minimum :math:`t_{illu,ON}^{min}` (e.g. 2 hours) once they are turned on, regardless of other conditions.

The strategy sets up a time window for lighting, during which a lighting set-point condition is
applied. The proving time and minimum on time strategies are implemented to prevent
cycling.


Windows aperture
----------------

Windows in the greenhouse can be opened either for dehumidification or for cooling the
greenhouse. Excessive humidity can cause fungal diseases or physiological disorders :cite:`grange_review_1987`.
Humidity in greenhouses is controlled by means of a strategy related to a
constraint rather than a specific set-point. The constraint is based on
allowing a maximum value of relative humidity in the air, commonly set at 85%. The most
common technique for dehumidification is the combination of ventilation and heating.
Although this technique is energy consuming and thus expensive, dehumidifying systems
based on refrigerant cycles, e.g. heat pumps, have not proved to be economically feasible
:cite:`urban_production_2010`. Windows are also used for cooling the air in the case of excessive
temperatures, since they have a negative impact on the harvest rate. For example, in
:cite:`vanthoor_methodology_2011_crop` the harvest rate at daylight temperatures of 40ºC was 54.5% of that at 25ºC.
Moreover, temperatures above 25ºC can penalize fruit quality e.g. size and color :cite:`urban_production_2010`. In this work, a proportional (P) controller is used to select the opening of the windows according to the following:

* *Air sanitation*: A maximum value :math:`RH_{vent,ON}` is allowed for humidity.
* *Air cooling*: A maximum value :math:`T_{vent,ON}` is allowed for air temperature.


Thermal screen closure
----------------------

As previously mentioned, thermal losses to the outside can be reduced from 38% to 60% by
using a thermal screen :cite:`bailey_control_1988`. This capability of reducing thermal losses is defined by
the screen material, which is selected according to the climate of the region. In fact,
depending on the nature of the screen, the light transmission coefficient can vary from 15% to
88%. Thus, when drawn, the screen reduces considerably the transmitted light above the
canopy. The most conventional method to operate the screen is therefore to deploy it at
sunset, when heating demand becomes significant, and remove it at sunrise, to profit from the
available sun light. The removal of the screen must be operated progressively to avoid a
thermal shock. A way of further reducing energy consumption is to deploy the screen before
sunset or to delay the removal until after sunrise. However, this implies a loss of crop
production caused by a reduction on the available light. A good approach would be to study
the threshold between energy saving and production loss in order to define the optimal
deployment and removing times. However, estimating the reduction of plant growth is a
complex task that, although it has been the object of some studies (e.g. :cite:`aaslyng_intelligrow:_2003`;
:cite:`bailey_control_1988`), it commonly has many uncertainties and thereby requires many assumptions. A
simpler approach is to define the deployment of the screen in function of the outside
irradiation. In fact, the photosynthetic activity of the plant achieves its maximal potential
about one hour after sunrise and diminishes just before sunset :cite:`grisey_serres_2007`. In
Dutch-conditions, deploying the screen after 50 Wm-2 (instead of 5 Wm-2 usually practiced)
allows to decrease energy consumption by an extra 3% without penalizing crop growth
:cite:`dieleman_energy_2006-1`. Depending on the night, a small temporary opening of the
screen may be necessary to regulate humidity or temperature. As defined by the ventilation rate through the screen xx ,
screen gaps increase the air exchange between the main and top air zones and therefore
decrease temperature and humidity.

In this work, the developed screen control strategy is based on the following:

* *Opening/closing set-point*: the screen is opened (closed) if irradiation increases (decreases) above (below) a certain value :math:`I_{Scr,ON}` (:math:`I_{Scr,OFF}`) (e.g. 35 Wm-2).
* *Opening/closing time*: the screen is opened progressively by 1% per minute (with an interval pause of 3 minutes) followed by a full opening after 30%. This approach has proven not to generate cold air flows on top of the canopy :cite:`grisey_serres_2007`. The opening percentage and pause time is adapted to the outside weather. The time to fully open the screen is about 45 min to 60 min in cold days and 30 min in mild days.
* *Humidity gap*: the screen is opened in steps of 1% (with an interval of 3 min) up to a maximum of 4% if relative humidity exceeds its set-point, as recommended in :cite:`dieleman_energy_2006-1`.



.. |CO2| replace:: CO\ :sub:`2`

