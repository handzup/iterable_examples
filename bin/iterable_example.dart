void main(List<String> arguments) {
  final myIter = TextRuns('dasd asdsa dsad sad');

  for (var item in myIter) {
    print(item);
  }

  final ints = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  final chunks = sliceToChunks(ints, 3);
  print(chunks.toList());
}

class TextRuns extends Iterable<String> {
  final String text;
  TextRuns(this.text);

  @override
  Iterator<String> get iterator => TextRunIterator(text);
}

class TextRunIterator implements Iterator<String> {
  final String text;

  TextRunIterator(this.text);

  int _startIndex = 0;
  int _endIndex = 0;
  String? _currentText;
  @override
  String get current => _currentText as String;

  @override
  bool moveNext() {
    _startIndex = _endIndex;
    if (_startIndex == text.length) {
      _currentText = null;
      return false;
    }
    final next = text.indexOf(RegExp(' '), _startIndex);
    _endIndex = (next != -1) ? next + 1 : text.length;
    _currentText = text.substring(_startIndex, _endIndex);

    return true;
  }
}

Iterable<List<T>> sliceToChunks<T>(Iterable<T> iterable, int size) {
  return iterable.isEmpty ? [] : Slicer<T>(iterable, size);
}

class Slicer<T> extends Iterable<List<T>> {
  final Iterable<T> iterable;
  final int size;

  Slicer(this.iterable, this.size);

  @override
  Iterator<List<T>> get iterator => SliceIterator(iterable.iterator, size);
}

class SliceIterator<T> extends Iterator<List<T>> {
  final Iterator<T> iterator;
  final int size;
  List<T>? _current;
  SliceIterator(this.iterator, this.size);
  @override
  List<T> get current => _current as List<T>;

  @override
  bool moveNext() {
    final newList = <T>[];
    var count = 0;
    while (count < size && iterator.moveNext()) {
      newList.add(iterator.current);
      count++;
    }
    _current = (count < size) ? null : newList;

    return _current != null;
  }
}
