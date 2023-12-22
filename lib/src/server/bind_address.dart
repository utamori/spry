sealed class BindAddress {
  const factory BindAddress.host(String hostname, int port) = HostAddress;
  const factory BindAddress.unix(String path) = UnixAddress;
}

final class HostAddress implements BindAddress {
  final String? hostname;
  final int? port;

  const HostAddress([this.hostname, this.port]);

  @override
  String toString() {
    if (hostname == null) return 'localhost:$port';
    if (port == null) return hostname!;

    return '$hostname:$port';
  }
}

final class UnixAddress implements BindAddress {
  final String path;

  const UnixAddress(this.path);

  @override
  String toString() => path;
}