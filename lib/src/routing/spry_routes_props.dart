import '../spry.dart';
import 'routes.dart';

extension SpryRoutesProps on Spry {
  /// Returns current [Routes] instance.
  Routes get routes {
    final existing = container.get<Routes>();
    if (existing != null) return existing;

    final routes = Routes();
    container.set<Routes>(routes);

    return routes;
  }
}