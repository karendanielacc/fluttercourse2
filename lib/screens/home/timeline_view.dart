part of app.home;

class TimelineView extends StatelessWidget {
  static String route = '${HomeView.route}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[Text('Timeline view')],
      ),
    );
  }
}
