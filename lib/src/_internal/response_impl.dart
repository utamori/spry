import 'dart:convert';
import 'dart:io';

import '../response.dart';

class ResponseImpl extends Response {
  /// Creates a new [ResponseImpl] instance.
  ResponseImpl(this.response);

  /// [HttpResponse] instance.
  final HttpResponse response;

  @override
  final List<Cookie> cookies = [];

  Stream<List<int>>? _bodyStream;

  @override
  HttpHeaders get headers => response.headers;

  @override
  Stream<List<int>> read() {
    if (_bodyStream == null) {
      throw StateError('The "read" method can only be called once.');
    }

    final Stream<List<int>> bodyStream = _bodyStream!;
    _bodyStream = null;

    return bodyStream;
  }

  @override
  void send(Object? object) {
    if (object == null) {
      _bodyStream = Stream.empty();
    } else if (object is String) {
      final Encoding encoding = this.encoding ?? utf8;

      _bodyStream = Stream.value(encoding.encode(object));
    } else if (object is List) {
      _bodyStream = Stream.value(object.cast());
    } else if (object is Stream) {
      _bodyStream = object.cast();
    } else {
      throw ArgumentError.value(
          'Response body "$object" must be a String, List or Stream.');
    }
  }

  @override
  bool get isBodyReady => _bodyStream != null;
}
