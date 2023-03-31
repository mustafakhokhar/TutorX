import 'package:flutter/material.dart';

class FindTutorScreenInPerson extends StatefulWidget {
  const FindTutorScreenInPerson({Key? key}) : super(key: key);

  @override
  _FindTutorScreenState createState() => _FindTutorScreenState();
}

class _FindTutorScreenState extends State<FindTutorScreenInPerson> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  String _selectedSubject = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF928989).withOpacity(0.7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                'In-Person Tuition',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Select your location',
                  hintStyle: TextStyle(color: Colors.white54),
                  fillColor: Colors.white12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedSubject,
                items: [
                  DropdownMenuItem(
                      child: Text("Choose your subject"), value: ''),
                  // Add more subjects here
                  DropdownMenuItem(child: Text("Math"), value: 'Math'),
                  DropdownMenuItem(child: Text("Science"), value: 'Science'),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedSubject = value!;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                hint: Text(
                  'Choose your subject',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _topicController,
                decoration: InputDecoration(
                  hintText: 'Enter your topic',
                  hintStyle: TextStyle(color: Colors.white54),
                  fillColor: Colors.white12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement find tutor functionality here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFF2FF53),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 16),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: Text(
                    'Find Tutor',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
