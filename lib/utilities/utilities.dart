


/// scaling
double toolsScalingValue(double x, double inMin, double inMax, double outMin, double outMax) {
  double value = ( (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin ).toDouble();
  return value;
}