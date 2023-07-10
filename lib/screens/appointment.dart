import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorAppointmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Appointment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppointmentScreen(),
    );
  }
}

class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Appointment'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildDoctorCard(
            'Dr. John Smith',
            'Cardiologist',
            'assets/images/doctor1.png',
            4.2,
            'a dentist',
            ['cardiologist', 'orthodologist'],
            context,
          ),
          SizedBox(height: 16.0),
          _buildDoctorCard(
            'Dr. Emily Davis',
            'Dermatologist',
            'assets/images/doctor1.png',
            4.2,
            'a dentist',
            ['cardiologist', 'orthodologist'],
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(
      String name,
      String specialty,
      String imagePath,
      double rating,
      String bio,
      List<String> otherSpecialites,
      BuildContext context,
      ) {
    return InkWell(
      onTap: () {
        // Handle doctor card tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(doctorName: name,speciality: specialty, profileImage: imagePath,ratings: rating,bio: bio,otherSpecialities: otherSpecialites,),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 80.0,
                height: 80.0,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      specialty,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






class DoctorDetailsScreen extends StatelessWidget {
  final String doctorName;
  final String speciality;
  final String bio;
  final double ratings;
  final String profileImage;
  final List<String> otherSpecialities;

  DoctorDetailsScreen({
    required this.doctorName,
    required this.speciality,
    required this.bio,
    required this.ratings,
    required this.profileImage,
    required this.otherSpecialities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(profileImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      speciality,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          ratings.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Bio:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              bio,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Other Specialities:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 80.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: otherSpecialities.length,
                itemBuilder: (context, index) {
                  final speciality = otherSpecialities[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(speciality)),
                      ),
                    ),
                  );
                },
              ),
            ),

            TextButton(onPressed: (){Navigator.of(context).push(
                MaterialPageRoute(
                builder: (context) => AppointmentBookingScreen(doctorName)));}, child: Center(child: Text('Book Appointment'),))
          ],
        ),
      ),
    );
  }
}

class AppointmentBookingScreen extends StatefulWidget {
  final String doctorName;

  AppointmentBookingScreen(this.doctorName);

  @override
  _AppointmentBookingScreenState createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  late DateTime selectedDate;
  late List<String> timeSlots;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now().add(Duration(days: 1)); // Start from tomorrow
    timeSlots = generateTimeSlots();
  }

  List<String> generateTimeSlots() {
    // Logic to generate time slots based on your requirements
    // You can replace this with your own implementation

    List<String> slots = [];
    final int interval = 30; // Appointment duration interval in minutes
    final int startHour = 9; // Start hour of the day
    final int endHour = 18; // End hour of the day

    DateTime currentTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startHour);
    DateTime endTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, endHour);

    while (currentTime.isBefore(endTime)) {
      String formattedTime = DateFormat('hh:mm a').format(currentTime);
      slots.add(formattedTime);

      currentTime = currentTime.add(Duration(minutes: interval));
    }

    return slots;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        timeSlots = generateTimeSlots(); // Update time slots when date is changed
      });
    }
  }

  void _selectTimeSlot(String timeSlot) {
    // Handle time slot selection
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Confirmation'),
          content: Text(
            'Your appointment with ${widget.doctorName} on ${DateFormat('MMM d, yyyy').format(selectedDate)} at $timeSlot has been booked.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Appointment Date:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                '${DateFormat('MMM d, yyyy').format(selectedDate)}',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'Select Appointment Time:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  final timeSlot = timeSlots[index];
                  return ListTile(
                    title: Text(timeSlot),
                    onTap: () {
                      _selectTimeSlot(timeSlot);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}