import 'package:flutter_test/flutter_test.dart';
import 'package:quote_lab/main.dart';

void main() {
  test('Quote defaults to 0 likes', () {
    final q = Quote(text: 'Test', author: 'Author');
    expect(q.likes, 0);
  });

  test('Quote defaults to General category', () {
    final q = Quote(text: 'Test', author: 'Author');
    expect(q.category, 'General');
  });

  test('Quote createdAt defaults to today', () {
    final before = DateTime.now();
    final q = Quote(text: 'Test', author: 'Author');
    expect(q.createdAt.isAfter(before) || q.createdAt.isAtSameMomentAs(before), true);
  });

  test('Quote accepts custom category', () {
    final q = Quote(text: 'Test', author: 'Author', category: 'Humor');
    expect(q.category, 'Humor');
  });
}