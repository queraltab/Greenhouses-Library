within Greenhouses.Functions;
function transition_factor_alt
  "An alternative definition of the transition range"
  extends Greenhouses.Functions.transition_factor(start=switch - 0.5*trans,
      stop=switch + 0.5*trans);
  input Real switch = 0.5 "centre of transition interval";
  input Real trans = 0.05*switch "transition duration";

end transition_factor_alt;
