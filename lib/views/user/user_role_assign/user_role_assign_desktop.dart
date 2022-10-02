part of role_add_view;

class _UserRoleAssignDesktop extends StatelessWidget {
  final UserRoleAssignViewModel viewModel;

  _UserRoleAssignDesktop(this.viewModel);

  Widget buildModulesCheckBoxes(List<Permission> permissionTypes) {
    final permissions = permissionTypes.map(
      (item) {
        return item.toString().replaceAll(RegExp('Permission.'), '');
      },
    ).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: Permission.values.where((element) => element != Permission.None).map((item) {
        final permission = item.toString().replaceAll(RegExp('Permission.'), '');
        return Row(
          children: [
            Checkbox(
              value: permissions.any((element) => element == permission),
              onChanged: (_) {},
            ),
            SizedBox(width: 5),
            Text(permission)
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext buildContext) {
    return ReactiveFormBuilder(
      form: () => viewModel.form,
      builder: (context, form, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('User Role Assign'),
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return FloatingActionButton.extended(
                    icon: viewModel.isLoading ? LoadingWidget(size: 20, stroke: 2) : Icon(Icons.save),
                    label: Text('UPDATE'),
                    heroTag: 'updateBtn',
                    onPressed: form.valid && !viewModel.isLoading ? viewModel.assignUserRole : null,
                    tooltip: 'Update role assignment',
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
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              tileColor: Colors.grey[200],
                              title: Text(
                                'Username: ${viewModel.user.userName}',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              tileColor: Colors.grey[200],
                              title: Text(
                                'Full Name: ${viewModel.user.fullName}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 20),
                            ReactiveDropdownField<String>(
                              isExpanded: true,
                              formControlName: 'roleId',
                              validationMessages: (control) => {'required': 'Role is required'},
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Role',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.work_outline),
                              ),
                              items: viewModel.roleDropdownItems.map(
                                (item) {
                                  return DropdownMenuItem<String>(
                                    value: item.value,
                                    child: Text(item.label),
                                  );
                                },
                              ).toList(),
                              onChanged: viewModel.getRoleModuleAssignments,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            if (viewModel.assignment != null)
                              Container(
                                height: 600,
                                child: ListView(
                                  children: viewModel.assignment.modules.map((module) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: ListTile(
                                        tileColor: Colors.grey[200],
                                        title: Text(module.menuName),
                                        subtitle: buildModulesCheckBoxes(module.permissions),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
