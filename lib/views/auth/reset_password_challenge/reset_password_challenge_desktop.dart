part of reset_password_challenge_view;

class _ResetPasswordChallengeDesktop extends StatelessWidget {
  final ResetPasswordChallengeViewModel viewModel;

  _ResetPasswordChallengeDesktop(this.viewModel);

  FormGroup buildForm() {
    return fb.group({
      'userName': FormControl<String>(
        validators: [Validators.required],
      ),
      'question': FormControl<int>(
        validators: [Validators.required],
      ),
      'answer': FormControl<String>(
        validators: [Validators.required],
      ),
    });
  }

  void _getSecurityQuestions(FormGroup form) {
    final control = form.controls['userName'];
    if (control.valid && !viewModel.isLoading) {
      viewModel.getSecurityQuestion(control.value);
    }
  }

  void _verifySecurityAnswer(FormGroup form) {
    if (form.valid && !viewModel.isLoading) {
      final securityAnswer = SecurityAnswer.fromJson(form.value);
      viewModel.verifySecurityAnswer(securityAnswer);
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Layout(
      child: Scaffold(
        appBar: AppBar(title: Text('Reset Password Challenge')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BiocheetahLogoWidget(),
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
                          readOnly: viewModel.hasSecurityQuestion,
                          validationMessages: (control) => {
                            'required': 'Username is required',
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.account_box),
                          ),
                          onSubmitted: () => _getSecurityQuestions(form),
                        ),
                        SizedBox(height: 10),
                        if (viewModel.hasSecurityQuestion)
                          Column(
                            children: [
                              ReactiveDropdownField<int>(
                                isExpanded: true,
                                formControlName: 'question',
                                validationMessages: (control) => {'required': 'Security question is required'},
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Security Question',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.security),
                                ),
                                items: viewModel.securityQuestions,
                              ),
                              SizedBox(height: 10),
                              ReactiveTextField(
                                formControlName: 'answer',
                                validationMessages: (control) => {
                                  'required': 'Security answer is required',
                                },
                                decoration: InputDecoration(
                                  labelText: 'Security answer',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.question_answer),
                                ),
                                onSubmitted: () => _verifySecurityAnswer(form),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        !viewModel.hasSecurityQuestion
                            ? ReactiveFormConsumer(
                                builder: (context, form, child) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 45,
                                    child: ElevatedButton(
                                     style: ElevatedButton.styleFrom(
foregroundColor: Colors.white,
backgroundColor: Theme.of(context).primaryColor
),
                                      onPressed: form.control('userName').valid && !viewModel.isLoading
                                          ? () => _getSecurityQuestions(form)
                                          : null,
                                      child: viewModel.isLoading ? LoadingWidget(size: 20, stroke: 2) : Text('Submit'),
                                    ),
                                  );
                                },
                              )
                            : ReactiveFormConsumer(
                                builder: (context, form, child) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 45,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
foregroundColor: Colors.white,
backgroundColor: Theme.of(context).primaryColor
),
                                      onPressed:
                                          form.valid && !viewModel.isLoading ? () => _verifySecurityAnswer(form) : null,
                                      child: viewModel.isLoading ? LoadingWidget(size: 20, stroke: 2) : Text('Verify'),
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
