import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String doctorId;
  final String patientName;
  final Timestamp date;

  Appointment(
      {required this.doctorId, required this.patientName, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'patientName': patientName,
      'date': date,
    };
  }

  factory Appointment.fromSnapshot(DocumentSnapshot snapshot) {
    return Appointment(
      doctorId: snapshot['doctorId'] as String,
      patientName: snapshot['patientName'] as String,
      date: snapshot['date'] as Timestamp,
    );
  }

// List<Appointment> doctorAppointments = [
//   Appointment(
//       doctorId: 'doctor_id_1',
//       patientName: 'John Smith',
//       date: Timestamp.fromDate(DateTime(2023, 7, 20, 9, 30))),
//   Appointment(
//       doctorId: 'doctor_id_1',
//       patientName: 'Alice Johnson',
//       date: Timestamp.fromDate(DateTime(2023, 7, 20, 11, 45))),
//   // Add more appointments as needed
// ];
}

// Function to book an appointment with a specific doctor
Future<void> bookAppointment(
    Appointment appointment, String selectedDoctorId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Create a new document in the "appointments" collection
    DocumentReference appointmentRef =
        await firestore.collection('appointments').add(appointment.toMap());

    // Get the generated appointment ID
    String appointmentId = appointmentRef.id;

    print('Appointment booked with ID: $appointmentId');

    // Now, you can update the doctor's subcollection with the new appointment
    DocumentReference doctorRef =
        firestore.collection('doctors').doc(selectedDoctorId);
    await doctorRef
        .collection('appointments')
        .doc(appointmentId)
        .set(appointment.toMap());

    print('Appointment added to the doctor\'s subcollection.');
  } catch (e) {
    print('Error booking appointment: $e');
  }
}

// Example of booking an appointment with a selected doctor
void bookAppointmentWithSelectedDoctor() {
  // Replace these values with actual doctor and appointment details
  String selectedDoctorId =
      'doctor_id_1'; // Replace with the ID of the selected doctor
  String patientName = 'John Smith';
  Timestamp appointmentDate =
      Timestamp.now(); // Replace with the appointment date

  Appointment appointment = Appointment(
    doctorId: selectedDoctorId,
    patientName: patientName,
    date: appointmentDate,
  );

  bookAppointment(appointment, selectedDoctorId);
}
