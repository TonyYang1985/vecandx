part of dashboard_view;

class _DashboardDesktop extends StatelessWidget {
  final DashboardViewModel viewModel;

  _DashboardDesktop(this.viewModel);

  Widget _buildItem({String text, IconData icon, String route}) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.white,
      child: SizedBox(
        width: 200,
        height: 170,
        child: OutlinedButton(
          onPressed: () => viewModel.navigateToPage(route),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Scaffold(
        drawer: AppDrawerWidget(),
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: [MenuActionWidget(buildContext: context)],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...viewModel.modules.map((module) {
                    return _buildItem(
                      text: module.menuName,
                      icon: moduleIconsMap[module.icon],
                      route: module.route,
                    );
                  }).toList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
