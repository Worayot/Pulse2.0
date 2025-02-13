import 'package:pulse/func/pref/pref.dart';

class PreferenceResetter {
  Future<void> resetPatientInCare() async {
    List<String> patientIDs = await getPatients(); // Await to get actual data

    for (String id in patientIDs) {
      await removePatientID(id); // Ensure each removal is awaited
    }
  }
}
