import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/business_dao.dart';
import 'package:stockmaster/data/database/local/businesss.dart';

import '../../../data/database/local/app_database.dart' show BusinessEntity;

class AdminDatabase extends StatefulWidget {
  const AdminDatabase({Key? key}) : super(key: key);

  @override
  State<AdminDatabase> createState() => _AdminDatabaseState();
}

class _AdminDatabaseState extends State<AdminDatabase> {
  BusinessEntity? _business;

  // Controladores para cada campo
  final _idbusinessCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _direccionCtrl = TextEditingController();
  final _paisCtrl = TextEditingController();
  final _ciudadCtrl = TextEditingController();
  final _latitudCtrl = TextEditingController();
  final _longitudCtrl = TextEditingController();
  final _acteconomicaCtrl = TextEditingController();
  final _celularCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBusiness();
  }

  Future<void> _loadBusiness() async {
    final dao = Provider.of<BusinessDao>(context, listen: false);
    final businesses = await dao.getAllBusiness();
    if (businesses.isNotEmpty) {
      setState(() {
        _business = businesses.first;
        _idbusinessCtrl.text = _business!.idbusiness;
        _nameCtrl.text = _business?.name ?? '';
        _websiteCtrl.text = _business?.website ?? '';
        _emailCtrl.text = _business?.email ?? '';
        _direccionCtrl.text = _business?.direccion ?? '';
        _paisCtrl.text = _business?.pais ?? '';
        _ciudadCtrl.text = _business?.ciudad ?? '';
        _latitudCtrl.text = _business?.latitud ?? '';
        _longitudCtrl.text = _business?.longitud ?? '';
        _acteconomicaCtrl.text = _business?.acteconomica ?? '';
        _celularCtrl.text = _business?.celular ?? '';
      });
    }
  }

  Future<void> _updateBusiness() async {
    if (_business == null) return;
    final dao = Provider.of<BusinessDao>(context, listen: false);

    final updated = _business!.copyWith(
      name: Value(_nameCtrl.text),
      website: Value(_websiteCtrl.text),
      email: Value(_emailCtrl.text),
      direccion: Value(_direccionCtrl.text),
      pais: Value(_paisCtrl.text),
      ciudad: Value(_ciudadCtrl.text),
      latitud: Value(_latitudCtrl.text),
      longitud: Value(_longitudCtrl.text),
      acteconomica: Value(_acteconomicaCtrl.text),
      celular: Value(_celularCtrl.text),
    );

    await dao.updateBusiness(updated);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Company updated successfully')),
    );
  }

  Future<void> _deleteBusiness() async {
    if (_business == null) return;
    final dao = Provider.of<BusinessDao>(context, listen: false);
    await dao.deleteBusiness(_business!.idbusiness);
    setState(() => _business = null);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Company deleted successfully')),
    );
  }

  @override
  void dispose() {
    _idbusinessCtrl.dispose();
    _nameCtrl.dispose();
    _websiteCtrl.dispose();
    _emailCtrl.dispose();
    _direccionCtrl.dispose();
    _paisCtrl.dispose();
    _ciudadCtrl.dispose();
    _latitudCtrl.dispose();
    _longitudCtrl.dispose();
    _acteconomicaCtrl.dispose();
    _celularCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_business == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Company Information')),
        body: const Center(child: Text('No company data found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Company Information')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildField('ID Business', _idbusinessCtrl, readOnly: true),
                _buildField('Name', _nameCtrl),
                _buildField('Website', _websiteCtrl),
                _buildField('Email', _emailCtrl),
                _buildField('Direccion', _direccionCtrl),
                _buildField('Pais', _paisCtrl),
                _buildField('Ciudad', _ciudadCtrl),
                _buildField('Latitud', _latitudCtrl),
                _buildField('Longitud', _longitudCtrl),
                _buildField('Acteconomica', _acteconomicaCtrl),
                _buildField('Celular', _celularCtrl),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _updateBusiness,
                      icon: const Icon(Icons.save),
                      label: const Text('Update'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _deleteBusiness,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
