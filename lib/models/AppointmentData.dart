import 'package:flutter/material.dart';


class Appointment {
  final String patientName;
  final String time;


  Appointment({
    required this.patientName,
    required this.time,

  });
}


List <Appointment> appointmentList = [
  Appointment(patientName: 'patientName', time: 'time',),
  Appointment(patientName: 'patientName', time: 'time',),
  Appointment(patientName: 'patientName', time: 'time',),
  Appointment(patientName: 'patientName', time: 'time',),

];


