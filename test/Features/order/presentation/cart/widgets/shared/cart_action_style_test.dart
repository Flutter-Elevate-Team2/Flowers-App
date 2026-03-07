import 'package:flowers_app/Features/order/presentation/cart/widgets/shared/cart_action_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartActionStyle Implementation Tests', () {

    testWidgets('QuantitySelector should display correct quantity and trigger callbacks', (tester) async {
      // Arrange
      int currentQuantity = 5;
      bool incrementCalled = false;
      bool decrementCalled = false;
      bool deleteCalled = false;

      // هنا نستخدم الكلاس الفعلي الذي نفذت فيه الـ Interface
      final cartStyle = ModernCartStyle();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => cartStyle.buildQuantitySelector(
              context,
              quantity: currentQuantity,
              isLoading: false,
              isIncrementDisabled: false,
              isDecrementDisabled: false,
              onIncrement: () => incrementCalled = true,
              onDecrement: () => decrementCalled = true,
              onDelete: () => deleteCalled = true,
            ),
          ),
        ),
      ));

      // Assert: التحقق من ظهور الكمية الصحيحة
      expect(find.text('5'), findsOneWidget);

      // Act & Assert: اختبار زر الزيادة
      // ملاحظة: ابحث عن الزر بناءً على الأيقونة أو الـ Key الذي وضعته في التنفيذ
      await tester.tap(find.byIcon(Icons.add));
      expect(incrementCalled, isTrue);

      // Act & Assert: اختبار زر النقصان
      await tester.tap(find.byIcon(Icons.remove));
      expect(decrementCalled, isTrue);

      // Act & Assert: اختبار زر الحذف
      await tester.tap(find.byIcon(Icons.delete_outline));
      expect(deleteCalled, isTrue);
    });

    testWidgets('AddButton should show Loading indicator when isLoading is true', (tester) async {
      final cartStyle = ModernCartStyle();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => cartStyle.buildAddButton(
              context,
              isLoading: true,
              onAdd: () {},
            ),
          ),
        ),
      ));

      // التحقق من ظهور مؤشر التحميل واختفاء النص أو الزر العادي
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

 class ModernCartStyle extends CartActionStyle {
  @override
  Widget buildAddButton(context, {key, required isLoading, required onAdd}) {
    return ElevatedButton(
      onPressed: isLoading ? null : onAdd,
      child: isLoading ? const CircularProgressIndicator() : const Text('Add'),
    );
  }

  @override
  Widget buildQuantitySelector(context, {key, required quantity, required isLoading,
    required isIncrementDisabled, required isDecrementDisabled,
    onIncrement, onDecrement, onDelete}) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.delete_outline), onPressed: onDelete),
        IconButton(icon: const Icon(Icons.remove), onPressed: isDecrementDisabled ? null : onDecrement),
        Text('$quantity'),
        IconButton(icon: const Icon(Icons.add), onPressed: isIncrementDisabled ? null : onIncrement),
      ],
    );
  }

  @override
  Widget buildSoldOut(context) => const Text('Sold Out');
}