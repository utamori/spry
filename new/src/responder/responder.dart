import 'dart:async';

import 'package:webfetch/webfetch.dart';

import '../request/request_event.dart';

abstract interface class Responder {
  FutureOr<Response> respond(RequestEvent event);
}
