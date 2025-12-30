import 'package:flowers_app/Features/products/presentation/view_model/products_view_model.dart';
import 'package:flowers_app/Features/products/presentation/widgets/sort_by.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
 final ProductsViewModel viewModel;

  const FloatingButton(this.viewModel,{super.key});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 100,
      height: 34,
      child: FloatingActionButton(
        onPressed: () async {
          final selectedSort = await showModalBottomSheet<String>(
            context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
            builder: (context) =>  SortBy( widget.viewModel,),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.filter_list_rounded),
            Text((context).l10n.filter)
          ],
        ),
      ),
    );
  }
}
