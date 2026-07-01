import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/product_lots_dao.dart';
import 'package:stockmaster/models/product_lot.dart';


class ProductLotFormScreen extends StatefulWidget {
  final ProductLot? productLot; // Constructor recibe objeto PRODUCT

  const ProductLotFormScreen({Key? key, this.productLot}) : super(key: key);

  @override
  State<ProductLotFormScreen> createState() => _ProductLotFormScreenState();
}

class _ProductLotFormScreenState extends State<ProductLotFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final dao = context.read<ProductLotsDao>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productLot == null
            ? 'Agregar Lote'
            : 'Editar Lote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              FormBuilderTextField(
                name: 'lotenumber',
                decoration: const InputDecoration(labelText: 'Número de lote'),
                validator: FormBuilderValidators.required(),
                initialValue: widget.productLot?.lotenumber,
              ),
              FormBuilderTextField(
                name: 'productid',
                decoration: const InputDecoration(labelText: 'ID Producto'),
                validator: FormBuilderValidators.required(),
                initialValue: widget.productLot?.productid,
              ),
              FormBuilderTextField(
                name: 'quantity',
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer(),
                ]),
                initialValue: widget.productLot?.quantity?.toString(),
              ),
              FormBuilderDateTimePicker(
                name: 'expirationdate',
                inputType: InputType.date,
                decoration: const InputDecoration(labelText: 'Fecha de expiración'),
                initialValue: widget.productLot?.expirationdate,
              ),
              FormBuilderDateTimePicker(
                name: 'fabricationdate',
                inputType: InputType.date,
                decoration: const InputDecoration(labelText: 'Fecha de fabricación'),
                initialValue: widget.productLot?.fabricationdate,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final values = _formKey.currentState!.value;

                    final lot = ProductLot(
                      id: widget.productLot?.id,
                      lotenumber: values['lotenumber'],
                      productid: values['productid'],
                      quantity: int.tryParse(values['quantity']),
                      expirationdate: values['expirationdate'],
                      fabricationdate: values['fabricationdate'],
                    );

                    if (widget.productLot == null) {
                      await dao.insertLot(ProductLotsCompanion.insert(
                        lotenumber: Value(lot.lotenumber),
                        productid: Value(lot.productid),
                        quantity: Value(lot.quantity),
                        expirationdate: Value(lot.expirationdate),
                        fabricationdate: Value(lot.fabricationdate),
                      ));
                    } else {
                      await dao.updateLot(ProductLotEntity(
                        id: lot.id!,
                        lotenumber: lot.lotenumber,
                        productid: lot.productid,
                        quantity: lot.quantity,
                        expirationdate: lot.expirationdate,
                        fabricationdate: lot.fabricationdate,
                      ));
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.productLot == null ? 'Guardar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
