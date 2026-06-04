import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:async';
import '../../data/DTO/ReportSummaryDTO.dart';
import '../../data/repositories/service/ReportService.dart';
import '../../domain/report/entities/inventory_summary_report.dart';
import '../../domain/report/repositories/report_repository.dart';

class ReportController extends ChangeNotifier {
  final ReportService service;
  ReportSummaryDTO? summary;

  ReportController(this.service) {
    _init();
  }

  Future<void> _init() async {
    await updateSummaryFromLocal();
  }

  Future<void> updateSummaryFromLocal() async {
    summary = await service.calcularResumen();
    notifyListeners();
  }
}
