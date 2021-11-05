part of app.home;

class ProfileView extends StatelessWidget {
  static String route = '${HomeView.route}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[Text('Profile view')],
      ),
    );
  }
}
