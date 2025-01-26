import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/func/requests/send_MEWs_parameters.dart';
import 'package:pulse/results/result_screens.dart';

class MEWsForms extends StatefulWidget {
  const MEWsForms({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MEWsFormsState createState() => _MEWsFormsState();
}

class _MEWsFormsState extends State<MEWsForms> {
  // Declare TextEditingController for each input field
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController sysBloodPressureController =
      TextEditingController();
  final TextEditingController diaBloodPressureController =
      TextEditingController();
  final TextEditingController spo2Controller = TextEditingController();
  final TextEditingController respiratoryRateController =
      TextEditingController();
  final TextEditingController urineController = TextEditingController();

  String? consciousnessValue;

  @override
  void dispose() {
    // Dispose controllers to release memory
    heartRateController.dispose();
    temperatureController.dispose();
    sysBloodPressureController.dispose();
    diaBloodPressureController.dispose();
    spo2Controller.dispose();
    respiratoryRateController.dispose();
    urineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _showMEWsForms(context);
  }

  Widget _showMEWsForms(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Adjust radius here
      ),
      backgroundColor: const Color(0xffD7E0F5),
      contentPadding: null,
      content: Container(
        width: 800,
        color: const Color(0xFFD7E0F5), // Background color for form
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "calculateMEWs".tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.xmark, // Close icon
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]),
              const SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("consciousness".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(
                height: 40,
                child: DropdownButtonFormField<String>(
                  value: consciousnessValue,
                  onChanged: (String? newValue) {
                    consciousnessValue = newValue;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text("-"),
                    ),
                    DropdownMenuItem(
                      value: "Consciousness",
                      child: Text("conscious".tr()),
                    ),
                    DropdownMenuItem(
                      value: "Alert",
                      child: Text("alert".tr()),
                    ),
                    DropdownMenuItem(
                      value: "verbalStimuli",
                      child: Text("verbalStimuli".tr()),
                    ),
                    DropdownMenuItem(
                      value: "Pain",
                      child: Text("pain".tr()),
                    ),
                    DropdownMenuItem(
                      value: "Unresponsive",
                      child: Text("unresponsive".tr()),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text("temperature".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const Spacer(),
                  const Text("(°C)",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(
                height: 40, // Adjust height here
                child: TextField(
                  controller: temperatureController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '-',
                    suffix: const Text('°C',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16), // Adjusts height/padding
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      borderSide:
                          BorderSide.none, // Removes visible border line
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        "heartRate".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Text("(bpm)",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  )),
              SizedBox(
                height: 40, // Adjust height here
                child: TextField(
                  controller: heartRateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "-",
                    suffix: const Text("bpm",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16, // Adjusts height/padding
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text("respiratoryRate".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const Spacer(),
                  const Text("(bpm)",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: respiratoryRateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffix: const Text("bpm",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    hintText: '-',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16), // Adjusts height/padding
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      borderSide:
                          BorderSide.none, // Removes visible border line
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("bloodPressure".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const Spacer(),
                  const Text("(mmHg)",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text("Systolic",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 40, // Adjust height here
                        width: 132,
                        child: TextField(
                          controller: sysBloodPressureController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '-',
                            suffix: const Text("mmHg",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16), // Adjusts height/padding
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                              borderSide: BorderSide
                                  .none, // Removes visible border line
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text("Diastolic",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 40,
                        width: 132,
                        child: TextField(
                          controller: diaBloodPressureController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffix: const Text("mmHg",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            hintText: '-',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16), // Adjusts height/padding
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(15), // Rounded corners
                              borderSide: BorderSide
                                  .none, // Removes visible border line
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text("spO2 (${"whileGivingOxygen".tr()})",
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const Spacer(),
                  const Text(
                    "(%)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: spo2Controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '-',
                    suffix: const Text("%",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16), // Adjusts height/padding
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      borderSide:
                          BorderSide.none, // Removes visible border line
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text("urine".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const Spacer(),
                  const Text("(mL/hr)",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(
                height: 40, // Adjust height here
                child: TextField(
                  controller: urineController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '-',
                    suffix: const Text("mL/hr",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16), // Adjusts height/padding
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      borderSide:
                          BorderSide.none, // Removes visible border line
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("confirmAction".tr()),
                              content: Text("proceed?".tr()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(false); // User pressed cancel
                                  },
                                  child: Text("cancel".tr()),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(true); // User confirmed
                                  },
                                  child: Text("confirm".tr()),
                                ),
                              ],
                            );
                          },
                        ).then((confirmed) {
                          if (confirmed) {
                            Navigator.pop(context);

                            _showMEWsForms(context);
                          } else {}
                        });
                      },
                      child: Text(
                        'reset'.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red, // Text color
                          decoration: TextDecoration
                              .underline, // Underline to indicate it's clickable
                          decorationColor: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF3362CC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Set border radius here
                        ),
                      ),
                      onPressed: () async {
                        String hr = heartRateController.text;
                        String temp = temperatureController.text;
                        String sBp = sysBloodPressureController.text;
                        String dBp = diaBloodPressureController.text;
                        String spO2 = spo2Controller.text;
                        String rr = respiratoryRateController.text;
                        String urine = urineController.text;
                        String conscious = consciousnessValue ?? '';

                        String response = await sendMEWsValues(
                            consciousness: conscious,
                            heart_rate: hr,
                            temperature: temp,
                            systolic_bp: sBp,
                            spo2: spO2,
                            respiratory_rate: rr,
                            urine: urine);

                        Navigator.pop(context);

                        // print("${response}");
                        //! TODO: handle response error.
                        showResultDialog(context, int.parse(response));
                      },
                      child: Text(
                        'calculate'.tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
