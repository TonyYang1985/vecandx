part of role_list_view;

class RoleDataTableSource extends DataTableSource {
  final List<Role> _items;
  final int _count;
  final Function _onActivation;
  final Function _onDelete;
  final Function _onUpdate;

  RoleDataTableSource({
    @required List<Role> items,
    @required int count,
    @required Function(Role role, int index) onActivation,
    @required Function(Role role, int index) onDelete,
    @required Function(Role role) onUpdate,
  })  : _items = items,
        _count = count,
        _onActivation = onActivation,
        _onDelete = onDelete,
        _onUpdate = onUpdate,
        assert(items != null),
        assert(items != null),
        assert(onActivation != null),
        assert(onDelete != null);

  @override
  DataRow getRow(int index) {
    if (index >= _items.length) {
      return DataRow.byIndex(
        index: index,
        cells: List.generate(8, (index) => DataCell(SizedBox())),
      );
    }
    final role = _items[index];
    final formatter = DateFormat(ddMMyyyy);

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(Text(role.name)),
        DataCell(Text(role.description)),
        DataCell(
          Tooltip(
            message: 'Toggle activate/deactivate',
            child: Switch(
              value: role.isActive,
              onChanged: !role.isAdmin && !role.isDeleted && Permission.Update.allowedIn(Modules.role)
                  ? (value) {
                      role.isActive = value;
                      return _onActivation(role, index);
                    }
                  : null,
            ),
          ),
        ),
        DataCell(
          Chip(
            label: Text(role.isDeleted ? 'Yes' : 'No'),
            backgroundColor: role.isDeleted ? Colors.red : Colors.green,
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        DataCell(Text(formatter.format(role.createdAt))),
        DataCell(Text(formatter.format(role.updatedAt))),
        DataCell(
          Row(
            children: [
              if (!role.isAdmin && !role.isDeleted && Permission.Delete.allowedIn(Modules.role))
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _onDelete(role, index),
                  tooltip: 'Delete',
                ),
              if (!role.isAdmin && !role.isDeleted && Permission.Update.allowedIn(Modules.role))
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _onUpdate(role),
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
  int get rowCount => _count ?? 0;

  @override
  int get selectedRowCount => 0;
}

class _RoleListDesktop extends StatefulWidget {
  final RoleListViewModel viewModel;

  _RoleListDesktop(this.viewModel);

  @override
  _RoleListDesktopState createState() => _RoleListDesktopState();
}

class _RoleListDesktopState extends State<_RoleListDesktop> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
        drawer: AppDrawerWidget(),
        appBar: AppBar(
          title: Text('Role List'),
          actions: [MenuActionWidget(buildContext: context)],
        ),
        floatingActionButton: Permission.Add.allowedIn(Modules.role)
            ? FloatingActionButton.extended(
                label: Text('ADD ROLE'),
                icon: Icon(Icons.add),
                onPressed: widget.viewModel.navigateToAddPage,
                tooltip: 'Add role',
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
                            columns: <DataColumn>[
                              DataColumn(label: Text('SL#')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Description')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Is Deleted')),
                              DataColumn(label: Text('Created At')),
                              DataColumn(label: Text('Updated At')),
                              DataColumn(label: Text('Action')),
                            ],
                            source: RoleDataTableSource(
                              items: widget.viewModel.items,
                              count: widget.viewModel.count,
                              onActivation: widget.viewModel.showActivationConfirmation,
                              onDelete: widget.viewModel.showDeleteConfirmation,
                              onUpdate: widget.viewModel.navigateToEditPage,
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
