import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_on_hand/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/appointment_model.dart';

class DoctorsHomeScreen extends StatefulWidget {
  const DoctorsHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorsHomeScreen> createState() => _DoctorsHomeScreenState();
}

class _DoctorsHomeScreenState extends State<DoctorsHomeScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return DoctorPaged(doctorAppointments);
  }
}

class DoctorPaged extends StatefulWidget {
  final List<Appointment> appointments;

  const DoctorPaged(this.appointments);

  @override
  State<DoctorPaged> createState() => _DoctorPagedState();
}

class _DoctorPagedState extends State<DoctorPaged> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
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
                    padding: EdgeInsets.only(top: 30),
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
                    child: Card(
                      color: Colors.blueAccent,
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
                              '${widget.appointments.length}',
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
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
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
            const Text(
              'Appointment List',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.appointments.length,
                itemBuilder: (context, index) {
                  Appointment appointment = widget.appointments[index];
                  DateTime dateTime = appointment.date.toDate();
                  String formattedTime =
                      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

                  String appointmentTime =
                      DateFormat('MMM dd, yyyy HH:mm a').format(dateTime);

                  // Check if the appointment's patient name matches the search query
                  bool isMatched = appointment.patientName
                      .toLowerCase()
                      .contains(searchText.toLowerCase());

                  if (searchText.isEmpty || isMatched) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Color.fromRGBO(81, 168, 255, 60),
                        // child: ListTile(
                        //
                        //   title: Text(appointment.patientName),
                        //   subtitle: Text(formattedTime), // Display formatted time
                        // ),
                        child: Container(
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Patient Name',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  verticalSpace(8),
                                  Text(
                                    appointment.patientName,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Appointment Time',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  verticalSpace(8),
                                  Text(
                                    appointmentTime,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    Container(
                      child: Center(
                        child: Text("No appointsments found"),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
