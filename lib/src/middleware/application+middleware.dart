// ignore_for_file: file_names

import '../application.dart';
import 'middleware_stack.dart';

extension Application$Middleware on Application {
  /// Returns the configured middleware stack.
  MiddlewareStack get middleware {
    final existing = container.get<MiddlewareStack>();
    if (existing != null) return existing;

    final stack = MiddlewareStack();
    container.set(stack);

    return stack;
  }
}