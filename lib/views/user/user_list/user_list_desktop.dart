part of user_list_view;

class UserDataTableSource extends DataTableSource {
  final List<User> _items;
  final int _count;

  final Function(User user, int index) _onActivation;
  final Function(User user) _onResetPassword;
  final Function(User user) _onUnlockUser;
  final Function(User user, int index) _onDelete;
  final Function(User user, int index) _onAssignRole;

  UserDataTableSource({
    @required List<User> items,
    @required int count,
    @required Function(User user, int index) onActivation,
    @required Function(User user) onResetPassword,
    @required Function(User user) onUnlockUser,
    @required Function(User user, int index) onDelete,
    @required Function(User user, int index) onAssignRole,
  })  : _items = items,
        _count = count,
        _onActivation = onActivation,
        _onResetPassword = onResetPassword,
        _onUnlockUser = onUnlockUser,
        _onDelete = onDelete,
        _onAssignRole = onAssignRole,
        assert(items != null),
        assert(items != null),
        assert(onActivation != null),
        assert(onResetPassword != null),
        assert(onDelete != null);

  @override
  DataRow getRow(int index) {
    if (index >= _items.length) {
      return DataRow.byIndex(
        index: index,
        cells: List.generate(11, (index) => DataCell(SizedBox())),
      );
    }
    final user = _items[index];
    final formatter = DateFormat(ddMMyyyy);

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${index + 1}')),
        DataCell(Text(user.userName)),
        DataCell(Text(user.fullName)),
        DataCell(Text(user.email)),
        DataCell(Text(user.department)),
        DataCell(Text(user.designation)),
        DataCell(
          Tooltip(
            message: 'Toggle activate/deactivate',
            child: Switch(
              value: user.isActive,
              onChanged: !user.isAdmin && !user.isDeleted && Permission.Update.allowedIn(Modules.user)
                  ? (value) {
                      user.isActive = value;
                      _onActivation(user, index);
                    }
                  : null,
            ),
          ),
        ),
        DataCell(
          Chip(
            label: Text(user.isDeleted ? 'Yes' : 'No'),
            backgroundColor: user.isDeleted ? Colors.red : Colors.green,
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        DataCell(
          Chip(
            label: Text(user.isLocked ? 'Yes' : 'No'),
            backgroundColor: user.isLocked ? Colors.red : Colors.green,
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        DataCell(Text(formatter.format(user.createdAt))),
        DataCell(Text(formatter.format(user.updatedAt))),
        DataCell(
          Row(
            children: [
              if (!user.isAdmin && !user.isDeleted && user.isLocked && Permission.Update.allowedIn(Modules.user))
                IconButton(
                  icon: Icon(Icons.lock_open),
                  onPressed: () => _onUnlockUser(user),
                  tooltip: 'Unlock User',
                ),
              if (!user.isAdmin && !user.isDeleted && Permission.Update.allowedIn(Modules.user))
                IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () => _onResetPassword(user),
                  tooltip: 'Reset Password',
                ),
              if (!user.isAdmin && !user.isDeleted && Permission.Add.allowedIn(Modules.user))
                IconButton(
                  icon: Icon(Icons.playlist_add),
                  onPressed: () => _onAssignRole(user, index),
                  tooltip: 'Assign Role',
                ),
              if (!user.isAdmin && !user.isDeleted && Permission.Delete.allowedIn(Modules.user))
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _onDelete(user, index),
                  tooltip: 'Delete',
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

class _UserListDesktop extends StatefulWidget {
  final UserListViewModel viewModel;

  _UserListDesktop(this.viewModel);

  @override
  _UserListDesktopState createState() => _UserListDesktopState();
}

class _UserListDesktopState extends State<_UserListDesktop> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
        drawer: AppDrawerWidget(),
        appBar: AppBar(
          title: Text('User List'),
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
                            columns: <DataColumn>[
                              DataColumn(label: Text('SL#')),
                              DataColumn(label: Text('Username')),
                              DataColumn(label: Text('Full Name')),
                              DataColumn(label: Text('Email')),
                              DataColumn(label: Text('Department')),
                              DataColumn(label: Text('Designation')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Deleted')),
                              DataColumn(label: Text('Locked')),
                              DataColumn(label: Text('Created At')),
                              DataColumn(label: Text('Updated At')),
                              DataColumn(label: Text('Action')),
                            ],
                            source: UserDataTableSource(
                              items: widget.viewModel.items,
                              count: widget.viewModel.count,
                              onResetPassword: widget.viewModel.showPasswordResetConfirmation,
                              onUnlockUser: widget.viewModel.showUnlockUserConfirmation,
                              onActivation: widget.viewModel.showActivationConfirmation,
                              onDelete: widget.viewModel.showDeleteConfirmation,
                              onAssignRole: widget.viewModel.showAssignRoleDialog,
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
