import 'package:test/test.dart';
import 'package:xlcms/src/utility/extensions/int_extensions.dart';
import 'package:xlcms/src/utility/smart_buffer.dart';

void main() {
  group('SmartBuffer tests', () {
    
    late SmartBuffer buffer;

    setUp(() {
      buffer = SmartBuffer<int>(32);
    });

    test('Buffer throws index error on zero index access when empty', () {
      expect(() => buffer[0], throwsRangeError);
    });

    test('Buffer can accept elements at any index under buffer capacity withour growing', () {
      
      int initialCapacity = buffer.capacity;
      
      buffer.capacity.times((index) {
        buffer[index] = 21;
      });

      expect(buffer.capacity, initialCapacity);
    });

    test('Buffer capacity growing x2 after adding element at index equals to capacity', () {

      int initialCapacity = buffer.capacity;

      buffer[buffer.capacity] = 21;      

      expect(buffer.capacity, initialCapacity * 2);
    });

    test('Buffer capacity growing x4 after adding element at index equals to capacity * 2', () {

      int initialCapacity = buffer.capacity;

      buffer[buffer.capacity * 2] = 21;      

      expect(buffer.capacity, initialCapacity * 4);
    });

    test('Buffer throws state error when trying to outrich max capacity', () {
      expect(() => buffer[buffer.maxCapacity] = 21, throwsStateError);
    });

  });
}
