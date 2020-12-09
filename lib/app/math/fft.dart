import 'DoubleFft1d.dart';

class FFT {
  double fft(List<double> by, int size, double samplingFrequency) {
    double temp = 0.0;
    var pomp = 0;
    double frequency;

    List<double> output = new List<double>(2 * size);

    // List<double> output = new List<double>();

    for (int i = 0; i < output.length; i++) output[i] = 0;

    for (int x = 0; x < size; x++) {
      output[x] = by[x];
    }

    DoubleFFt1d fft = new DoubleFFt1d(size);
    fft.realForward(output, 0);

    for (int x = 0; x < 2 * size; x++) {
      output[x] = output[x].abs();
    }

    for (int p = 35; p < size; p++) {
      if (temp < output[p]) {
        temp = output[p];
        pomp = p;
      }
    }

    if (pomp < 35) {
      pomp = 0;
    }

    if (pomp == 0) {
      frequency = 0.0 * samplingFrequency / (2 * size);
      return frequency;
    }

    frequency = pomp * samplingFrequency / (2 * size);
    return frequency;
  }
}
