part of change_password_view;

class _ChangePasswordDesktop extends StatelessWidget {
  final ChangePasswordViewModel viewModel;

  _ChangePasswordDesktop(this.viewModel);

  final FormGroup resetPasswordForm = fb.group({
    'currentPassword': FormControl<String>(
      validators: [Validators.required],
    ),
    'newPassword': FormControl<String>(
      validators: [
        Validators.required,
        CustomValidators.validatePassword,
      ],
    ),
    'confirmPassword': FormControl<String>(
      validators: [Validators.required],
    ),
  }, [
    CustomValidators.mustMatch('newPassword', 'confirmPassword')
  ]);

  void _onChangePassword(FormGroup form) {
    if (form.valid && !viewModel.isLoading) {
      final passwordChange = PasswordChange.fromJson(form.value);
      viewModel.changePassword(passwordChange);
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      child: Scaffold(
        appBar: AppBar(title: Text('Change Password')),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BiocheetahLogoWidget(),
                Container(
                  width: 350,
                  child: ReactiveFormBuilder(
                    form: () => resetPasswordForm,
                    builder: (context, form, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ReactiveTextField(
                            formControlName: 'currentPassword',
                            validationMessages: (control) => {'required': 'Current password is required'},
                            obscureText: viewModel.hidePassword,
                            decoration: InputDecoration(
                              labelText: 'Current password',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(viewModel.hidePassword ? Icons.visibility : Icons.visibility_off),
                                onPressed: () => viewModel.hidePassword = !viewModel.hidePassword,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ReactiveTextField(
                            formControlName: 'newPassword',
                            validationMessages: (control) => {'required': 'New password is required'},
                            obscureText: viewModel.hidePassword,
                            decoration: InputDecoration(
                              labelText: 'New password',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(viewModel.hidePassword ? Icons.visibility : Icons.visibility_off),
                                onPressed: () => viewModel.hidePassword = !viewModel.hidePassword,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          PasswordValidationWidget(controlName: 'newPassword'),
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
                            onSubmitted: () => _onChangePassword(form),
                          ),
                          SizedBox(height: 10),
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              return SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: RaisedButton(
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  onPressed: form.valid && !viewModel.isLoading ? () => _onChangePassword(form) : null,
                                  child: viewModel.isLoading
                                      ? LoadingWidget(size: 20, stroke: 2)
                                      : Text('Change Password'),
                                ),
                              );
                            },
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
