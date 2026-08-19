import 'package:test/test.dart';
import 'package:xlcms/src/structs/bit_mask.dart';

void main() {
  group('BitMask tests', () {
    test('Default mask has all bits set to false', () {
      final mask = BitMask(128);
      for (var i = 0; i < 128; i++) {
        expect(mask[i], false);
      }
    });

    test('Set and get bits works for low and high parts', () {
      final mask = BitMask(128);
      mask[5] = true;
      mask[70] = true;

      expect(mask[5], true);
      expect(mask[70], true);
      expect(mask[6], false);
      expect(mask[69], false);

      mask[5] = false;
      expect(mask[5], false);
    });

    test('Matches works correctly with all and none requirements', () {
      final mask = BitMask(128);
      mask[10] = true;
      mask[80] = true;

      final allReq = BitMask(128);
      allReq[10] = true;

      final noneReq = BitMask(128);
      noneReq[50] = true;

      expect(mask.matches(all: allReq, none: noneReq), true);

      allReq[20] = true;
      expect(mask.matches(all: allReq, none: noneReq), false);

      allReq[20] = false;
      noneReq[80] = true;
      expect(mask.matches(all: allReq, none: noneReq), false);
    });

    test('Clear resets all bits', () {
      final mask = BitMask(128);
      mask[5] = true;
      mask[100] = true;

      mask.clear();

      for (var i = 0; i < 128; i++) {
        expect(mask[i], false);
      }
    });

    test('Equality and hashCode work correctly', () {
      final mask1 = BitMask(128);
      final mask2 = BitMask(128);

      expect(mask1 == mask2, true);
      expect(mask1.hashCode == mask2.hashCode, true);

      mask1[50] = true;
      expect(mask1 == mask2, false);

      mask2[50] = true;
      expect(mask1 == mask2, true);
      expect(mask1.hashCode == mask2.hashCode, true);
    });
  });
}
