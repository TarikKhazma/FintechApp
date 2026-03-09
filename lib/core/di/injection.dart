import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../network/auth_interceptor.dart';
import '../network/dio_client.dart';
import '../storage/secure_storage_service.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_signed_in_user_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final GetIt sl = GetIt.instance;

/// Call once in [main] before [runApp].
Future<void> configureDependencies() async {
  // ── Core ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(sl<SecureStorageService>()),
  );

  sl.registerLazySingleton<Dio>(
    () => DioClient.getInstance(sl<AuthInterceptor>()),
  );

  // ── Auth feature ──────────────────────────────────────────────────────────
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<Dio>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      storageService: sl<SecureStorageService>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetSignedInUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignOutUseCase(sl<AuthRepository>()));

  // Blocs — registered as factories so each page gets a fresh instance
  sl.registerFactory(
    () => AuthBloc(
      getSignedInUser: sl<GetSignedInUserUseCase>(),
      signIn: sl<SignInUseCase>(),
      signUp: sl<SignUpUseCase>(),
      signOut: sl<SignOutUseCase>(),
    ),
  );
}
