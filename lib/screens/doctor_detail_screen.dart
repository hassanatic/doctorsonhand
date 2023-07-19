import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DoctorDetailsScreen extends StatefulWidget {
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
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  int selectedSlotIndex = -1;

late String timeSlot;
  late DateTime selectedDate;
  late List<String> timeSlots;


  @override
  void initState() {
    // TODO: implement initState
    selectedDate = DateTime.now().add(const Duration(days: 1)); // Start from tomorrow
    timeSlots = generateTimeSlots();
    super.initState();
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
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 7)),
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
          title: const Text('Appointment Confirmation'),
          content: Text(
            'Your appointment with ${widget.doctorName} on ${DateFormat('MMM d, yyyy').format(selectedDate)} at $timeSlot has been booked.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
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
        title: const Text('Doctors Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      image: AssetImage(widget.profileImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctorName,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.speciality,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          widget.ratings.toString(),
                          style: const TextStyle(
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
            const SizedBox(height: 16.0),
            const Text(
              'Bio:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.bio,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Other Specialities:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 60.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.otherSpecialities.length,
                itemBuilder: (context, index) {
                  final speciality = widget.otherSpecialities[index];
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
            const SizedBox(height: 16.0),
            const Text(
              'Select Appointment Date:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),

            Center(
              child: TextButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  '${DateFormat('MMM d, yyyy').format(selectedDate)}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),

            const SizedBox(height: 24.0),
            const Text(
              'Select Appointment Time:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),

            Container(
              height: 60.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  final slots = timeSlots[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          timeSlot = slots.toString();
                          selectedSlotIndex = index;
                        });
                      },
                      child: Card(
                        color: selectedSlotIndex == index ? const Color.fromRGBO(81, 168, 255, 60) : null, // Change color if selected
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(


                              child: Center(child: Text(slots))),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 35.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(


                  onPressed: (){

                  _selectTimeSlot(timeSlot);
                       },
                  style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(81, 168, 255, 60),
                    shape: const StadiumBorder(),
                  ),



                  child: const Padding(
                    padding: EdgeInsets.only(top: 18,bottom: 18),
                    child: Center(child: Text('Book Appointment',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

