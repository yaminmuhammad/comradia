import 'package:envied/envied.dart';

part 'env.dev.g.dart';

/// {@template env}
/// A repository that manages environmental variables.
/// {@endtemplate}
@Envied(path: '.env.dev', obfuscate: true)
abstract class EnvDev {
  /// Supabase url secret env.
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static String supabaseUrl = _EnvDev.supabaseUrl;

  /// Supabase anon key secret env.
  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static String supabaseKey = _EnvDev.supabaseKey;

  /// PowerSync url secret env.
  @EnviedField(varName: 'POWERSYNC_URL', obfuscate: true)
  static String powersyncUrl = _EnvDev.powersyncUrl;
}
