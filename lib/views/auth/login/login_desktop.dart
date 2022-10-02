part of login_view;

class _LoginDesktop extends StatelessWidget {
  final LoginViewModel viewModel;

  _LoginDesktop(this.viewModel);

  FormGroup buildForm() {
    return fb.group({
      'userName': FormControl<String>(
        validators: [Validators.required],
      ),
      'password': FormControl<String>(
        validators: [Validators.required],
      ),
    });
  }

  void _onLogin(FormGroup form, BuildContext buildContext) {
    if (form.valid && !viewModel.isLoading) {
      final login = Login.fromJson(form.value);
      viewModel.onLogin(login, buildContext);
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                BiocheetahLogoWidget(),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Operator Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 350,
                  child: ReactiveFormBuilder(
                    form: buildForm,
                    builder: (context, form, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ReactiveTextField(
                            formControlName: 'userName',
                            validationMessages: (control) => {
                              'required': 'Username is required',
                            },
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.account_box),
                            ),
                          ),
                          SizedBox(height: 10),
                          ReactiveTextField(
                            formControlName: 'password',
                            validationMessages: (control) => {'required': 'Password is required'},
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
                            onSubmitted: () => _onLogin(form, buildContext),
                          ),
                          SizedBox(height: 10),
                          ReactiveFormConsumer(
                            builder: (context, form, child) {
                              return SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: RaisedButton.icon(
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  onPressed:
                                      form.valid && !viewModel.isLoading ? () => _onLogin(form, buildContext) : null,
                                  label: Text('Login'),
                                  icon: viewModel.isLoading ? LoadingWidget(size: 20, stroke: 2) : Icon(Icons.login),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: viewModel.navigateToResetPasswordChallenge,
                              child: Text(
                                'Forgot your password?',
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: TextButton(
                              onPressed: viewModel.navigateToCreateAccount,
                              child: Text('Create new user account'),
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
