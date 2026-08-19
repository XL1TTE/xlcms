import 'dart:typed_data';

final class BitMask {
  final Uint64List _parts;

  BitMask(int bits) : _parts = Uint64List((bits + 63) ~/ 64);

  bool operator [](int index) {
    final partIndex = index ~/ 64;
    final bitIndex = index % 64;
    return (_parts[partIndex] & (1 << bitIndex)) != 0;
  }

  void operator []=(int index, bool value) {
    final partIndex = index ~/ 64;
    final bitIndex = index % 64;
    if (value) {
      _parts[partIndex] |= (1 << bitIndex);
    } else {
      _parts[partIndex] &= ~(1 << bitIndex);
    }
  }

  bool matches({required BitMask all, required BitMask none}) {
    final length = _parts.length;
    for (var i = 0; i < length; i++) {
      final part = _parts[i];
      final allPart = all._parts[i];
      final nonePart = none._parts[i];

      if ((part & allPart) != allPart) return false;
      if ((part & nonePart) != 0) return false;
    }
    return true;
  }

  void clear() {
    _parts.fillRange(0, _parts.length, 0);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BitMask || _parts.length != other._parts.length) return false;
    for (var i = 0; i < _parts.length; i++) {
      if (_parts[i] != other._parts[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    var hash = 17;
    for (var i = 0; i < _parts.length; i++) {
      hash = 37 * hash + _parts[i].hashCode;
    }
    return hash;
  }
}
