// import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_events.dart';
// import 'package:flowers_app/Features/commerce/products/presentation/view_model/products_view_model.dart';
// import 'package:flowers_app/Features/commerce/products/presentation/widgets/best_seller_body.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BestSellerPage extends StatefulWidget {
//   final List<OccasionEntity>? bestSellers;
//   const BestSellerPage({
//     // super.key,
//     this.bestSellers,
//     required this.initialIndex,
//   });

//   @override
//   State<BestSellerPage> createState() => _BestSellerPageState();
// }

// class _BestSellerPageState extends State<BestSellerPage> {
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.position.pixels;
//     if (maxScroll - currentScroll <= 200) {
//       context.read<ProductsViewModel>().doIntent(LoadMoreProductsEvent());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final tabs = widget.bestSellers?.map((e) => e.name).toList() ?? [];
//     return SafeArea(
//       child:BestSellerBody(
//           scrollController: _scrollController,
//           // bestSellers: widget.bestSellers,
//         ),
//     );
//   }
// }
