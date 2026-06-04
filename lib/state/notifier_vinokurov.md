


ejemplo:
la clase XxxxNotifier extends ChangeNotifier { }
 - al invocar un método en este caso loadTodaySales() 
 - todas las clases que se subscriban a ReportNotifier les toca, 
 - son avisadas al actualizarse el método.

class ReportNotifier extends ChangeNotifier {
final TransactionService service;
double _todaySales = 0.0;

ReportNotifier(this.service);

double get todaySales => _todaySales;

Future<void> loadTodaySales() async {
_todaySales = await service.getTodaySalesReport();
notifyListeners();
}
}