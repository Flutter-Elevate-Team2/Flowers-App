import 'package:intl/intl.dart';

class PriceFormatter {
  static String formatPrice(int price , {String? locale}) {

    final isArabic = locale?.startsWith('ar') ?? false;

    final formatter = NumberFormat.currency(
      symbol: isArabic ? 'جنيه' : 'EGP',
      customPattern: '#,## ¤',
      locale: locale,
    );

    return formatter.format(price);
  }
}
