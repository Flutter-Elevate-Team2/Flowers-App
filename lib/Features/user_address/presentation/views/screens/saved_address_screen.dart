import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/add_address_button.dart';
import 'package:flowers_app/Features/user_address/presentation/views/widgets/address_card.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for UI visualization as per the task request
    final List<AddressEntity> dummyAddresses = [
      const AddressEntity(
        id: '1',
        city: 'Cairo',
        street: '2XVP+XC - Sheikh Zayed',
        phone: '',
        lat: '',
        long: '',
        username: '',
      ),
      const AddressEntity(
        id: '2',
        city: 'Cairo',
        street: '2XVP+XC - Sheikh Zayed',
        phone: '',
        lat: '',
        long: '',
        username: '',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(AppLocalizations.of(context)!.savedAddress,style:  Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dummyAddresses.length,
                  itemBuilder: (context, index) {
                    return AddressCard(
                      address: dummyAddresses[index],
                      onDelete: () {
                        // TODO: Implement delete logic
                      },
                      onEdit: () {
                        // TODO: Implement edit logic
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              AddAddressButton(
                onPressed: () {
                  // TODO: Navigate to add address screen or show dialog
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
