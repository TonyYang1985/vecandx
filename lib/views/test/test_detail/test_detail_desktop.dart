part of test_detail_view;

final formatter = DateFormat(dd_MM_yyyy);

class _TestDetailDesktop extends StatefulWidget {
  final TestDetailViewModel viewModel;

  _TestDetailDesktop(this.viewModel);

  @override
  _TestDetailDesktopState createState() => _TestDetailDesktopState();
}

class _TestDetailDesktopState extends State<_TestDetailDesktop> {
  final dateFormat = DateFormat(yyyyMMddnnss);

  Widget buildInfoListTile({@required String label, String value, Widget child}) {
    return ListTile(
      dense: true,
      title: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          child ?? Text(value ?? 'N/A', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget buildHeaderListTile({@required String label}) {
    return ListTile(
      tileColor: Colors.grey[300],
      title: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  String _getRoundedValue(double value) {
    if (value == null) return '';
    return value.toStringAsFixed(2);
  }

  Widget buildDetail() {
    final model = widget.viewModel.patientTest;
    final biomarker = widget.viewModel.patientTest.biomarker;
    final age = DateTimeUtil.getAge(model.patient.dateOfBirth);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.picture_as_pdf_sharp),
                onPressed: () => widget.viewModel.downLoadTestReport(),
                tooltip: 'Download PDF Report',
              ),
              IconButton(
                icon: Icon(Icons.print),
                onPressed: () => widget.viewModel.printTestReport(),
                tooltip: 'Print Report',
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      buildHeaderListTile(label: 'Patient Info'),
                      buildInfoListTile(
                        label: 'Patient ID',
                        value: model.patient.identifier,
                      ),
                      buildInfoListTile(
                        label: 'Smoking Status',
                        value: smokingStatusMap[model.patient.smokingStatus],
                      ),
                      buildInfoListTile(
                        label: 'Date of Birth',
                        value: model.patient.dateOfBirth != null ? formatter.format(model.patient.dateOfBirth) : null,
                      ),
                      buildInfoListTile(
                        label: 'Age',
                        value: '${age ?? 'N/A'} ${age != null ? 'Years' : ''}',
                      ),
                      buildInfoListTile(
                        label: 'Gender',
                        value: model.patient.gender,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      buildHeaderListTile(label: 'Biomarker'),
                      buildInfoListTile(
                        label: 'Concentration A',
                        value: biomarker.concentrationA.toStringAsFixed(2),
                      ),
                      buildInfoListTile(
                        label: 'Concentration A QC1',
                        value: _getRoundedValue(biomarker.biomarkerAQc1PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration A QC2',
                        value: _getRoundedValue(biomarker.biomarkerAQc2PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration C',
                        value: biomarker.concentrationC.toStringAsFixed(2),
                      ),
                      buildInfoListTile(
                        label: 'Concentration C QC1',
                        value: _getRoundedValue(biomarker.biomarkerCQc1PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration C QC2',
                        value: _getRoundedValue(biomarker.biomarkerCQc2PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration G',
                        value: biomarker.concentrationG.toStringAsFixed(2),
                      ),
                      buildInfoListTile(
                        label: 'Concentration G QC1',
                        value: _getRoundedValue(biomarker.biomarkerGQc1PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration G QC2',
                        value: _getRoundedValue(biomarker.biomarkerGQc2PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration P',
                        value: biomarker.concentrationP.toStringAsFixed(2),
                      ),
                      buildInfoListTile(
                        label: 'Concentration P QC1',
                        value: _getRoundedValue(biomarker.biomarkerPQc1PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration P QC2',
                        value: _getRoundedValue(biomarker.biomarkerPQc2PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration S',
                        value: biomarker.concentrationS.toStringAsFixed(2),
                      ),
                      buildInfoListTile(
                        label: 'Concentration S QC1',
                        value: _getRoundedValue(biomarker.biomarkerSQc1PgMl),
                      ),
                      buildInfoListTile(
                        label: 'Concentration S QC2',
                        value: _getRoundedValue(biomarker.biomarkerSQc2PgMl),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      buildHeaderListTile(label: 'Test'),
                      buildInfoListTile(
                        label: 'Sample No.',
                        value: model.test.sampleNumber,
                      ),
                      buildInfoListTile(
                        label: 'Sample Collection Date',
                        value: formatter.format(model.test.sampleCollectionDate),
                      ),
                      buildInfoListTile(
                        label: 'ELISA Kit Lot No.',
                        value: model.test.elisaKitLotNumber,
                      ),
                      buildInfoListTile(
                        label: 'Doctor Name',
                        value: model.test.doctorName,
                      ),
                      buildInfoListTile(
                        label: 'Department/Clinic',
                        value: model.test.departmentOrClinic,
                      ),
                      buildInfoListTile(
                        label: 'Risk Score',
                        child: Chip(
                          label: Text(model.test.riskScore.toStringAsFixed(2)),
                          backgroundColor: model.test.riskScore > CoreData.cutOffValue ? Colors.red : null,
                          labelStyle: TextStyle(
                            color: model.test.riskScore > CoreData.cutOffValue ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      buildInfoListTile(
                        label: 'Status',
                        child: Chip(
                          label: Text(model.test.isSubmitted ? 'Submitted' : 'In Progress'),
                          backgroundColor: model.test.isSubmitted ? Colors.green : null,
                          labelStyle: TextStyle(
                            color: model.test.isSubmitted ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      buildInfoListTile(
                        label: 'Invalid Status',
                        child: Chip(
                          label: Text(model.test.isInvalid ? 'Invalid' : 'Valid'),
                          backgroundColor: model.test.isInvalid ? Colors.red : null,
                          labelStyle: TextStyle(
                            color: model.test.isInvalid ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      buildInfoListTile(
                        label: 'Date of Test',
                        value: formatter.format(model.test.dateOfTest),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget buildText({@required String text, PdfColor color, bool centered = false}) {
    return pw.Padding(
      child: pw.Text(
        text,
        style: pw.TextStyle(fontSize: 10, color: color),
        textAlign: centered ? pw.TextAlign.center : null,
      ),
      padding: const pw.EdgeInsets.symmetric(vertical: 2, horizontal: 5),
    );
  }

  pw.Row buildHeader({@required String text}) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Container(
            alignment: pw.Alignment.center,
            color: PdfColor.fromInt(0xff365f91),
            child: buildText(text: text, color: PdfColors.white),
          ),
        )
      ],
      mainAxisAlignment: pw.MainAxisAlignment.center,
    );
  }

  pw.Widget buildLogo(ByteData imageBytes) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.ClipRect(
          child: pw.Container(
            width: 80,
            height: 80,
            child: pw.Image(
              pw.MemoryImage(imageBytes.buffer.asUint8List()),
              // width: 80,
              // height: 80,
            ),
          ),
        )
      ],
    );
  }

  pw.Widget buildTitle() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Text(
          'VECanDx ELISA Test Report',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        )
      ],
    );
  }

  pw.Widget buildPatientInfo(PatientTest model) {
    final model = widget.viewModel.patientTest;
    final patient = model.patient;
    final test = model.test;
    final age = DateTimeUtil.getAge(patient.dateOfBirth);

    return pw.Table(
      border: pw.TableBorder.all(width: 0.5, color: PdfColor.fromInt(0xff010101)),
      children: [
        pw.TableRow(
          children: [
            buildText(text: 'Patient ID'),
            buildText(text: patient.identifier),
            buildText(text: 'Doctor'),
            buildText(text: test.doctorName),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'DOB'),
            buildText(
              text: patient.dateOfBirth != null ? formatter.format(patient.dateOfBirth) : null,
            ),
            buildText(text: 'Department/Clinic'),
            buildText(text: test.departmentOrClinic),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'Age'),
            buildText(text: '${age ?? 'N/A'} ${age != null ? 'Years' : ''}'),
            buildText(text: 'Institution'),
            buildText(text: null),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'Gender'),
            buildText(text: patient.gender),
            buildText(text: 'Smoking Status'),
            buildText(text: smokingStatusMap[model.patient.smokingStatus]),
          ],
        ),
      ],
    );
  }

  pw.Widget buildTestDescription(PatientTest model) {
    final test = widget.viewModel.patientTest.test;
    return pw.Table(
      columnWidths: {0: pw.FixedColumnWidth(40)},
      border: pw.TableBorder.all(width: 0.5, color: PdfColor.fromInt(0xff010101)),
      children: [
        pw.TableRow(
          children: [
            buildText(text: 'Sample ID'),
            buildText(text: test.sampleNumber),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'Collection Date'),
            buildText(text: formatter.format(test.sampleCollectionDate)),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'Test Date'),
            buildText(text: formatter.format(test.dateOfTest)),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'ELISA Kit Lot number'),
            buildText(text: test.elisaKitLotNumber),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'ELISA Kit Lot expiry date'),
            buildText(text: null),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'Remarks'),
            buildText(text: null),
          ],
        ),
      ],
    );
  }

  pw.Widget buildTestResults(PatientTest model) {
    final biomarker = widget.viewModel.patientTest.biomarker;
    return pw.Table(
      columnWidths: {0: pw.FixedColumnWidth(50)},
      border: pw.TableBorder.all(width: 0.5, color: PdfColor.fromInt(0xff010101)),
      children: [
        pw.TableRow(
          children: [
            buildText(text: null),
            buildText(text: 'Biomarker A', centered: true),
            buildText(text: 'Biomarker C', centered: true),
            buildText(text: 'Biomarker G', centered: true),
            buildText(text: 'Biomarker P', centered: true),
            buildText(text: 'Biomarker S', centered: true),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'Result (pg/mL)'),
            buildText(text: biomarker.concentrationA.toString(), centered: true),
            buildText(text: biomarker.concentrationC.toString(), centered: true),
            buildText(text: biomarker.concentrationG.toString(), centered: true),
            buildText(text: biomarker.concentrationP.toString(), centered: true),
            buildText(text: biomarker.concentrationS.toString(), centered: true),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'QC1 (pg/mL)'),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'QC2 (pg/mL)'),
          ],
        ),
      ],
    );
  }

  pw.Widget buildInterpretation(PatientTest model) {
    final test = widget.viewModel.patientTest.test;
    final hasRisk = test.riskScore > CoreData.cutOffValue;
    return pw.Table(
      columnWidths: {
        0: pw.FixedColumnWidth(80),
        1: pw.FixedColumnWidth(80),
      },
      border: pw.TableBorder.all(width: 0.5, color: PdfColor.fromInt(0xff010101)),
      children: [
        pw.TableRow(
          children: [
            buildText(text: 'Risk Score'),
            buildText(
              text: '${test.riskScore.toStringAsFixed(2)}${hasRisk ? '*' : ''}',
              color: hasRisk ? PdfColors.red : null,
            ),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'Range'),
            buildText(text: 'CoreData.cutOffValue* - 1.08*', color: PdfColors.red),
            buildText(text: 'High risk for bladder cancer. Standard cystoscopy examination is recommended.'),
          ],
        ),
        pw.TableRow(
          children: [
            buildText(text: 'Range'),
            buildText(text: '0 - 0.64', color: PdfColors.green),
            buildText(text: 'Low risk for bladder cancer.'),
          ],
        ),
      ],
    );
  }

  pw.Widget buildPerformedBy() {
    final textStyle = pw.TextStyle(fontSize: 10);
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Performed by: ___________________________', style: textStyle),
        pw.Text('Date: ', style: textStyle),
      ],
    );
  }

  pw.Widget buildPdfDetail() {
    final model = widget.viewModel.patientTest;
    return pw.Column(
      children: [
        pw.Container(
          margin: const pw.EdgeInsets.all(10),
          child: pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      margin: const pw.EdgeInsets.symmetric(horizontal: 5),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          buildTitle(),
                          pw.SizedBox(height: 15),
                          buildHeader(text: 'Patient Information'),
                          buildPatientInfo(model),
                          pw.SizedBox(height: 25),
                          buildHeader(text: 'Test Description'),
                          buildTestDescription(model),
                          pw.SizedBox(height: 25),
                          buildHeader(text: 'Test Results'),
                          buildTestResults(model),
                          pw.SizedBox(height: 25),
                          buildHeader(text: 'Interpretation'),
                          buildInterpretation(model),
                          pw.SizedBox(height: 60),
                          buildPerformedBy(),
                          pw.SizedBox(height: 60),
                          buildPerformedBy()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget buildInfoLinePdf({@required String label, String value, pw.Widget child}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(2),
      child: pw.Row(
        children: [
          pw.Text('$label: ', style: pw.TextStyle(fontSize: 11)),
          child ?? pw.Text(value ?? 'N/A', style: pw.TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  pw.Widget buildHeaderLinePdf({@required String label}) {
    return pw.Container(
      color: PdfColors.grey100,
      padding: const pw.EdgeInsets.all(2),
      child: pw.Text(
        label,
        textAlign: pw.TextAlign.left,
        style: pw.TextStyle(fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: buildDetail(),
      ),
    );
  }
}
