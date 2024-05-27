import 'dart:async';
import 'package:done/common/services/revision_pref_service.dart';
import 'package:done/feature/app/models/response/list_response.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/app/repositories/task_repository.dart';
import '../task_api/network_task_backend.dart';

class TaskNetworkRepository implements TaskRepository {
  TaskNetworkRepository(this._networkTaskBackend);

  final RevisionPrefService sharedPrefService = RevisionPrefService();

  final NetworkTaskBackend _networkTaskBackend;

  Future<ListResponse> getRevision() async {
    final response = await _networkTaskBackend.getRevision();
    sharedPrefService.saveRevision(revision: response.revision);
    return response;
  }

  @override
  Future<List<Task>> getList() async {
    return _networkTaskBackend.getList();
  }

  @override
  Future<Task> createTask({required Task task}) async {
    final tasklist = await _networkTaskBackend.getRevision();
    final newTask = await _networkTaskBackend.createTask(
        task: task, revision: tasklist.revision);
    sharedPrefService.saveRevision(revision: tasklist.revision+1);
    return newTask;
  }

  @override
  Future<Task> deleteTask({required String id}) async {
    final response = await _networkTaskBackend.getRevision();
    final deletedtask = await _networkTaskBackend.deleteTask(
        revision: response.revision, id: id);
    sharedPrefService.saveRevision(revision: response.revision+1);
    return deletedtask;
  }

  @override
  Future<Task> editTask({required Task task}) async {
    final response = await _networkTaskBackend.getRevision();
    final newtask = await _networkTaskBackend.editTask(
        task: task, revision: response.revision);
    sharedPrefService.saveRevision(revision: response.revision+1);
    return newtask;
  }

  @override
  Future<Task> getTask({required String id}) async {
    final response = await _networkTaskBackend.getRevision();
    return _networkTaskBackend.getTask(revision: response.revision, id: id);
  }

  Future<List<Task>> updateList(
      {required List<Task> taskList, required int revision}) async {
    final newTaskList = await _networkTaskBackend.updateList(
        taskList: taskList, revision: revision);
    sharedPrefService.saveRevision(revision: revision+1);
    return newTaskList;
  }
}
