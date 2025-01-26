// // Add Patient Button
// SizedBox(
//                   width: 120,
//                   height: buttonHeight,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return const AddPatientForm();
//                         },
//                       );
//                     },
//                     icon: const Icon(
//                       FontAwesomeIcons.userPlus,
//                       size: 25,
//                       color: Colors.white,
//                     ),
//                     label: Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "addPatient".tr(),
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         softWrap: true,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff407bff),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 0),
//                     ),
//                   ),
//                 ),