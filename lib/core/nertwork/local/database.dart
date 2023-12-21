import 'package:clinc_management_app/feature/data/models/patient_model.dart';
import 'package:clinc_management_app/feature/data/sources/local/DAOs/patients_dao.dart';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [PatientModel])
abstract class AppDatabase extends FloorDatabase {
  @dao
  PatientDao get patientDao;
}
