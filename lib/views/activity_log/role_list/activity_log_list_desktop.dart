part of activity_log_list_view;

class ActivityLogDataTableSource extends DataTableSource {
  final List<ActivityLog> _items;
  final int _count;

  ActivityLogDataTableSource({
    @required List<ActivityLog> items,
    @required int count,
  })  : _items = items,
        _count = count,
        assert(items != null),
        assert(items != null);

  @override
  DataRow getRow(int index) {
    if (index >= _items.length) {
      return DataRow.byIndex(
        index: index,
        cells: List.generate(8, (index) => DataCell(SizedBox())),
      );
    }
    final activity = _items[index];
    final formatter = DateFormat(ddMMyyyyHHmmSSaaa);
    final permission = activity.permissionType.toString().replaceAll(RegExp('Permission.'), '');
    final activityType = activity.activityType.toString().replaceAll(RegExp('Activity.'), '');

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(Text(activityType)),
        DataCell(Text(permission)),
        DataCell(Text(activity.entity)),
        DataCell(
          SizedBox(
            child: Text(activity.entityId, softWrap: true),
          ),
        ),
        DataCell(Text(activity.performedBy)),
        DataCell(Text(formatter.format(activity.createdAt))),
        DataCell(
          Container(
            width: 300,
            child: Wrap(
              children: [
                Text(activity.log, softWrap: true),
              ],
            ),
          ),
        ),
        // DataCell(
        //   Row(
        //     children: [
        //       if (Permission.View.allowedIn(Modules.activityLog))
        //         IconButton(
        //           icon: Icon(Icons.info_outline),
        //           onPressed: () {},
        //           tooltip: 'Detail',
        //         )
        //     ],
        //   ),
        // ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _count ?? 0;

  @override
  int get selectedRowCount => 0;
}

class _ActivityLogListDesktop extends StatefulWidget {
  final ActivityLogListViewModel viewModel;

  _ActivityLogListDesktop(this.viewModel);

  @override
  _ActivityLogListDesktopState createState() => _ActivityLogListDesktopState();
}

class _ActivityLogListDesktopState extends State<_ActivityLogListDesktop> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
        drawer: AppDrawerWidget(),
        appBar: AppBar(
          title: Text('Activity Log List'),
          actions: [MenuActionWidget(buildContext: context)],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BioCheetahLogoTitleWidget(alignmentFromLeft: true),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        child: TextField(
                          controller: widget.viewModel.searchController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search',
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () => widget.viewModel.getList(),
                                  tooltip: 'Search',
                                ),
                                widget.viewModel.searchText.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          widget.viewModel.searchText = '';
                                          widget.viewModel.searchController.clear();
                                          widget.viewModel.getList();
                                        },
                                        tooltip: 'Clear',
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          onChanged: (searchText) => (widget.viewModel.searchText = searchText),
                          onSubmitted: (_) => widget.viewModel.getList(),
                        ),
                      ),
                      SizedBox(width: 15),
                      IconButton(
                        icon: Icon(Icons.sync),
                        onPressed: () => widget.viewModel.refreshDataTable(),
                        tooltip: 'Refresh',
                      ),
                    ],
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
                            dataRowHeight: 80,
                            columns: <DataColumn>[
                              DataColumn(label: Text('SL#')),
                              DataColumn(label: Text('Permission')),
                              DataColumn(label: Text('Activity')),
                              DataColumn(label: Text('Table')),
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Performed By')),
                              DataColumn(label: Text('Created At')),
                              DataColumn(label: Text('Log')),
                              // DataColumn(label: Text('Action')),
                            ],
                            source: ActivityLogDataTableSource(
                              items: widget.viewModel.items,
                              count: widget.viewModel.count,
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
