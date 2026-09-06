import 'package:acuteflow/core/database/asset_manifest_service.dart';
import 'package:acuteflow/core/database/hive_service.dart';
import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';
import 'package:acuteflow/features/decision_tree/data/models/remedy_model.dart';
import 'package:acuteflow/features/decision_tree/data/repositories/decision_tree_repository_impl.dart';
import 'package:acuteflow/features/decision_tree/data/repositories/remedy_repository_impl.dart';
import 'package:acuteflow/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:acuteflow/features/decision_tree/domain/repositories/remedy_repository.dart';
import 'package:acuteflow/features/decision_tree/presentation/cubit/activity_state_cubit.dart';
import 'package:acuteflow/features/decision_tree/presentation/cubit/remedy_selection_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  sl.registerLazySingleton<AssetManifestService>(() => AssetManifestService());
  sl.registerLazySingleton<HiveService>(() => HiveService(sl()));

  await sl<HiveService>().initDatabase();

  sl.registerLazySingleton<Box<RemedyModel>>(
    () => Hive.box<RemedyModel>(HiveService.remedyBoxName),
  );
  sl.registerLazySingleton<Box<DecisionTreeNodeModel>>(
    () => Hive.box<DecisionTreeNodeModel>(HiveService.decisionTreeBoxName),
  );

  sl.registerLazySingleton<RemedyRepository>(() => RemedyRepositoryImpl(sl()));
  sl.registerLazySingleton<DecisionTreeRepository>(
    () => DecisionTreeRepositoryImpl(sl()),
  );

  sl.registerFactory<ActivityStateCubit>(() => ActivityStateCubit(sl()));
  sl.registerFactory<RemedySelectionCubit>(() => RemedySelectionCubit(sl()));
}
