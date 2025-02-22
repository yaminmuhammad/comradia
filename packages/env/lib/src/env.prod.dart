import 'package:envied/envied.dart';

part 'env.prod.g.dart';

/// {@template env}
/// A repository that manages environmental variables.
/// {@endtemplate}
@Envied(path: '.env.prod', obfuscate: true)
abstract class EnvProd {
  /// Supabase url secret env.
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static String supabaseUrl = _EnvProd.supabaseUrl;

  /// Supabase anon key secret env.
  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static String supabaseKey = _EnvProd.supabaseKey;

  /// PowerSync url secret env.
  @EnviedField(varName: 'POWERSYNC_URL', obfuscate: true)
  static String powersyncUrl = _EnvProd.powersyncUrl;
}
