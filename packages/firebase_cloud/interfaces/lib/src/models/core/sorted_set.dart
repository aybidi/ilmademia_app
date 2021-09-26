import 'dart:collection';

class _SortedSetIterator<E> extends Iterator<E> {
  _SortedSetIterator(SortedSet<E> sortedSet, {int startAt = 0})
      : _sortedSet = sortedSet,
        _currentIndex = startAt {
    // This implementation of set results in stack overflow
    // if 'isEmpty' is used.
    // ignore: prefer_is_empty
    if (_sortedSet.length > 0) {
      _current = _sortedSet[_currentIndex];
    }
  }

  E? _current;
  int _currentIndex;
  final SortedSet<E> _sortedSet;

  @override
  E get current {
    return _current!;
  }

  @override
  bool moveNext() {
    if ((_currentIndex + 1) > _sortedSet.length) {
      return false;
    }

    /// FIXED: previously the increment was done
    /// after the [_current] was initialized
    _currentIndex++;
    _current = _sortedSet[_currentIndex];
    return true;
  }
}

/// {@template}
/// Sorted set
/// {@endtemplate}
class SortedSet<E> extends Object with IterableMixin<E> {
  /// {@macro}
  // ignore: prefer_initializing_formals
  SortedSet([int Function(E item1, E item2)? compare]) : comparator = compare;

  /// Comparator
  final Comparator<E>? comparator;

  /// items list
  List<E> items = <E>[];

  /// Add item
  bool add(E item) {
    if (items.contains(item)) {
      return false;
    }
    items
      ..add(item)
      ..sort(comparator);
    return true;
  }

  /// Add and remove if item already exists
  void addOrReplace(E item) {
    if (items.contains(item)) {
      items.remove(item);
    }
    items
      ..add(item)
      ..sort(comparator);
  }

  /// Remove item at index
  E removeAtIndex(int index) {
    return items.removeAt(index);
  }

  /// Remove item
  bool remove(E item) {
    return items.remove(item);
  }

  /// Clear list
  void clear() {
    items.clear();
  }

  /// Operater at index
  E operator [](int i) => items[i];

  @override
  int get length => items.length;

  @override
  Iterator<E> get iterator => _SortedSetIterator<E>(this);
}
