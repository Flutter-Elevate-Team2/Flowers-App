
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_view_model.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_button.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/address_card.dart';
import 'package:flowers_app/core/app_router/app_router.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SavedAddressScreen extends StatefulWidget {
  const SavedAddressScreen({super.key});

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserAddressViewModel>().doIntent(GetAddressesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          AppLocalizations.of(context)!.savedAddress,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<UserAddressViewModel, UserAddressState>(
                  listenWhen: (previous, current) {
                    return previous.deleteAddressState !=
                        current.deleteAddressState;
                  },
                  listener: (context, state) {
                    if (state.deleteAddressState?.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.deleteAddressState!.errorMessage!,
                          ),
                        ),
                      );
                    }
                    if (state.deleteAddressState?.data != null &&
                        state.deleteAddressState?.isLoading == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.l10n.addressDeletedSuccess),
                        ),
                      );
                      context.read<UserAddressViewModel>().resetDeleteState();
                    }
                  },
                  builder: (context, state) {
                    if (state.getAddressesState?.isLoading == true) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.getAddressesState?.errorMessage != null) {
                      return Center(
                        child: Text(state.getAddressesState!.errorMessage!),
                      );
                    }

                    final List<AddressEntity> addresses =
                        state.getAddressesState?.data?.addresses ?? [];

                    if (addresses.isEmpty) {
                      return Center(child: Text(context.l10n.noSavedAddresses));
                    }

                    return ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        return AddressCard(
                          address: addresses[index],
                          onDelete: () {
                            context.read<UserAddressViewModel>().doIntent(
                              DeleteAddressEvent(addresses[index].id),
                            );
                          },
                          onEdit: () {
                            context
                                .pushNamed(
                                  Routes.addAddressName,
                                  extra: addresses[index],
                                )
                                .then((_) {
                                  if (!context.mounted) return;
                                  context.read<UserAddressViewModel>().doIntent(
                                    GetAddressesEvent(),
                                  );
                                });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  return AddAddressButton(
                    onPressed: () {
                      context.pushNamed(Routes.addAddressName).then((_) {
                        if (!context.mounted) return;
                        context.read<UserAddressViewModel>().doIntent(
                          GetAddressesEvent(),
                        );
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
