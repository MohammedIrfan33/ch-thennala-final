import 'package:flutter/cupertino.dart';

import '../Bindders/Itemslistbinder.dart';

class GetObserveritems extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute?.settings.name == "/itempage") {
      // Reinitialize the controller when navigating back to MyPage
      ItemlistBinder().dependencies();
    }
  }
}