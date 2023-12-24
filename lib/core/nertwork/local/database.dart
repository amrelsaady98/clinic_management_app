import 'package:clinc_management_app/feature/data/models/applicator_model.dart';
import 'package:clinc_management_app/feature/data/models/patient_model.dart';
import 'package:clinc_management_app/feature/data/models/scan.dart';
import 'package:clinc_management_app/feature/data/models/scan_cataoge.dart';

import 'package:clinc_management_app/feature/data/sources/local/DAOs/daos.dart';
import 'package:clinc_management_app/feature/data/sources/local/DAOs/scan_dao.dart';
import 'package:clinc_management_app/feature/diomain/entities/entities.dart';

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(
    version: 1,
    entities: [PatientModel, ScanCatalogeModel, ApplicatorModel, ScanModel])
abstract class AppDatabase extends FloorDatabase {
  @dao
  PatientDao get patientDao;

  @dao
  ScanDao get scanDao;

  @dao
  ApplicatorDao get applicatorDao;
}
