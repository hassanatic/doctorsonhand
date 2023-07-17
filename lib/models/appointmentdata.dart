import 'package:flutter/material.dart';


class Appointment {
  final String patientName;
  final String time;
  final String reason;
  final IconData statusIcon;
  final Color statusColor;

  Appointment({
    required this.patientName,
    required this.time,
    required this.reason,
    required this.statusIcon,
    required this.statusColor,
  });
}


List <Appointment> appointmentList = [
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
  Appointment(patientName: 'patientName', time: 'time', reason: 'reason', statusIcon: Icons.ice_skating, statusColor: Colors.orange),
];


