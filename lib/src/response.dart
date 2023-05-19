import 'dart:convert';
import 'dart:io';

import 'context.dart';
import 'interceptor/rethrow_exception.dart';

/// Spry framework response.
class Response {
  Response(this.context);

  //---------------------------------------------------------------------
  // Internal properties
  //---------------------------------------------------------------------
  Stream<List<int>>? _bodyStream;
  //---------------------------------------------------------------------

  /// The [Context] instance of the current request.
  final Context context;

  /// Returns a [HttpResponse] instance.
  HttpResponse get _httpResponse => context[HttpResponse];

  /// Returns a [HttpResponse] instance.
  @Deprecated(
      'Use `context[HttpResponse]` instead. This will be removed in 3.0')
  HttpResponse get httpResponse => context[HttpResponse];

  /// The http response status code.
  ///
  /// Default is `200`.
  int statusCode = HttpStatus.ok;

  /// Returns the response headers.
  ///
  /// The response headers can be modified until the response body is
  /// written to or closed. After that they become immutable.
  HttpHeaders get headers => _httpResponse.headers;

  /// Returns or sets the response cookies.
  final List<Cookie> cookies = <Cookie>[];

  /// Returns or sets the content type of the response.
  ContentType? contentType;

  /// Redirects the response to the given [url].
  void redirect(Uri location, {int status = HttpStatus.movedTemporarily}) =>
      RedirectResponse(location, status: status);

  /// Close the response.
  ///
  /// Should be called after sending the response, we don't recommend you to call it.
  /// Because it is eager, it will end the request as soon as it is called,
  /// which is a disaster for post middleware.
  void close() => EagerResponse();

  /// Return the response body as a [Stream].
  ///
  /// If body is not ready, it will return `null`.
  Stream<List<int>>? read() => _bodyStream;

  /// Send a [Stream] of bytes as the response body.
  void stream(Stream<List<int>> stream) => _bodyStream = stream;

  /// Send a [List<int>] RAW data as the response body.
  void raw(List<int> raw) => stream(Stream.value(raw));

  /// Send a [String] as the response body.
  ///
  /// If [encoding] is not specified, it will use [Spry.encoding] as the default encoding.
  void text(String text, {Encoding? encoding}) {
    encoding ??= context.app.encoding;
    raw(encoding.encode(text));
    contentType = ContentType.text;
  }
}

/// Redirect response.
///
/// If you want to throw [RedirectResponse] in your [Middleware] or [Handler] to
/// redirect the request, you can use this class.
class RedirectResponse implements RethrowException {
  /// Create an instance of [RedirectResponse].
  const RedirectResponse._(this.location,
      {this.status = HttpStatus.movedTemporarily});

  /// Throws an [RedirectResponse] exception.
  factory RedirectResponse(Uri location,
          {int status = HttpStatus.movedTemporarily}) =>
      throw RedirectResponse._(location, status: status);

  /// The location to redirect to.
  final Uri location;

  /// The status code of the response.
  final int status;
}

/// Eager response.
///
/// If you want to throw [EagerResponse] in your [Middleware] or [Handler] to
/// end the request, you can use this class.
///
/// ```dart
/// handler: (context) {
///  throw EagerResponse();
/// }
/// ```
class EagerResponse implements RethrowException {
  /// Create an instance of [EagerResponse].
  const EagerResponse._();

  /// Throws an [EagerResponse] exception.
  factory EagerResponse() => throw const EagerResponse._();
}