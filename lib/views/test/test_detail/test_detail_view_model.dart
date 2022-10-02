import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

import '../models/patient_test.dart';
import '../services/test_service.dart';
import '../../../core/locator.dart';
import '../../../core/constants/date_format_constant.dart';
import '../../../core/base/base_view_model.dart';

class TestDetailViewModel extends BaseViewModel {
  PatientTest _patientTest;
  final testService = locator<TestService>();

  // final dateFormat = DateFormat(yyyyMMddnnss);
  final dateFormat = DateFormat(yyyyMMdd);

  void initialise(PatientTest patientTest) {
    _patientTest = patientTest;
    notifyListeners();
  }

  PatientTest get patientTest => _patientTest;
  set patientTest(PatientTest value) {
    _patientTest = value;
    notifyListeners();
  }

  String getFileName() {
    final fileName = '${dateFormat.format(DateTime.now())}-${patientTest.test.id.toString().padLeft(7, '0')}.pdf';
    return fileName;
  }

  Future<void> downLoadTestReport() async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = getFileName();
    final downloadPath = path.join(directory.path, fileName);
    await testService.downloadPatientTestReport(patientTest.test.id, downloadPath).then((downloaded) {
      if (downloaded) {
        navigatorService.showSucessMessage(message: 'Test report: $fileName downloaded to Documents folder');
      }
    });
  }

  Future<void> printTestReport() async {
    var data = await testService.getPatientTestReport(patientTest.test.id);
    if (data != null) {
      await Printing.layoutPdf(
        format: PdfPageFormat.a4,
        name: getFileName(),
        onLayout: (PdfPageFormat format) async => data,
      );
    }
  }
}
