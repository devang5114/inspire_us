import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:inspire_us/common/model/global_audio_model.dart';
import 'package:inspire_us/features/alarm/repository/alarm_api_reposioty.dart';
import 'package:inspire_us/features/tone/repository/audio_repository.dart';
import '../../../common/model/day_model.dart';
import '../../../common/utils/constants/repeat_enum.dart';
import '../../../common/utils/helper/local_database_helper.dart';
import '../repository/alarm_repository.dart';

final alarmController = ChangeNotifierProvider<AlarmController>((ref) {
  return AlarmController(ref);
});

class AlarmController extends ChangeNotifier {
  AlarmController(this.ref) {
    isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
  }

  Ref ref;
  // List<Alarm> alarms = [];
  List<GlobalAudioModel> alarmTones = [];
  TextEditingController labelController = TextEditingController();
  Repeat repeat = Repeat.once;
  bool vibrate = false;
  List<Day> days = [
    Day(name: 'Mon', isEnable: false),
    Day(name: 'Tue', isEnable: false),
    Day(name: 'Wed', isEnable: false),
    Day(name: 'Thu', isEnable: false),
    Day(name: 'Fri', isEnable: false),
    Day(name: 'Sat', isEnable: false),
    Day(name: 'Sun', isEnable: false),
  ];

  DateTime alarmTime = DateTime.now();
  int? updateAlarmIndex;
  String? selectedTune;
  int? updateAlarmId;
  int? selectedToneId;
  bool addAlarmLoading = false;
  bool isDarkMode = false;
  bool loading = false;
  // int? updatedAlarmId;

  update(AlarmModel alarmModel, int index) {
    print(index);

    updateAlarmIndex = index;
    print('update index $updateAlarmIndex');
    vibrate = alarmModel.vibration;
    updateAlarmId = alarmModel.id;
    days = alarmModel.days;
    selectedToneId = alarmModel.toneId;
    alarmTime = alarmModel.time;
    repeat = alarmModel.repeat;
    selectedTune = alarmModel.alarmSound;
    labelController.text = alarmModel.label;
  }

  setRepeat(Repeat val) {
    repeat = val;
    notifyListeners();
  }

  deleteAlarm(AlarmModel alarmModel) async {
    ({String? error, bool isDelted}) result =
        await ref.read(alarmApiRepoProvider).deleteAlarmAtId(alarmModel.id);
    if (result.isDelted) {
      await alarmModel.delete();
      Fluttertoast.showToast(
          msg: 'Alarm deleted',
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          textColor: isDarkMode ? Colors.black : Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: result.error!,
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          textColor: isDarkMode ? Colors.black : Colors.white);
    }
    await AlarmRepository.cancelAlarm(alarmModel);
  }

  reset() {
    updateAlarmId = null;
    updateAlarmIndex = null;
    labelController.clear();
    repeat = Repeat.once;
    days = [
      Day(name: 'Mon', isEnable: false),
      Day(name: 'Tue', isEnable: false),
      Day(name: 'Wed', isEnable: false),
      Day(name: 'Thu', isEnable: false),
      Day(name: 'Fri', isEnable: false),
      Day(name: 'Sat', isEnable: false),
      Day(name: 'Sun', isEnable: false),
    ];
  }

  pickTime(BuildContext context) async {
    TimeOfDay initialTime =
        TimeOfDay(hour: alarmTime.hour, minute: alarmTime.minute + 1);
    final timeOfDay = await showTimePicker(
        context: context, initialTime: initialTime, helpText: 'Select Time');
    if (timeOfDay != null) {
      var time = DateTime.now();
      DateTime alTime = DateTime(
          time.year, time.month, time.day, timeOfDay.hour, timeOfDay.minute);
      alarmTime = alTime;
      notifyListeners();
    }
  }

  setDaysValue(int index, bool val) {
    days[index].isEnable = val;
    notifyListeners();
  }

