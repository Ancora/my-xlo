import 'package:rxdart/rxdart.dart';

class DrawerBloc {
  final BehaviorSubject<int> _pageBlocController =
      BehaviorSubject<int>.seeded(0);

  Stream<int> get outPage => _pageBlocController.stream;

  int _page = 0;

  void setPage(int page) {
    if (page == _page) {
      return;
    }
    _page = page;
    _pageBlocController.add(page);
  }

  void dispose() {
    _pageBlocController.close();
  }
}
