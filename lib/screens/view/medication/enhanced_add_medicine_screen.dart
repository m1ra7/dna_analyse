import 'dart:io';
import 'dart:ui';

import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/models/data.dart';
import 'package:dna_analyse/provider/medicine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class EnhancedAddMedicineScreen extends StatefulWidget {
  final Medicine? medicineToEdit;

  const EnhancedAddMedicineScreen({super.key, this.medicineToEdit});

  @override
  _EnhancedAddMedicineScreenState createState() =>
      _EnhancedAddMedicineScreenState();
}

class _EnhancedAddMedicineScreenState extends State<EnhancedAddMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  File? _image;
  final picker = ImagePicker();

  // Form fields
  late TextEditingController _nameController;
  late TextEditingController _dosageController;
  late TextEditingController _notesController;
  late String _frequency;
  List<TimeOfDay> _times = [TimeOfDay.now()];
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  String _doseUnit = 'mg';
  final List<String> _doseUnits = ['mg', 'ml', 'tablet', 'damla', 'doz'];

  List<String> _getFrequencies(BuildContext context) {
    return [
      S.of(context).onceDaily,
      S.of(context).twiceDaily,
      S.of(context).threeTimesDaily,
      S.of(context).fourTimesDaily,
      S.of(context).onceWeekly,
      S.of(context).onceMonthly,
    ];
  }

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    final medicine = widget.medicineToEdit;
    _nameController = TextEditingController(text: medicine?.name ?? '');
    _dosageController = TextEditingController(text: medicine?.dosage ?? '');
    _notesController = TextEditingController(text: medicine?.notes ?? '');

    if (medicine != null) {
      _startDate = medicine.startDate;
      _times = [medicine.time];
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _frequency = S.of(context).onceDaily;
    _frequency = S.of(context).fourTimesDaily;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _initializeNotifications() async {
    tz.initializeTimeZones();

    // const AndroidInitializationSettings initializationSettingsAndroid =
    //     AndroidInitializationSettings('app_icon');

    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: true,
    //   onDidReceiveLocalNotification: (id, title, body, payload) async {},
    // );

    // final InitializationSettings initializationSettings =
    //     InitializationSettings(
    //       android: initializationSettingsAndroid,
    //       // iOS: initializationSettingsIOS,
    //     );

    //await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /*
  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
*/
  Future<void> _getImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false, // iOS 14+ için önemli
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        if (bytes.lengthInBytes > 0) {
          setState(() {
            _image = File(pickedFile.path);
          });
        } else {
          throw Exception('Seçilen dosya boş veya geçersiz');
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Platform Error: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: ${e.message ?? "Bilinmeyen hata"}')),
      );
    } catch (e) {
      debugPrint('General Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Resim seçilemedi: $e')));
    }
  }

  Future<void> _scheduleNotification() async {
    for (var time in _times) {
      final now = DateTime.now();
      var scheduledDate = tz.TZDateTime.from(
        DateTime(
          _startDate.year,
          _startDate.month,
          _startDate.day,
          time.hour,
          time.minute,
        ),
        tz.local,
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // const AndroidNotificationDetails androidPlatformChannelSpecifics =
      //     AndroidNotificationDetails(
      //       'medicine_reminder_id',
      //       'İlaç Hatırlatıcı',
      //       channelDescription: 'İlaç alma zamanı hatırlatıcıları',
      //       importance: Importance.max,
      //       priority: Priority.high,
      //       ticker: 'ticker',
      //     );

      // const NotificationDetails platformChannelSpecifics = NotificationDetails(
      //   android: androidPlatformChannelSpecifics,
      // );

      // await flutterLocalNotificationsPlugin.zonedSchedule(
      //   0,
      //   'İlaç Zamanı',
      //   '${_nameController.text} almayı unutmayın (${_dosageController.text} $_doseUnit)',
      //   scheduledDate,
      //   platformChannelSpecifics,
      //   androidAllowWhileIdle: true,
      //   uiLocalNotificationDateInterpretation:
      //       UILocalNotificationDateInterpretation.absoluteTime,
      //   matchDateTimeComponents: DateTimeComponents.time,
      // );
    }
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _times[index],
    );
    if (picked != null) {
      setState(() {
        _times[index] = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  bool _canAddMoreTimes() {
    return _times.length < 4 &&
        (_frequency == S.of(context).twiceDaily ||
            _frequency == S.of(context).threeTimesDaily ||
            _frequency == S.of(context).fourTimesDaily);
  }

  void _addTime() {
    setState(() {
      _times.add(TimeOfDay.now());
    });
  }

  void _removeTime(int index) {
    setState(() {
      _times.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _scheduleNotification();

      final medicineProvider = Provider.of<MedicineProvider>(
        context,
        listen: false,
      );

      if (widget.medicineToEdit != null) {
        // Update existing medicine
        final updatedMedicine = Medicine(
          id: widget.medicineToEdit!.id,
          name: _nameController.text,
          dosage: '${_dosageController.text} $_doseUnit',
          startDate: _startDate,
          endDate: _endDate,
          time: _times.first,
          notes: _notesController.text,
        );
        medicineProvider.updateMedicine(updatedMedicine);
      } else {
        // Add new medicine
        final newMedicine = Medicine(
          endDate: _endDate,
          id: DateTime.now().toString(),
          name: _nameController.text,
          dosage: '${_dosageController.text} $_doseUnit',
          startDate: _startDate,
          time: _times.first,
          notes: _notesController.text,
        );
        medicineProvider.addMedicine(newMedicine);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.medicineToEdit != null
              ? S.of(context).editMedicine
              : S.of(context).addNewMedicine,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.asset(
              //   "assets/images/logo.png",
              //   width: 400,
              //   height: 200,
              // ),

              // Center(
              //   child: GestureDetector(
              //     onTap: _getImage,
              //     child: CircleAvatar(
              //       radius: 50,
              //       backgroundColor: Colors.grey[200],
              //       backgroundImage: _image != null ? FileImage(_image!) : null,
              //       child: _image == null
              //           ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
              //           : null,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 20),
              // Center(
              //   child: Text(
              //     S.of(context).addMedicineImage,
              //     style: TextStyle(color: Colors.grey),
              //   ),
              // ),
              // SizedBox(height: 30),

              // İlaç Detayları
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).medicineDetails,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: '${S.of(context).medicineName} *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).pleaseEnterMedicineName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _dosageController,
                              decoration: InputDecoration(
                                labelText: '${S.of(context).dosage}*',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).pleaseEnterDosage;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField<String>(
                              value: _doseUnit,
                              decoration: InputDecoration(
                                labelText: '${S.of(context).unit} *',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              items:
                                  _doseUnits.map((String unit) {
                                    return DropdownMenuItem<String>(
                                      value: unit,
                                      child: Text(unit),
                                    );
                                  }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _doseUnit = newValue!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).pleaseSelectUnit;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Program ve Hatırlatıcılar
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).scheduleAndReminders,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        value: _frequency,
                        decoration: InputDecoration(
                          labelText: '${S.of(context).frequency} *',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        items:
                            _getFrequencies(context).map((String frequency) {
                              return DropdownMenuItem<String>(
                                value: frequency,
                                child: Text(frequency),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _frequency = newValue!;
                            if (_frequency == S.of(context).onceDaily) {
                              _times = _times.take(1).toList();
                            } else if (_frequency == S.of(context).twiceDaily) {
                              _times = _times.take(2).toList();
                              if (_times.length < 2) {
                                _times.add(TimeOfDay(hour: 12, minute: 0));
                              }
                            }
                            // Diğer durumlar...
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).pleaseSelectFrequency;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        '${S.of(context).times} *',
                        style: TextStyle(fontSize: 16),
                      ),
                      Column(
                        children: List.generate(_times.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _selectTime(context, index),
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                      ),
                                      child: Text(
                                        _times[index].format(context),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                if (_times.length > 1)
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _removeTime(index),
                                  ),
                              ],
                            ),
                          );
                        }),
                      ),
                      if (_canAddMoreTimes())
                        TextButton(
                          onPressed: _addTime,
                          child: Text('+  ${S.of(context).addTime}'),
                        ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, true),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: '${S.of(context).startDate}*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, false),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: S.of(context).endDateOptional,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  _endDate == null
                                      ? S.of(context).select
                                      : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Notlar
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).reminderSettings,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _notesController,
                        decoration: InputDecoration(
                          hintText: S.of(context).notesHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),

              // İlaç Detayları
              SizedBox(height: 10),

              // Kaydet Butonu
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                    child: Text(
                      widget.medicineToEdit != null
                          ? S.of(context).update
                          : S.of(context).saveMedicine,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