  Future<void> setAlarm(BuildContext context) async {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    List<Day> alarmWeekDays = days;
    if (repeat == Repeat.everyDay) {
      alarmWeekDays = activeDays;
    } else if (repeat == Repeat.once) {
      alarmWeekDays = emptyDays;
    }
    if (updateAlarmIndex != null) {
      AlarmModel alarmModel = AlarmModel(
          id: updateAlarmId,
          vibration: vibrate,
          alarmSound: 'selectedTune',
          days: alarmWeekDays,
          repeat: repeat,
          toneId: selectedToneId!,
          label: labelController.text == '' ? 'Alarm' : labelController.text,
          time: alarmTime,
          isEnable: true);
      await LocalDb.localDb.putAlarmAtIndex(updateAlarmIndex!, alarmModel);
      await AlarmRepository.cancelAlarm(alarmModel);
      await AlarmRepository.scheduleAlarm(alarmModel);
      print('nl $updateAlarmIndex');
      ({String? error, bool status}) result =
          await ref.read(alarmApiRepoProvider).updateAlarm(alarmModel);
      if (result.status) {
        // final index = await LocalDb.localDb.getValue(updateAlarmnIndexKey);
        Fluttertoast.showToast(
            msg: 'alarm updated',
            backgroundColor: isDarkMode ? Colors.white : Colors.black,
            gravity: ToastGravity.CENTER,
            textColor: isDarkMode ? Colors.black : Colors.white);
      } else {
        Fluttertoast.showToast(
            msg: result.error!,
            backgroundColor: isDarkMode ? Colors.white : Colors.black,
            gravity: ToastGravity.CENTER,
            textColor: isDarkMode ? Colors.black : Colors.white);
      }
    } else {
      addAlarmLoading = true;
      final audioModel = alarmTones
          .firstWhere((element) => element.id == selectedToneId.toString());
      notifyListeners();
      AlarmModel alarmModel = AlarmModel(
          days: alarmWeekDays,
          label: labelController.text,
          repeat: repeat,
          alarmSound: audioModel.fileUrl,
          toneId: selectedToneId!,
          time: alarmTime,
          vibration: vibrate,
          isEnable: true);
      print(alarmModel.alarmSound);

      ({int? alarmId, String? error}) result =
          await ref.read(alarmApiRepoProvider).insetAlarmRequest(alarmModel);
      if (result.alarmId != null) {
        Fluttertoast.showToast(
            msg:
                'Alarm set At ${alarmModel.time.hour}:${alarmModel.time.minute}',
            backgroundColor: isDarkMode ? Colors.white : Colors.black,
            textColor: isDarkMode ? Colors.black : Colors.white);
        await LocalDb.localDb.addAlarm(alarmModel.copyWith(id: result.alarmId));

        AlarmRepository.scheduleAlarm(alarmModel.copyWith(id: result.alarmId));
      } else {
        Fluttertoast.showToast(
            msg: result.error!,
            backgroundColor: isDarkMode ? Colors.white : Colors.black,
            textColor: isDarkMode ? Colors.black : Colors.white);
      }
      addAlarmLoading = false;
      notifyListeners();
    }
    reset();
  }

  Future<void> onToggle(AlarmModel alarmModel, bool value) async {
    ({String? error, bool status}) result =
        await ref.read(alarmApiRepoProvider).updateAlarm(alarmModel);
    if (result.status) {
      Fluttertoast.showToast(
          msg: alarmModel.isEnable ? 'Alarm ON' : 'Alarm OF',
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          gravity: ToastGravity.CENTER,
          textColor: isDarkMode ? Colors.black : Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: result.error!,
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          gravity: ToastGravity.CENTER,
          textColor: isDarkMode ? Colors.black : Colors.white);
    }
    AlarmRepository.toggleAlarm(alarmModel, value);
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  getUserTones(BuildContext context) async {
    addAlarmLoading = true;
    // notifyListeners();
    ({List<GlobalAudioModel>? audioList, String? error}) result =
        await ref.read(toneRepoProvider).getGlobalTones();
    if (result.audioList != null) {
      alarmTones = result.audioList!;
      if (updateAlarmIndex == null) {
        selectedToneId = int.parse(alarmTones.first.id);
      }
      addAlarmLoading = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
        msg: result.error!,
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
        textColor: isDarkMode ? Colors.black : Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  void dispose() {
    labelController.dispose();
    super.dispose();
  }
}

List<Day> emptyDays = [
  Day(name: 'Mon', isEnable: false),
  Day(name: 'Tue', isEnable: false),
  Day(name: 'Wed', isEnable: false),
  Day(name: 'Thu', isEnable: false),
  Day(name: 'Fri', isEnable: false),
  Day(name: 'Sat', isEnable: false),
  Day(name: 'Sun', isEnable: false),
];
List<Day> activeDays = [
  Day(name: 'Mon', isEnable: true),
  Day(name: 'Tue', isEnable: true),
  Day(name: 'Wed', isEnable: true),
  Day(name: 'Thu', isEnable: true),
  Day(name: 'Fri', isEnable: true),
  Day(name: 'Sat', isEnable: true),
  Day(name: 'Sun', isEnable: true),
];
