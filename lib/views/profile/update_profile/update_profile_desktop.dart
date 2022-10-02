part of change_password_view;

class _UpdateProfileDesktop extends StatefulWidget {
  final UpdateProfileViewModel viewModel;

  _UpdateProfileDesktop(this.viewModel);

  @override
  _UpdateProfileDesktopState createState() => _UpdateProfileDesktopState();
}

class _UpdateProfileDesktopState extends State<_UpdateProfileDesktop> {
  @override
  void initState() {
    widget.viewModel.getProfile().then((profile) {
      widget.viewModel.filterSecurityQuestions(profile?.securityQuestion1);
      form.patchValue(profile.toJson());
    });
    super.initState();
  }

  final FormGroup form = fb.group({
    'userName': FormControl<String>(
      validators: [Validators.required],
    ),
    'fullName': FormControl<String>(
      validators: [Validators.required],
    ),
    'department': FormControl<String>(
      validators: [Validators.required],
    ),
    'designation': FormControl<String>(
      validators: [Validators.required],
    ),
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
    'securityQuestion1': FormControl<int>(
      validators: [Validators.required],
    ),
    'securityAnswer1': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(3),
      ],
    ),
    'securityQuestion2': FormControl<int>(
      validators: [Validators.required],
    ),
    'securityAnswer2': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(3),
      ],
    ),
  });

  bool get isSecurityQuestion1Valid => form.control('securityQuestion1').valid;

  void _onUpdateProfile(FormGroup form) {
    if (form.valid && !widget.viewModel.isLoading) {
      final profile = Profile.fromJson(form.value);
      widget.viewModel.updateProfile(profile);
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
          actions: [MenuActionWidget(buildContext: context)],
        ),
        drawer: AppDrawerWidget(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BiocheetahLogoWidget(),
                Container(
                  constraints: BoxConstraints(maxWidth: 800),
                  child: ReactiveFormBuilder(
                    form: () => form,
                    builder: (context, form, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ReactiveTextField(
                                  readOnly: true,
                                  formControlName: 'userName',
                                  validationMessages: (control) => {'required': 'Username is required'},
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.account_box),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ReactiveTextField(
                                  formControlName: 'fullName',
                                  validationMessages: (control) => {'required': 'Full name is required'},
                                  decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.perm_identity),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ReactiveTextField(
                                  formControlName: 'department',
                                  validationMessages: (control) => {'required': 'Department is required'},
                                  decoration: InputDecoration(
                                    labelText: 'Department',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.category),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ReactiveTextField(
                                  formControlName: 'designation',
                                  validationMessages: (control) => {'required': 'Designation is required'},
                                  decoration: InputDecoration(
                                    labelText: 'Designation',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.work),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ReactiveTextField(
                                  readOnly: true,
                                  formControlName: 'email',
                                  validationMessages: (control) => {
                                    'required': 'Email is required',
                                    'email': 'Email address is not valid,',
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ReactiveDropdownField<int>(
                                  isExpanded: true,
                                  formControlName: 'securityQuestion1',
                                  validationMessages: (control) => {'required': 'Security1 question is required'},
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Security Question1',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: widget.viewModel.securityQuestions,
                                  onChanged: (questionNo) => widget.viewModel.filterSecurityQuestions(questionNo),
                                ),
                                SizedBox(height: 10),
                                ReactiveTextField(
                                  formControlName: 'securityAnswer1',
                                  validationMessages: (control) => {
                                    'required': 'Security answer is required',
                                    'minLength': 'Security answer minimum length is 3',
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter a secret answer that no one would guess.',
                                    labelText: 'Security Answer1',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.question_answer),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ReactiveDropdownField<int>(
                                  isExpanded: true,
                                  formControlName: 'securityQuestion2',
                                  validationMessages: (control) => {'required': 'Security1 question is required'},
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Security Question2',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: widget.viewModel.filteredSecurityQuestions,
                                ),
                                SizedBox(height: 10),
                                ReactiveTextField(
                                  formControlName: 'securityAnswer2',
                                  validationMessages: (control) => {
                                    'required': 'Security answer is required',
                                    'minLength': 'Security answer minimum length is 3',
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter a secret answer that no one would guess.',
                                    labelText: 'Security Answer2',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.question_answer),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ReactiveFormConsumer(
                                  builder: (context, form, child) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 45,
                                      child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
foregroundColor: Colors.white,
backgroundColor: Theme.of(context).primaryColor
),
                                        onPressed: form.valid &&
                                                !widget.viewModel.isLoading &&
                                                !widget.viewModel.profileUpdated &&
                                                Permission.Update.allowedIn(Modules.profile)
                                            ? () => _onUpdateProfile(form)
                                            : null,
                                        label: Text('UPDATE'),
                                        icon: widget.viewModel.isLoading
                                            ? LoadingWidget(size: 20, stroke: 2)
                                            : Icon(Icons.save),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
