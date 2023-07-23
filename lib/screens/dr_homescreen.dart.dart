import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/AppointmentData.dart';
import '../models/appointment_model.dart';

class DrHomeScreen extends StatefulWidget {
  const DrHomeScreen({Key? key}) : super(key: key);

  @override
  State<DrHomeScreen> createState() => _DrHomeScreenState();
}

class _DrHomeScreenState extends State<DrHomeScreen> {
  List<Appointment> doctorAppointments = [];

  Future<void> fetchAppointmentsForDoctor(String doctorId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch appointments where the doctorId matches the given doctorId
      print('a');
      QuerySnapshot querySnapshot = await firestore
          .collection('appointments')
          .where('doctorId', isEqualTo: doctorId)
          .get();
      print('b');
      // Update the list of doctor's appointments
      // List<Appointment> appointments = querySnapshot.docs
      //     .map((doc) => Appointment.fromSnapshot(doc))
      //     .toList();

      List<Appointment> appointments = [];
      for (var doc in querySnapshot.docs) {
        print(doc.data());
        appointments.add(Appointment.fromSnapshot(doc));
        // doctorAppointments.add(Appointment.fromSnapshot(doc));
        // appointments.add(Appointment.fromSnapshot(doc));
      }

      // doctorAppointments.add(appointments as Appointment);
      print('c');
      print(doctorAppointments);
      setState(() {
        doctorAppointments = appointments;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }

  String patientName = '';
  late List<DataRow> dataRows;
  late List<DataRow> originalDataRows;

  @override
  void initState() {
    super.initState();
    fetchAppointmentsForDoctor(FirebaseAuth.instance.currentUser!.uid);
    dataRows = appointmentList.map((Appointmentt) {
      return DataRow(
        cells: [
          DataCell(Text(Appointmentt.patientName)),
          DataCell(Text(Appointmentt.time)),
          //DataCell(IconButton(icon: const Icon(Icons.edit),onPressed: (){},))
        ],
      );
    }).toList();

    originalDataRows = List.from(dataRows);
  }

  void updateDataRows(String name) {
    if (name.isEmpty) {
      setState(() {
        dataRows = List.from(originalDataRows);
      });
    } else {
      List<DataRow> updatedRows = [];
      for (var row in originalDataRows) {
        if (row.cells[0].child
            .toString()
            .toLowerCase()
            .contains(name.toLowerCase())) {
          updatedRows.add(row);
        }
      }
      setState(() {
        dataRows = updatedRows;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoctorPage(
      dataRows: dataRows,
      updateDataRows: updateDataRows,
      appointments: doctorAppointments,
    );
  }
}

class DoctorPage extends StatelessWidget {
  final List<Appointment> appointments;
  final List<DataRow> dataRows;
  final Function(String) updateDataRows;
  final FocusNode focusNode = FocusNode();

  DoctorPage(
      {Key? key,
      required this.dataRows,
      required this.updateDataRows,
      required this.appointments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.8,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(81, 168, 255, 60),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(34),
                    bottomRight: Radius.circular(34),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Appointments Overview',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.greenAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Today\'s Appointments',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      appointmentList.length.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Card(
                              color: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Remaining Appointments',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '3',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 56,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.8999999761581421)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: TextField(
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            onChanged: (value) {
                              final drHomeScreenState =
                                  context.findAncestorStateOfType<
                                      _DrHomeScreenState>();
                              if (drHomeScreenState != null) {
                                drHomeScreenState.updateDataRows(value);
                              }
                            },
                            decoration: const InputDecoration.collapsed(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Text(
                    'Appointment List',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        //
                        // DataTable(
                        //   columns: const [
                        //     DataColumn(label: Text('Patient Name')),
                        //     DataColumn(label: Text('Time')),
                        //     //DataColumn(label: Text('Edit')),
                        //   ],
                        //   rows: dataRows,
                        // ),

                        ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        Appointment appointment = appointments[index];
                        DateTime dateTime = appointment.date.toDate();
                        String formattedTime =
                            '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

                        return ListTile(
                          title: Text(appointment.patientName),
                          subtitle:
                              Text(formattedTime), // Display formatted time
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
