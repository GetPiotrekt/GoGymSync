import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:gogymsync/data/datasources/session_remote_datasource.dart';
import 'package:gogymsync/data/datasources/session_remote_datasource_impl.dart';
import 'package:gogymsync/domain/repositories/session_repository.dart';
import 'package:gogymsync/domain/repositories/session_repository_impl.dart';
import 'package:gogymsync/domain/usecases/add_note.dart';
import 'package:gogymsync/domain/usecases/create_session.dart';
import 'package:gogymsync/domain/usecases/delete_note.dart';
import 'package:gogymsync/domain/usecases/end_session.dart';
import 'package:gogymsync/domain/usecases/get_notes.dart';
import 'package:gogymsync/domain/usecases/join_session.dart';
import 'package:gogymsync/domain/usecases/start_session.dart';
import 'package:gogymsync/domain/usecases/update_note.dart';
import 'package:gogymsync/domain/usecases/watch_session_status.dart';

final sl = GetIt.instance;

void setupLocator() {
// Use Cases
  sl.registerLazySingleton(() => CreateSessionUseCase(sl(), sl()));
  sl.registerLazySingleton(() => JoinSessionUseCase(sl()));
  sl.registerLazySingleton(() => StartSessionUseCase(sl()));
  sl.registerLazySingleton(() => EndSessionUseCase(sl()));
  sl.registerLazySingleton(() => WatchSessionStatusUseCase(sl()));

// Notatki
  sl.registerLazySingleton(() => AddNoteUseCase(sl()));
  sl.registerLazySingleton(() => GetNotesUseCase(sl()));
  sl.registerLazySingleton(() => UpdateNoteUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNoteUseCase(sl()));

// Lobby
  sl.registerLazySingleton(() => WatchSessionStatusUseCase(sl()));

// Repository
  sl.registerLazySingleton<SessionRepository>(
        () => SessionRepositoryImpl(remoteDataSource: sl()),
  );

// Data sources
  sl.registerLazySingleton<SessionRemoteDataSource>(
        () => SessionRemoteDataSourceImpl(FirebaseFirestore.instance),
  );
}