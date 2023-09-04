import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/common_repository/api_repositoy.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:intl/intl.dart';

import '../../../common/utils/constants/app_const.dart';
import '../../../common/utils/helper/local_database_helper.dart';

final alarmApiRepoProvider =
    Provider<AlarmApiRepository>((ref) => AlarmApiRepository(ref));

class AlarmApiRepository {
  AlarmApiRepository(this.ref);
  Ref ref;

  Future<({List<Alarm>? alarmList, String? error})> getUserAlarms() async {
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    Map<String, dynamic> headers = {'Authorization': 'Bearer $authToken'};

    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'all-alarms', data: {'user_id': userId}, headers: headers);
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;

      final alarmJsonData = data['data'];
      final List<Alarm> alarmsList = [];
      for (var alarmData in alarmJsonData) {
        alarmsList.add(Alarm.fromJson(alarmData));
      }
      return (error: null, alarmList: alarmsList);
    }
    return (error: apiResponse.error, alarmList: null);
  }

  Future<({int? alarmId, String? error})> insetAlarmRequest(
      AlarmModel alarmModel) async {
    String formattedHour = DateFormat('HH').format(alarmModel.time);
    String formattedMinute = DateFormat('mm').format(alarmModel.time);
    String period = DateFormat('a').format(alarmModel.time);
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    print('token $authToken');

    Map<String, dynamic> headers = {'Authorization': 'Bearer $authToken'};
    // final repeatIsEveryDay = repeat == Repeat.everyDay;
    final days = alarmModel.days;
    final data = {
      "user_id": userId,
      "tone_id": alarmModel.toneId,
      "title": alarmModel.label.isEmpty ? 'Alarm' : alarmModel.label,
      "time_hours": formattedHour,
      "time_minutes": formattedMinute,
      "time_part": period,
      "repeat": alarmModel.repeat.name.toUpperCase(),
      'MON': days[0].isEnable ? '1' : '0',
      'TUE': days[1].isEnable ? '1' : '0',
      'WED': days[2].isEnable ? '1' : '0',
      'THU': days[3].isEnable ? '1' : '0',
      'FRI': days[4].isEnable ? '1' : '0',
      'SAT': days[5].isEnable ? '1' : '0',
      'SUN': days[6].isEnable ? '1' : '0',
      'status': alarmModel.isEnable ? 'ACTIVE' : 'INACTIVE',
    };
    print(data);
    final apiResponse = await ref
        .read(apiRepoProvider)
        .postRequest(endPoint: 'alarm-insert', data: data, headers: headers);
    print(apiResponse.response);
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        return (alarmId: data['data']['id'] as int, error: null);
      }
      return (
        alarmId: null,
        error: (data['message'] ?? data['error']).toString()
      );
    } else {
      return (alarmId: null, error: apiResponse.error);
    }
  }

  Future<({bool status, String? error})> updateAlarm(
      AlarmModel alarmModel) async {
    String formattedHour = DateFormat('HH').format(alarmModel.time);
    String formattedMinute = DateFormat('mm').format(alarmModel.time);
    String period = DateFormat('a').format(alarmModel.time);
    final userId = await LocalDb.localDb.getValue(userIdKey);
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    print('token $authToken');

    Map<String, dynamic> headers = {'Authorization': 'Bearer $authToken'};
    // final repeatIsEveryDay = repeat == Repeat.everyDay;
    final days = alarmModel.days;
    final data = {
      "user_id": userId,
      "alarm_id": alarmModel.id,
      "tone_id": alarmModel.toneId,
      "title": alarmModel.label.isEmpty ? 'Alarm' : alarmModel.label,
      "time_hours": formattedHour,
      "time_minutes": formattedMinute,
      "time_part": period,
      "repeat": alarmModel.repeat.name.toUpperCase(),
      'MON': days[0].isEnable ? '1' : '0',
      'TUE': days[1].isEnable ? '1' : '0',
      'WED': days[2].isEnable ? '1' : '0',
      'THU': days[3].isEnable ? '1' : '0',
      'FRI': days[4].isEnable ? '1' : '0',
      'SAT': days[5].isEnable ? '1' : '0',
      'SUN': days[6].isEnable ? '1' : '0',
      'status': alarmModel.isEnable ? 'ACTIVE' : 'INACTIVE',
    };
    print(data);
    final apiResponse = await ref
        .read(apiRepoProvider)
        .postRequest(endPoint: 'alarm-update', data: data, headers: headers);
    print(apiResponse.response);
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status'] as bool) {
        return (status: true, error: null);
      }
      return (
        status: false,
        error: (data['message'] ?? data['error']).toString()
      );
    } else {
      return (status: false, error: apiResponse.error);
    }
  }

  Future<({String? error, bool isDelted})> deleteAlarmAtId(int id) async {
    final authToken = await LocalDb.localDb.getValue(authTokenKey);
    Map<String, dynamic> headers = {'Authorization': 'Bearer $authToken'};
    print('token $authToken $id');
    print({'alarm_id': id});
    final apiResponse = await ref.read(apiRepoProvider).postRequest(
        endPoint: 'alarm-delete', data: {'alarm_id': id}, headers: headers);
    if (apiResponse.response != null) {
      final data = apiResponse.response!.data;
      if (data['status']) {
        return (error: null, isDelted: true);
      }
      return (
        error: (data['message'] ?? data['error']).toString(),
        isDelted: false
      );
    }
    return (error: apiResponse.error, isDelted: false);
  }
}
