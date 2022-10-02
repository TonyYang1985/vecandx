// ignore_for_file: prefer_const_constructors

part of role_edit_view;

class _RoleEditDesktop extends StatefulWidget {
  final RoleEditViewModel viewModel;

  const _RoleEditDesktop(this.viewModel);

  @override
  _RoleEditDesktopState createState() => _RoleEditDesktopState();
}

class _RoleEditDesktopState extends State<_RoleEditDesktop> {
  @override
  void initState() {
    widget.viewModel.getRole().then((role) {
      form.patchValue(role.toJson());
    });
    super.initState();
  }

  final FormGroup form = fb.group({
    'id': FormControl<String>(),
    'name': FormControl<String>(
      validators: [Validators.required],
    ),
    'description': FormControl<String>(
      validators: [Validators.required],
    ),
    'isActive': FormControl<bool>(value: true),
  });

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      showConfirmation: true,
      child: ReactiveFormBuilder(
        form: () => form,
        builder: (context, form, child) {
          return Scaffold(
            drawer: AppDrawerWidget(),
            appBar: AppBar(
              title: Text('Edit Role'),
              actions: [MenuActionWidget(buildContext: buildContext, showConfirmation: true)],
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                      heroTag: 'saveBtn',
                      onPressed: form.valid && !widget.viewModel.isLoading
                          ? () => widget.viewModel.editRole(
                                RoleEdit.fromJson(form.value),
                                onUpdaetd: () => form.reset(),
                              )
                          : null,
                      tooltip: 'Save role',
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
                            children: [
                              ReactiveTextField(
                                formControlName: 'name',
                                validationMessages: (control) => {'required': 'Role name is required'},
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Role name*',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              ReactiveTextField(
                                maxLines: 2,
                                formControlName: 'description',
                                validationMessages: (control) => {'required': 'Description is required'},
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Description*',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 10),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 0),
                                leading: ReactiveCheckbox(
                                  formControlName: 'isActive',
                                ),
                                title: Text('Is Active'),
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
