import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_app/models/authentication.dart';

final counterStateProvider = StateProvider<Auth>((ref) {
  return Auth();
});