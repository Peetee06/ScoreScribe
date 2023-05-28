import 'package:uuid/uuid.dart';

Uuid _uuid = const Uuid();

String generateUuid() => _uuid.v4();
