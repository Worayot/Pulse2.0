import 'package:pulse/temp_data/patient_dummy_data.dart';
import 'dart:math';

class PatientListDummy {
  final Random _random = Random();

  List<Patient> generateRandomPatients(int count) {
    return List.generate(count, (_) => _generateRandomPatient());
  }

  Patient _generateRandomPatient() {
    return Patient(
      pId: _randomPId().toString(),
      name: _randomName(),
      surname: _randomSurname(),
      age: _randomAge(),
      gender: _randomGender(),
      MEWs: _randomMEWs(),
      lastUpdate: DateTime.now(), // Current time as last update
      bedNumber: _randomBedNumber(),
      hn: _randomHn(),
      ward: _randomWard(),
    );
  }

  int _randomPId() =>
      1000 + _random.nextInt(4001); // Random ID between 1000-5000
  String _randomName() =>
      _randomChoice(["John", "Jane", "Alex", "Chris", "Taylor"]);
  String _randomSurname() =>
      _randomChoice(["Smith", "Doe", "Johnson", "Brown", "Davis"]);
  int _randomAge() => 20 + _random.nextInt(60); // Age between 20-80
  String _randomGender() => _randomChoice(["Male", "Female"]);
  int _randomMEWs() => _random.nextInt(6); // Random MEWs score from 0-5
  String _randomBedNumber() =>
      "B${1 + _random.nextInt(20)}"; // Bed numbers from B1-B20
  String _randomHn() =>
      "HN${10000 + _random.nextInt(90000)}"; // HN10000 - HN99999
  String _randomWard() =>
      _randomChoice(["ICU", "ER", "General", "Pediatrics", "Surgical"]);

  String _randomChoice(List<String> options) =>
      options[_random.nextInt(options.length)];
}
