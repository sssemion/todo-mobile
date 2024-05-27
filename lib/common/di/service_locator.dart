import 'package:done/feature/app/navigator/app_navigator.dart';
import 'package:done/feature/app/repositories/task_connect_repository.dart';
import 'package:done/feature/app/repositories/task_local_repository.dart';
import 'package:done/feature/app/repositories/task_network_repository.dart';
import 'package:done/feature/app/task_api/local_storage_api.dart';
import 'package:done/feature/app/task_api/network_task_backend.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class ServiceLocator {
  late TaskListBloc bloc;

  late AppNavigator appNavigator;
  final getIt = GetIt.instance;

  ServiceLocator() {
    final networkTaskBackend = NetworkTaskBackend();
    final localStorageApi = LocalStorageApi();
    final taskNetworkRepository = TaskNetworkRepository(networkTaskBackend);
    final taskLocalRepository = TaskLocalRepository(localStorageApi);
    final taskConnectRepository = TaskConnectRepository(
        taskLocalRepository: taskLocalRepository,
        taskNetworkRepository: taskNetworkRepository);
    bloc = TaskListBloc(taskRepository: taskConnectRepository)
      ..add(const GetListEvent());

    appNavigator = AppNavigator(
      task: null,
      //Task.initial(),
      tasksStream: bloc.state.when(
        loaded: (list) => BehaviorSubject.seeded(list),
        loading: () => BehaviorSubject.seeded([]),
        error: (_, list) => BehaviorSubject.seeded(list),
      ),
    );
    register();
  }

  void register() {
    getIt.registerSingleton<AppNavigator>(appNavigator);
    getIt.registerSingleton<TaskListBloc>(bloc);
  }
}
