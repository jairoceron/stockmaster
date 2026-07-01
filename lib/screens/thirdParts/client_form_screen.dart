import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import '/helpers/uuid_helper.dart';
import '/state/third_parts_notifier.dart';
import '/providers/third_parts_providers.dart';
import '/data/database/local/third_parts.dart';

class ClientFormScreen extends ConsumerStatefulWidget {
  final ThirdPartEntity? entity; // 👈 nuevo parámetro opcional

  const ClientFormScreen({super.key, this.entity});

  @override
  ConsumerState<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends ConsumerState<ClientFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.entity != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Editar Cliente" : "Nuevo Cliente"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          initialValue: isEditing
              ? {
            'name': widget.entity!.name,
            'email': widget.entity!.email,
            'phone': widget.entity!.phone,
            'thirdPartType': widget.entity!.thirdPartType,
            'notes': widget.entity!.notes,
          }
              : {},
          child: ListView(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: FormBuilderValidators.email(),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'phone',
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 12),
              FormBuilderDropdown(
                name: 'thirdPartType',
                decoration: const InputDecoration(
                  labelText: 'Tipo de tercero',
                  prefixIcon: Icon(Icons.category),
                ),
                items: const [
                  DropdownMenuItem(value: 'cliente', child: Text('Cliente')),
                  DropdownMenuItem(value: 'proveedor', child: Text('Proveedor')),
                  DropdownMenuItem(value: 'empleado', child: Text('Empleado')),
                  DropdownMenuItem(value: 'distribuidor', child: Text('Distribuidor')),
                ],
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'notes',
                decoration: const InputDecoration(
                  labelText: 'Notas',
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text(isEditing ? "Actualizar" : "Guardar"),
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final values = _formKey.currentState!.value;
                    final nuevo = ThirdPartEntity(
                      id: isEditing ? widget.entity!.id : generateUuid(),
                      name: values['name'],
                      email: values['email'],
                      phone: values['phone'],
                      thirdPartType: values['thirdPartType'],
                      notes: values['notes'],
                      createdAt: isEditing ? widget.entity!.createdAt : DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    if (isEditing) {
                      ref.read(thirdPartsNotifierProvider.notifier).updateThirdPart(nuevo);
                    } else {
                      ref.read(thirdPartsNotifierProvider.notifier).addThirdPart(nuevo);
                    }

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
