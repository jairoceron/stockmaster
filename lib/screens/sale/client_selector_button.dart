import 'package:flutter/material.dart';
import '../../data/database/local/app_database.dart';
import '../thirdParts/single_choice_list_client_screen.dart';
import '/data/database/local/third_parts.dart';

class ClientSelectorButton extends StatelessWidget {
  final ThirdPartEntity? selectedClient;
  const ClientSelectorButton({super.key, this.selectedClient});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SingleChoiceListClientScreen()),
        );
      },
      child: Text(
        selectedClient != null
            ? 'Cliente: ${selectedClient!.name}'
            : 'Cliente (Opcional)',
      ),
    );
  }
}
