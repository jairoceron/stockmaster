import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/state/services_form_view_model_notifier.dart';


class ServiceFormScreen extends StatefulWidget {
  const ServiceFormScreen({Key? key}) : super(key: key);

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceFormViewModelNotifier>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Agregar Servicio"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(
                        labelText: 'Nombre del servicio',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(3),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'description',
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'price',
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.min(0),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'durationMinutes',
                      decoration: const InputDecoration(
                        labelText: 'Duración (minutos)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.min(1),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    FormBuilderTextField(
                      name: 'professional',
                      decoration: const InputDecoration(
                        labelText: 'Profesional asignado',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.save),
                          label: const Text("Guardar"),
                          onPressed: () async {
                            if (_formKey.currentState?.saveAndValidate() ?? false) {
                              final data = _formKey.currentState!.value;
                              final service = await viewModel.saveService(data);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Servicio guardado correctamente")),
                              );
                              Navigator.pop(context, service); // 👈 devuelve el servicio al listado
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Errores de validación")),
                              );
                            }
                          },
                        ),

                        OutlinedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text("Actualizar"),
                          onPressed: () {
                            if (_formKey.currentState?.saveAndValidate() ?? false) {
                              final data = _formKey.currentState!.value;
                              // Aquí podrías llamar a viewModel.updateService(data)
                              debugPrint("Servicio actualizado: $data");
                            }
                          },
                        ),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text("Eliminar"),
                          onPressed: () {
                            // Aquí podrías llamar a viewModel.deleteService(id)
                            debugPrint("Servicio eliminado");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
