part of home_view;

class _HomeDesktop extends StatelessWidget {
  final HomeViewModel viewModel;

  _HomeDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/Biocheetah_logo.png',
                height: 250,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'VECanDx Analysis Software',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
