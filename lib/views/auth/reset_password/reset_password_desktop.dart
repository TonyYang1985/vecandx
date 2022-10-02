part of reset_password_view;

class _ResetPasswordDesktop extends StatefulWidget {
  final ResetPasswordViewModel viewModel;

  _ResetPasswordDesktop(this.viewModel);

  @override
  __ResetPasswordDesktopState createState() => __ResetPasswordDesktopState();
}

class __ResetPasswordDesktopState extends State<_ResetPasswordDesktop> {
  @override
  void initState() {
    resetPasswordForm.patchValue(widget.viewModel.passwordResetToken.toJson());
    super.initState();
  }

  FormGroup resetPasswordForm = fb.group({
    'userName': FormControl<String>(
      validators: [Validators.required],
    ),
    'token': FormControl<String>(
      validators: [Validators.required],
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

  void _onResetPassword(FormGroup form) {
    if (form.valid && !widget.viewModel.isLoading) {
      final passwordReset = PasswordReset.fromJson(form.value);
      widget.viewModel.resetPassword(passwordReset);
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      child: Scaffold(
        appBar: AppBar(title: Text('Reset Password')),
        body: Center(
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
                          formControlName: 'password',
                          validationMessages: (control) => {'required': 'New password is required'},
                          obscureText: widget.viewModel.hidePassword,
                          decoration: InputDecoration(
                            labelText: 'New password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(widget.viewModel.hidePassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => widget.viewModel.hidePassword = !widget.viewModel.hidePassword,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        PasswordValidationWidget(),
                        ReactiveTextField(
                          formControlName: 'confirmPassword',
                          validationMessages: (control) => {
                            'required': 'Confirm password is required',
                            'mustMatch': 'Confirm password not matched',
                          },
                          obscureText: widget.viewModel.hidePassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(widget.viewModel.hidePassword ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => widget.viewModel.hidePassword = !widget.viewModel.hidePassword,
                            ),
                          ),
                          onSubmitted: () => _onResetPassword(form),
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
                                onPressed:
                                    form.valid && !widget.viewModel.isLoading ? () => _onResetPassword(form) : null,
                                child: widget.viewModel.isLoading
                                    ? LoadingWidget(size: 20, stroke: 2)
                                    : Text('Reset Password'),
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
    );
  }
}
