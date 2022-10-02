part of test_edit_view;

class _TestEditDesktop extends StatefulWidget {
  final TestEditViewModel viewModel;

  _TestEditDesktop(this.viewModel);

  @override
  _TestEditDesktopState createState() => _TestEditDesktopState();
}

class _TestEditDesktopState extends State<_TestEditDesktop> {
  @override
  void initState() {
    widget.viewModel.getPatientTest(onLoadPatientTest: (PatientTest patientTest) {
      editForm.patchValue(patientTest.toMap());
    });
    super.initState();
  }

  FormGroup editForm = fb.group({
    'patient': fb.group({
      'id': FormControl<int>(),
      'identifier': FormControl<String>(
        validators: [Validators.required],
      ),
      'dateOfBirth': FormControl<DateTime>(
        validators: [Validators.required],
      ),
      'age': FormControl<int>(disabled: true),
      'gender': FormControl<String>(
        validators: [Validators.required],
      ),
      'smokingStatus': FormControl<int>(),
    }),
    'test': fb.group({
      'id': FormControl<int>(),
      'sampleNumber': FormControl<String>(
        validators: [Validators.required],
      ),
      'sampleCollectionDate': FormControl<DateTime>(
        validators: [Validators.required],
      ),
      'departmentOrClinic': FormControl<String>(),
      'doctorName': FormControl<String>(
        validators: [Validators.required],
      ),
      'elisaKitLotNumber': FormControl<String>(
        validators: [Validators.required],
      ),
      'dateOfTest': FormControl<DateTime>(
        validators: [Validators.required],
      ),
      'riskScore': FormControl<double>(),
      'risk': FormControl<String>(),
      'createdBy': FormControl<String>()
    }),
    'biomarker': fb.group({
      'concentrationA': FormControl<double>(
        validators: [Validators.required, Validators.min(0), Validators.max(2600)],
      ),
      'biomarkerAQc1PgMl': FormControl<double>(
        validators: [CustomValidators.min(1360), CustomValidators.max(1840)],
      ),
      'biomarkerAQc2PgMl': FormControl<double>(
        validators: [CustomValidators.min(170), CustomValidators.max(230)],
      ),
      'concentrationC': FormControl<double>(
        validators: [Validators.required, Validators.min(0), Validators.max(2500)],
      ),
      'biomarkerCQc1PgMl': FormControl<double>(
        validators: [CustomValidators.min(425), CustomValidators.max(575)],
      ),
      'biomarkerCQc2PgMl': FormControl<double>(
        validators: [CustomValidators.min(42.5), CustomValidators.max(57.5)],
      ),
      'concentrationG': FormControl<double>(
        validators: [Validators.required, Validators.min(0), Validators.max(4000)],
      ),
      'biomarkerGQc1PgMl': FormControl<double>(
        validators: [CustomValidators.min(1020), CustomValidators.max(1380)],
      ),
      'biomarkerGQc2PgMl': FormControl<double>(
        validators: [CustomValidators.min(153), CustomValidators.max(207)],
      ),
      'concentrationP': FormControl<double>(
        validators: [Validators.required, Validators.min(0), Validators.max(17000)],
      ),
      'biomarkerPQc1PgMl': FormControl<double>(
        validators: [CustomValidators.min(8075), CustomValidators.max(10925)],
      ),
      'biomarkerPQc2PgMl': FormControl<double>(
        validators: [CustomValidators.min(722.5), CustomValidators.max(977.5)],
      ),
      'concentrationS': FormControl<double>(
        validators: [Validators.required, Validators.min(0), Validators.max(2000)],
      ),
      'biomarkerSQc1PgMl': FormControl<double>(
        validators: [CustomValidators.min(425), CustomValidators.max(575)],
      ),
      'biomarkerSQc2PgMl': FormControl<double>(
        validators: [CustomValidators.min(42.5), CustomValidators.max(57.5)],
      ),
    }),
  });

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      showConfirmation: true,
      child: ReactiveFormBuilder(
        form: () => editForm,
        builder: (context, form, child) {
          return Scaffold(
            drawer: AppDrawerWidget(),
            appBar: AppBar(
              title: Text('Edit Test'),
              actions: [MenuActionWidget(buildContext: buildContext, showConfirmation: true)],
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return FloatingActionButton.extended(
                      icon: widget.viewModel.isLoading ? LoadingWidget(size: 20, stroke: 2) : Icon(Icons.save),
                      label: Text('SUBMIT'),
                      heroTag: 'submitBtn',
                      onPressed: form.valid && !widget.viewModel.isLoading
                          ? () => askPasswordDialog(
                                message: "You won't able to edit the test anymore after submission.",
                                onConfirmed: () => widget.viewModel.submitPatientTest(),
                              )
                          : null,
                      tooltip: 'Submit test',
                      mouseCursor: form.valid ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
                    );
                  },
                ),
                SizedBox(width: 15),
                FloatingActionButton.extended(
                  label: Text('SHOW LIST'),
                  icon: Icon(Icons.list_alt_outlined),
                  onPressed: widget.viewModel.navigateToListPage,
                  tooltip: 'Goto list page',
                  heroTag: 'navBtn',
                ),
                SizedBox(width: 15),
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return FloatingActionButton.extended(
                      icon: widget.viewModel.isLoading ? LoadingWidget(size: 20, stroke: 2) : Icon(Icons.save),
                      label: Text('UPDATE'),
                      heroTag: 'updateBtn',
                      onPressed: form.valid && !widget.viewModel.isLoading
                          ? () => widget.viewModel.updatePatientTest(
                                PatientTest.fromMap(form.value),
                                buildContext,
                              )
                          : null,
                      tooltip: 'Update test',
                      mouseCursor: form.valid ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  BioCheetahLogoTitleWidget(),
                  Container(
                    margin: EdgeInsets.only(bottom: 100),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ReactiveTextField(
                                formControlName: 'patient.identifier',
                                validationMessages: (control) => {'required': 'Patient ID is required'},
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Patient ID*',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              ReactiveTextField(
                                formControlName: 'test.sampleNumber',
                                validationMessages: (control) => {'required': 'Sample number is required'},
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Sample number*',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              ReactiveTextField(
                                formControlName: 'test.sampleCollectionDate',
                                validationMessages: (control) => {'required': 'Sample collection date is required'},
                                valueAccessor: DateTimeValueFormatAccessor(),
                                readOnly: true,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Sample collection date*',
                                  border: OutlineInputBorder(),
                                  suffixIcon: ReactiveDatePicker(
                                    formControlName: 'test.sampleCollectionDate',
                                    firstDate: DateTime(DateTime.now().year - 10),
                                    lastDate: DateTime(DateTime.now().year + 10),
                                    builder: (context, picker, child) {
                                      return IconButton(
                                        icon: Icon(Icons.access_time),
                                        onPressed: picker.showPicker,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              ReactiveTextField(
                                formControlName: 'test.doctorName',
                                validationMessages: (control) => {'required': 'Doctor name is required'},
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Name of doctor requesting test (Dr/ Prof)*',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              ReactiveTextField(
                                formControlName: 'test.departmentOrClinic',
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Department/Clinic',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ReactiveTextField(
                                      formControlName: 'patient.dateOfBirth',
                                      readOnly: true,
                                      valueAccessor: DateTimeValueFormatAccessor(),
                                      onSubmitted: () => widget.viewModel.setAge(form),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Patient date of birth*',
                                        border: OutlineInputBorder(),
                                        suffixIcon: ReactiveDatePicker(
                                          formControlName: 'patient.dateOfBirth',
                                          firstDate: CoreData.dateOfBirthStartRange,
                                          lastDate: DateTime(DateTime.now().year + 1),
                                          builder: (context, picker, child) {
                                            return IconButton(
                                              icon: Icon(Icons.access_time),
                                              onPressed: picker.showPicker,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ReactiveFormConsumer(builder: (context, form, widgetItem) {
                                      widget.viewModel.setAge(form);
                                      return ReactiveTextField(
                                        formControlName: 'patient.age',
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: 'Age',
                                          border: OutlineInputBorder(),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    width: 1,
                                    color: Theme.of(context).disabledColor,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Patient Gender*',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        ReactiveRadio(
                                          value: 'male',
                                          formControlName: 'patient.gender',
                                        ),
                                        SizedBox(width: 5),
                                        Text('Male'),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Row(
                                      children: [
                                        ReactiveRadio(
                                          value: 'female',
                                          formControlName: 'patient.gender',
                                        ),
                                        SizedBox(width: 5),
                                        Text('Female'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              ReactiveDropdownField<int>(
                                formControlName: 'patient.smokingStatus',
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Patient smoking status',
                                  border: OutlineInputBorder(),
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text('Current Smoker'),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('Ex Smoker'),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text('Non Smoker'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ReactiveTextField(
                                formControlName: 'test.elisaKitLotNumber',
                                validationMessages: (control) => {'required': 'ELISA kit lot number is required'},
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'VECanDx ELISA kit lot number*',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              ReactiveTextField(
                                formControlName: 'test.dateOfTest',
                                validationMessages: (control) => {'required': 'Date of test is required'},
                                valueAccessor: DateTimeValueFormatAccessor(),
                                readOnly: true,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Date of test*',
                                  border: OutlineInputBorder(),
                                  suffixIcon: ReactiveDatePicker(
                                    formControlName: 'test.dateOfTest',
                                    firstDate: DateTime(DateTime.now().year - 10),
                                    lastDate: DateTime(DateTime.now().year + 10),
                                    builder: (context, picker, child) {
                                      return IconButton(
                                        icon: Icon(Icons.access_time),
                                        onPressed: picker.showPicker,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    style: BorderStyle.solid,
                                    width: 1,
                                    color: Theme.of(context).disabledColor,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: ReactiveFormConsumer(
                                  builder: (context, form, widget) {
                                    return Text(
                                      'Test performed by: ${form.control('test.createdBy')?.value}',
                                      style: TextStyle(fontSize: 16),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              BiomarkerConcentrationWidget(
                                formGroup: form,
                                controlName: 'biomarker.concentrationA',
                                maxValue: 2600,
                                validationMessages: {
                                  'required': 'Biomarker A concentration is required',
                                },
                                labelText: 'Biomarker A concentration*',
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerAQc1PgMl',
                                      minValue: 1360,
                                      maxValue: 1840,
                                      labelText: 'QC1 concentration pg/mL',
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerAQc2PgMl',
                                      minValue: 170,
                                      maxValue: 230,
                                      labelText: 'QC2 concentration pg/mL',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              BiomarkerConcentrationWidget(
                                formGroup: form,
                                controlName: 'biomarker.concentrationC',
                                maxValue: 2500,
                                validationMessages: {
                                  'required': 'Biomarker C concentration is required',
                                },
                                labelText: 'Biomarker C concentration*',
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerCQc1PgMl',
                                      minValue: 425,
                                      maxValue: 575,
                                      labelText: 'QC1 concentration pg/mL',
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerCQc2PgMl',
                                      minValue: 42.5,
                                      maxValue: 57.5,
                                      labelText: 'QC2 concentration pg/mL',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              BiomarkerConcentrationWidget(
                                formGroup: form,
                                controlName: 'biomarker.concentrationG',
                                maxValue: 4000,
                                validationMessages: {
                                  'required': 'Biomarker G concentration is required',
                                },
                                labelText: 'Biomarker G concentration*',
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerGQc1PgMl',
                                      minValue: 1020,
                                      maxValue: 1380,
                                      labelText: 'QC1 concentration pg/mL',
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerGQc2PgMl',
                                      minValue: 153,
                                      maxValue: 207,
                                      labelText: 'QC2 concentration pg/mL',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              BiomarkerConcentrationWidget(
                                formGroup: form,
                                controlName: 'biomarker.concentrationP',
                                maxValue: 17000,
                                validationMessages: {
                                  'required': 'Biomarker P concentration is required',
                                },
                                labelText: 'Biomarker P concentration*',
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerPQc1PgMl',
                                      minValue: 8075,
                                      maxValue: 10925,
                                      labelText: 'QC1 concentration pg/mL',
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerPQc2PgMl',
                                      minValue: 722.5,
                                      maxValue: 977.5,
                                      labelText: 'QC2 concentration pg/mL',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              BiomarkerConcentrationWidget(
                                formGroup: form,
                                controlName: 'biomarker.concentrationS',
                                maxValue: 2000,
                                validationMessages: {
                                  'required': 'Biomarker S concentration is required',
                                },
                                labelText: 'Biomarker S concentration*',
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerSQc1PgMl',
                                      minValue: 425,
                                      maxValue: 575,
                                      labelText: 'QC1 concentration pg/mL',
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: QcConcentrationWidget(
                                      formGroup: form,
                                      controlName: 'biomarker.biomarkerSQc2PgMl',
                                      minValue: 42.5,
                                      maxValue: 57.5,
                                      labelText: 'QC2 concentration pg/mL',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              ReactiveFormConsumer(
                                builder: (context, form, child) {
                                  widget.viewModel.generateTestResult(form);
                                  return ReactiveTextField(
                                    formControlName: 'test.riskScore',
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Risk Score',
                                      border: OutlineInputBorder(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Test Result',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ReactiveRadio(
                                            value: 'low',
                                            formControlName: 'test.risk',
                                          ),
                                          SizedBox(width: 5),
                                          Text(CoreData.lowRiskResult),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ReactiveRadio(
                                            value: 'high',
                                            formControlName: 'test.risk',
                                          ),
                                          SizedBox(width: 5),
                                          Text(CoreData.highRiskResult),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
