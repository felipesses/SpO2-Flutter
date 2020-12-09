import 'dart:io';
import 'dart:math' as math;

class Concurrency {
  int nThreads = prevPow2(getNumberOfProcessors());
  int threads_begin_in_1d_fft_4threads = 65536;
  int threads_begin_n_1d_fft_2threads = 8192;

  bool isPowerOf2(int x) {
    if (x <= 0)
      return false;
    else
      return (x & (x - 1)) == 0;
  }

  int nextPow2(int x) {
    if (x < 1) throw ("x must be greater or equal 1");
    if ((x & (x - 1)) == 0) {
      return x; // x is already a power-of-two number
    }
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);
    x |= (x >> 32);
    return x + 1;
  }

  static int prevPow2(int x) {
    if (x < 1) throw ("x must be greater or equal 1");
    return math.pow(2, (math.log(x) / math.log(2))).floor().toInt();
  }

  int getNumberOfThreads() {
    return nThreads;
  }

  static int getNumberOfProcessors() {
    return Platform.numberOfProcessors;
  }

  int getThreadsBeginN1DFFT4Threads() {
    return threads_begin_in_1d_fft_4threads;
  }

  int getThreadsBeginN1DFFT2Threads() {
    return threads_begin_n_1d_fft_2threads;
  }
}
