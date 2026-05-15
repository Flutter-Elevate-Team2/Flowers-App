  String relativeTimeEn(DateTime sentAt) {
    final diff = DateTime.now().difference(sentAt);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return h == 1 ? '1 hr ago' : '$h hrs ago';
    }
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 30) return '${diff.inDays} days ago';
    if (diff.inDays < 365) {
      final mo = (diff.inDays / 30).floor();
      return mo == 1 ? '1 month ago' : '$mo months ago';
    }
    final y = (diff.inDays / 365).floor();
    return y == 1 ? '1 year ago' : '$y years ago';
  }