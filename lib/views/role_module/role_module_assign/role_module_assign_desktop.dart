part of role_module_assign_view;

class _RoleModuleAssignDesktop extends StatelessWidget {
  final RoleModuleAssignViewModel viewModel;

  _RoleModuleAssignDesktop(this.viewModel);

  Widget buildModulesCheckBoxes(ModulePermissionAdd module) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: Permission.values.where((element) => element != Permission.None).map((item) {
        final permission = item.toString().replaceAll(RegExp('Permission.'), '');
        return Row(
          children: [
            Checkbox(
              value: viewModel.isPermissionAllowed(module, item),
              onChanged: (checked) => viewModel.allowPermission(module, item, checked),
            ),
            Text(permission),
            SizedBox(width: 10),
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
            title: Text('Role Module Assign'),
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
                    label: Text('UPDATE ASSIGNMENT'),
                    heroTag: 'addBtn',
                    onPressed: form.valid && !viewModel.isLoading ? viewModel.addRoleModuleAssignment : null,
                    tooltip: 'Update role module assignment',
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
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReactiveDropdownField<String>(
                              readOnly: viewModel.assignment != null,
                              isExpanded: true,
                              formControlName: 'roleId',
                              validationMessages: (control) => {'required': 'Role is required'},
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Select a Role',
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
                              onChanged: (roleId) => viewModel.getRoleModuleAssignments(roleId),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            if (viewModel.modulePermissions != null)
                              Container(
                                height: 600,
                                child: ListView(
                                  children: viewModel.modulePermissions.map((module) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: ListTile(
                                        tileColor: Colors.grey[200],
                                        title: Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                value: viewModel.isAllPermissionAllowed(module),
                                                onChanged: (checked) => viewModel.allowAllPermissions(module, checked),
                                              ),
                                              SizedBox(width: 5),
                                              Text(module.menuName, style: TextStyle(fontWeight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(left: 30),
                                          child: buildModulesCheckBoxes(module),
                                        ),
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
