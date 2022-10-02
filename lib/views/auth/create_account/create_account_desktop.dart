part of create_account_view;

class _CreateAccountDesktop extends StatelessWidget {
  final CreateAccountViewModel viewModel;

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
    'password': FormControl<String>(
      validators: [
        Validators.required,
        CustomValidators.validatePassword,
      ],
    ),
    'confirmPassword': FormControl<String>(
      validators: [Validators.required],
    ),
  }, [
    CustomValidators.mustMatch('password', 'confirmPassword')
  ]);

  _CreateAccountDesktop(this.viewModel);

  bool get isSecurityQuestion1Valid => form.control('securityQuestion1').valid;

  void _onCreateAccount(FormGroup form, BuildContext context) {
    if (form.valid && !viewModel.isLoading) {
      final account = Account.fromJson(form.value);
      viewModel.onCreateAccount(account, context);
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      child: Scaffold(
        appBar: AppBar(title: Text('Create your account')),
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
                                  items: viewModel.securityQuestions,
                                  onChanged: (questionNo) => viewModel.filterSecurityQuestions(questionNo),
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
                                  readOnly: isSecurityQuestion1Valid,
                                  formControlName: 'securityQuestion2',
                                  validationMessages: (control) => {'required': 'Security1 question is required'},
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Security Question2',
                                    border: OutlineInputBorder(),
                                  ),
                                  items: viewModel.filteredSecurityQuestions,
                                ),
                                SizedBox(height: 10),
                                ReactiveTextField(
                                  readOnly: isSecurityQuestion1Valid,
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
                                ReactiveTextField(
                                  formControlName: 'password',
                                  validationMessages: (control) => {
                                    'required': 'Password is required',
                                    'validationErrors': null,
                                  },
                                  obscureText: viewModel.hidePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(viewModel.hidePassword ? Icons.visibility : Icons.visibility_off),
                                      onPressed: () => viewModel.hidePassword = !viewModel.hidePassword,
                                    ),
                                  ),
                                  onSubmitted: () => _onCreateAccount(form, buildContext),
                                ),
                                SizedBox(height: 10),
                                PasswordValidationWidget(),
                                ReactiveTextField(
                                  formControlName: 'confirmPassword',
                                  validationMessages: (control) => {
                                    'required': 'Confirm password is required',
                                    'mustMatch': 'Confirm password not matched',
                                  },
                                  obscureText: viewModel.hidePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm password',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(viewModel.hidePassword ? Icons.visibility : Icons.visibility_off),
                                      onPressed: () => viewModel.hidePassword = !viewModel.hidePassword,
                                    ),
                                  ),
                                  onSubmitted: () => _onCreateAccount(form, buildContext),
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
                                        onPressed: form.valid && !viewModel.isLoading && !viewModel.accountCreated
                                            ? () => _onCreateAccount(form, buildContext)
                                            : null,
                                        label: Text('Create account'),
                                        icon: viewModel.isLoading
                                            ? LoadingWidget(size: 20, stroke: 2)
                                            : Icon(Icons.person_add),
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
