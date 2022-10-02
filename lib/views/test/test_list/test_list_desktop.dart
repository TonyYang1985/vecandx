part of test_list_view;

class TestDataTableSource extends DataTableSource {
  final List<PatientTest> items;
  final int count;
  final Function(PatientTest patientTest, int index) onMarkInvalid;
  final Function(PatientTest item) onUpdate;
  final Function(PatientTest item) onShow;

  TestDataTableSource({
    @required this.items,
    @required this.count,
    @required this.onMarkInvalid,
    @required this.onUpdate,
    @required this.onShow,
  })  : assert(items != null),
        assert(count != null),
        assert(onMarkInvalid != null),
        assert(onShow != null),
        assert(onUpdate != null);

  @override
  DataRow getRow(int index) {
    if (index >= items.length) {
      return DataRow.byIndex(
        index: index,
        cells: List.generate(10, (index) => DataCell(SizedBox())),
      );
    }
    final patientTest = items[index];
    final formatter = DateFormat(ddMMyyyy);

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(Text(patientTest.patient.identifier)),
        DataCell(Text(patientTest.test.sampleNumber)),
        DataCell(Text(formatter.format(patientTest.test.sampleCollectionDate))),
        DataCell(Text(formatter.format(patientTest.test.dateOfTest))),
        DataCell(Text(patientTest.test.doctorName)),
        DataCell(
          Chip(
            label: Text(patientTest.test.riskScore.toStringAsFixed(2)),
            backgroundColor: patientTest.test.riskScore > CoreData.cutOffValue ? Colors.red : null,
            labelStyle: TextStyle(
              color: patientTest.test.riskScore > CoreData.cutOffValue ? Colors.white : Colors.black,
            ),
          ),
        ),
        DataCell(
          Chip(
            label: Text(patientTest.test.isSubmitted ? 'Submitted' : 'In Progress'),
            backgroundColor: patientTest.test.isSubmitted ? Colors.green : null,
            labelStyle: TextStyle(
              color: patientTest.test.isSubmitted ? Colors.white : Colors.black,
            ),
          ),
        ),
        DataCell(
          Tooltip(
            message: patientTest.test.isInvalid ? 'Invalid' : 'Mark as Invalid',
            child: Switch(
              value: patientTest.test.isInvalid,
              onChanged: !patientTest.test.isInvalid && Permission.Update.allowedIn(Modules.test)
                  ? (value) {
                      patientTest.test.isInvalid = value;
                      onMarkInvalid(patientTest, index);
                    }
                  : null,
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              if (Permission.View.allowedIn(Modules.test))
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () => onShow(patientTest),
                  tooltip: 'Show detail',
                ),
              if (!patientTest.test.isSubmitted &&
                  !patientTest.test.isInvalid &&
                  Permission.Update.allowedIn(Modules.test))
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onUpdate(patientTest),
                  tooltip: 'Edit',
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count ?? 0;

  @override
  int get selectedRowCount => 0;
}

class _TestListDesktop extends StatefulWidget {
  final TestListViewModel viewModel;

  _TestListDesktop(this.viewModel);

  @override
  __TestListDesktopState createState() => __TestListDesktopState();
}

class __TestListDesktopState extends State<_TestListDesktop> {
  @override
  Widget build(BuildContext context) {
    final form = widget.viewModel.searchFilterForm;
    return Layout(
      child: Scaffold(
        drawer: AppDrawerWidget(),
        appBar: AppBar(
          title: Text('Test List'),
          actions: [MenuActionWidget(buildContext: context)],
        ),
        floatingActionButton: Permission.Add.allowedIn(Modules.test)
            ? FloatingActionButton.extended(
                label: Text('ADD TEST'),
                icon: Icon(Icons.add),
                onPressed: widget.viewModel.navigateToAddPage,
                tooltip: 'Add test',
                heroTag: 'navBtn',
              )
            : null,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ReactiveFormBuilder(
                    form: () => form,
                    builder: (context, form, child) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DateRangeWidget(
                            fromControlName: 'collectionDateFrom',
                            toControlName: 'collectionDateTo',
                            rangeName: 'Collection Date Range',
                            onClear: widget.viewModel.getList,
                          ),
                          // SizedBox(width: 5),
                          DateRangeWidget(
                            fromControlName: 'testDateFrom',
                            toControlName: 'testDateTo',
                            rangeName: 'Test Date Range',
                            onClear: widget.viewModel.getList,
                          ),
                          // SizedBox(width: 5),
                          Container(
                            constraints: BoxConstraints(maxWidth: 250),
                            child: ReactiveTextField(
                              formControlName: 'searchTerm',
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Search',
                                border: OutlineInputBorder(),
                                suffixIcon: ReactiveFormConsumer(
                                  builder: (context, form, child) {
                                    final searchTerm = form.control('searchTerm');
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        searchTerm.value != null && searchTerm.value != ''
                                            ? IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: () {
                                                  form.control('searchTerm').patchValue('');
                                                  widget.viewModel.getList();
                                                },
                                                tooltip: 'Clear',
                                              )
                                            : SizedBox(),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 5),
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              final widgetItem = form.value.values.any((item) => item != null && item != '')
                                  ? IconButton(
                                      tooltip: 'Search',
                                      icon: Icon(Icons.search),
                                      onPressed: () => widget.viewModel.getList(),
                                    )
                                  : SizedBox();
                              return widgetItem;
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.sync),
                            onPressed: () => widget.viewModel.refreshDataTable(),
                            tooltip: 'Refresh',
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: !widget.viewModel.refresh
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 35),
                          child: PaginatedDataTable(
                            onPageChanged: (offset) => (widget.viewModel.offset = offset),
                            columnSpacing: 0,
                            rowsPerPage: widget.viewModel.pageSize,
                            onRowsPerPageChanged: (size) => (widget.viewModel.pageSize = size),
                            availableRowsPerPage: [5, 10, 20, 50],
                            columns: <DataColumn>[
                              DataColumn(label: Text('SL#')),
                              DataColumn(label: Text('Patient ID')),
                              DataColumn(label: Text('Sample number')),
                              DataColumn(label: Text('Collection Date')),
                              DataColumn(label: Text('Test Date')),
                              DataColumn(label: Text('Doctor name')),
                              DataColumn(label: Text('Risk score')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Mark Invalid')),
                              DataColumn(label: Text('Action')),
                            ],
                            source: TestDataTableSource(
                              items: widget.viewModel.items,
                              count: widget.viewModel.count,
                              onMarkInvalid: widget.viewModel.showMarkAsInvalidConfirmation,
                              onUpdate: widget.viewModel.navigateToEditPage,
                              onShow: widget.viewModel.navigateToDetailPage,
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
              ),
              BioCheetahLogoTitleWidget(alignmentFromLeft: true),
            ],
          ),
        ),
      ),
    );
  }
}
