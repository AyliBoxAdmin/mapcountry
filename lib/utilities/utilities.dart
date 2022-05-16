


/// ATTENTION .floor().toDouble(); --> Empeche les Key des smoothbar de fonctionner ???
///   sliderValue = tools_range_value_double(widget.progress, widget.min, widget.max, 0, 1);
double toolsRangeValue(double x, double inMin, double inMax, double outMin, double outMax) {
  double value = ( (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin ).toDouble();
  return value;
}