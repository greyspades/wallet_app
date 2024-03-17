class Auth {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;

  Auth({this.accessToken, this.tokenType, this.expiresIn});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(accessToken: json['access_token'], tokenType: json['token_type'], expiresIn: json['expires_in']);
  }
}