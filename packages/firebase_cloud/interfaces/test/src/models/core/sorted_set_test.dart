import 'package:firebase_cloud_interfaces/firebase_cloud_interfaces.dart';
import 'package:test/test.dart';

void main() {
  group('SortedSet', () {
    late SortedSet sortedSet;
    setUp(() {
      sortedSet = SortedSet<dynamic>();
    });

    group('add', () {
      test('when item doesnt exist then return true', () {
        expect(sortedSet.add(1), isTrue);
      });
      test('when item already exists then return false', () {
        sortedSet.add(1);
        expect(sortedSet.add(1), isFalse);
      });
    });

    group('addOrReplace', () {
      setUp(() {
        sortedSet.add(1);
      });

      test('add new item to the list', () {
        sortedSet.addOrReplace(2);
        expect(sortedSet.items, [1, 2]);
        sortedSet.addOrReplace(0);
        expect(sortedSet.items, [0, 1, 2]);
      });
      test('replace existing item', () {
        sortedSet.addOrReplace(2);
        expect(sortedSet.items, [1, 2]);
        sortedSet.addOrReplace(2);
        expect(sortedSet.items, [1, 2]);
      });
    });

    group('removeAtIndex', () {
      setUp(() {
        sortedSet..add(1)..add(0)..add(2);
      });

      test('remove item at index 0', () {
        expect(sortedSet.removeAtIndex(0), 0);
        expect(sortedSet.items, [1, 2]);
      });
    });
    group('remove', () {
      setUp(() {
        sortedSet..add(1)..add(0)..add(2);
      });

      test('remove item 2', () {
        expect(sortedSet.remove(2), isTrue);
        expect(sortedSet.items, [0, 1]);
      });
    });
    group('clear', () {
      setUp(() {
        sortedSet..add(1)..add(0)..add(2);
      });

      test('remove item 2', () {
        sortedSet.clear();
        expect(sortedSet.items, <List<dynamic>>[]);
      });
    });

    test('when get item at index 1 return 1', () {
      sortedSet..add(1)..add(0)..add(2);
      expect(sortedSet[1], 1);
    });
    test('when requested length return 3', () {
      sortedSet..add(1)..add(0)..add(2);
      expect(sortedSet.length, 3);
    });

    group('iterator - _SortedSetIterator', () {
      group('current', () {
        setUp(() {
          sortedSet..add(1)..add(0)..add(2);
        });
        test('when iterated and requsted current return item at index 0', () {
          expect(sortedSet.iterator.current, 0);
        });

        group('moveNext', () {
          setUp(() {
            sortedSet..add(1)..add(0)..add(2);
          });
          test('when iterated and requsted current return item at index 0', () {
            final iterator = sortedSet.iterator;
            expect(iterator.current, 0);
            expect(iterator.moveNext(), isTrue);
            expect(iterator.current, 1);
          });
        });
      });
    });
  });
}
