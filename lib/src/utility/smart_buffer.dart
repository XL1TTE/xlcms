
final class SmartBuffer<T> {

  static const int _maxCapacity = 1 << 16;

  SmartBuffer(int capacity): 
    _buffer = List.filled(capacity, null, growable: false), 
    _length = 0;
  
  List<T?> _buffer;
  int _length;
  
  int get length => _length;
  int get capacity => _buffer.length;

  void operator []=(int index, T value){
    if (index >= _buffer.length) {
      _growToFit(index);
    }

    _buffer[index] = value;

    if(index >= _length) {
      _length = ++index;
    }
  }

  T operator [](int index) {
    if (index < 0 || index >= _length) {
      throw RangeError.index(index, this);
    }

    // index is always under buffer lenght here 
    return _buffer[index]!;
  }

  void _growToFit(int targetIndex) {

    if (targetIndex < 0) {
      throw RangeError.value(targetIndex, 'targetIndex', 'Index cannot be negative');
    }

    if (targetIndex >= _maxCapacity) {
      throw StateError('Buffer overflow: target index $targetIndex exceeds maximum allowed capacity ($_maxCapacity)');
    }

    int targetCapacity = _buffer.length;

    for(; targetCapacity <= targetIndex; targetCapacity *= 2){}

    final buffer = List<T?>.filled(targetCapacity, null, growable: false);
    
    for (int i = 0; i < _buffer.length; i++) {
      buffer[i] = _buffer[i];
    }

    _buffer = buffer;
  }
}