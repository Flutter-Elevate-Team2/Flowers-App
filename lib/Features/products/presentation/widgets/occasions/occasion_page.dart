import 'package:flowers_app/Features/home/domain/entities/home_entities/occasion_entity.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_events.dart';
import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/occasions/occasion_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionPage extends StatefulWidget {
  final List<OccasionEntity>? occasions;
  final int initialIndex;
  const OccasionPage({super.key, this.occasions, required this.initialIndex});

  @override
  State<OccasionPage> createState() => _OccasionPageState();
}

class _OccasionPageState extends State<OccasionPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      context.read<ProductsViewModel>().doIntent(LoadMoreProductsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = widget.occasions?.map((e) => e.name).toList() ?? [];
    return SafeArea(
      child: DefaultTabController(
        initialIndex: widget.initialIndex,
        length: tabs.length,
        child: OccasionBody(
          tabs: tabs,
          scrollController: _scrollController,
          occasions: widget.occasions,
        ),
      ),
    );
  }
}
