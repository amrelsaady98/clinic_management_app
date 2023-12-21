import 'package:clinc_management_app/feature/diomain/entities/patient.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'patients', primaryKeys: ['id'])
class PatientModel extends Patient {
  const PatientModel({
    super.id,
    required super.name,
    required super.age,
    required super.gender,
    super.phoneNumber,
  });

  factory PatientModel.fromEntity(Patient patient) => PatientModel(
        id: patient.id,
        name: patient.name,
        age: patient.age,
        gender: patient.gender,
        phoneNumber: patient.phoneNumber,
      );
  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "name?",
        age: json['age'] ?? 0,
        gender: json['gender'] ?? "gender?",
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'gender': gender,
      };
}
