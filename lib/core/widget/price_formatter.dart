import 'package:intl/intl.dart';

class PriceFormatter {
  static String formatPrice(int price) {


    String local = Intl.getCurrentLocale();
    final isArabic = local.startsWith('ar');

    final formatter = NumberFormat.currency(
      symbol: isArabic ? 'جنيه' : 'EGP',
      customPattern: '#,## ¤',
      locale: local,
    );

    return formatter.format(price);
  }
}
