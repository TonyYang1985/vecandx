part of role_list_view;

class RoleDataTableSource extends DataTableSource {
  final List<RoleModule> _items;
  final int _count;
  final Function _onUpdate;

  RoleDataTableSource({
    @required List<RoleModule> items,
    @required int count,
    @required Function(RoleModule roleModule) onUpdate,
  })  : _items = items,
        _count = count,
        _onUpdate = onUpdate,
        assert(items != null),
        assert(items != null);

  @override
  DataRow getRow(int index) {
    if (index >= _items.length) {
      return DataRow.byIndex(
        index: index,
        cells: List.generate(4, (index) => DataCell(SizedBox())),
      );
    }
    final role = _items[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(Text(role.roleName)),
        DataCell(
          Container(
            width: 500,
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: role.allModulList.map((moduleName) {
                return Chip(label: Text(moduleName));
              }).toList(),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              if (Permission.Delete.allowedIn(Modules.roleModule))
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

class _RoleModuleListDesktop extends StatefulWidget {
  final RoleModuleListViewModel viewModel;

  _RoleModuleListDesktop(this.viewModel);

  @override
  _RoleModuleListDesktopState createState() => _RoleModuleListDesktopState();
}

class _RoleModuleListDesktopState extends State<_RoleModuleListDesktop> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
        drawer: AppDrawerWidget(),
        appBar: AppBar(
          title: Text('Role Module Assignments'),
          actions: [MenuActionWidget(buildContext: context)],
        ),
        floatingActionButton: Permission.Add.allowedIn(Modules.roleModule)
            ? FloatingActionButton.extended(
                label: Text('ASSIGN ROLE MODULE'),
                icon: Icon(Icons.add),
                onPressed: widget.viewModel.showAssignRoleModuleDialog,
                tooltip: 'Assign role module',
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
                              DataColumn(label: Text('Role Name')),
                              DataColumn(label: Text('Modules')),
                              DataColumn(label: Text('Action')),
                            ],
                            dataRowHeight: 100,
                            source: RoleDataTableSource(
                              items: widget.viewModel.items,
                              count: widget.viewModel.count,
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
