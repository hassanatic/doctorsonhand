import 'package:flutter/material.dart';

class drhomescreen extends StatefulWidget {
  @override
  State<drhomescreen> createState() => _drhomescreenState();
}

class _drhomescreenState extends State<drhomescreen> {
  String patientName = '';
  late List<DataRow> dataRows;
  late List<DataRow> originalDataRows;

  @override
  void initState() {
    super.initState();
    dataRows = [
      DataRow(
        cells: [
          DataCell(Text('John Doe')),
          DataCell(Text('09:00 AM')),
          DataCell(Text('Check-up')),
          DataCell(Icon(Icons.check, color: Colors.green)),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('John Doe')),
          DataCell(Text('09:00 AM')),
          DataCell(Text('Check-up')),
          DataCell(Icon(Icons.check, color: Colors.green)),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('John Doe')),
          DataCell(Text('09:00 AM')),
          DataCell(Text('Check-up')),
          DataCell(Icon(Icons.check, color: Colors.green)),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('John Doe')),
          DataCell(Text('09:00 AM')),
          DataCell(Text('Check-up')),
          DataCell(Icon(Icons.check, color: Colors.green)),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('Jane Smith')),
          DataCell(Text('10:30 AM')),
          DataCell(Text('Follow-up')),
          DataCell(Icon(Icons.access_time, color: Colors.orange)),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('Jane Smith')),
          DataCell(Text('10:30 AM')),
          DataCell(Text('Follow-up')),
          DataCell(Icon(Icons.access_time, color: Colors.orange)),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('Jane Smith')),
          DataCell(Text('10:30 AM')),
          DataCell(Text('Follow-up')),
          DataCell(Icon(Icons.access_time, color: Colors.orange)),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('Jane Smith')),
          DataCell(Text('10:30 AM')),
          DataCell(Text('Follow-up')),
          DataCell(Icon(Icons.access_time, color: Colors.orange)),
        ],
      ),
      // Add more rows here
    ];

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
        if (row.cells[0].child.toString().toLowerCase().contains(name.toLowerCase())) {
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
    return DoctorPage(dataRows: dataRows, updateDataRows: updateDataRows);
  }
}

class DoctorPage extends StatelessWidget {
  final List<DataRow> dataRows;
  final Function(String) updateDataRows;

  const DoctorPage({Key? key, required this.dataRows, required this.updateDataRows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(


        appBar: AppBar(
          elevation: 0,
          title: const Text('Doctor App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle notifications button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Handle menu button press
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
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
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Today\'s Appointments',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '8',
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
                                      'Pending Requests',
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
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: TextField(
                            onChanged: (value) {
                              final drHomeScreenState = context.findAncestorStateOfType<_drhomescreenState>();
                              if (drHomeScreenState != null) {
                                drHomeScreenState.updateDataRows(value);
                              }
                            },
                            decoration: InputDecoration.collapsed(
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

             SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    const Text(

                      'Appointment List',
                      style: TextStyle(

                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Patient Name')),
                          DataColumn(label: Text('Time')),
                          DataColumn(label: Text('Reason')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: dataRows,
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
