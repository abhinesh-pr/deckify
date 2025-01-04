import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart'; // Import the flip card package
import 'package:flutter_colorpicker/flutter_colorpicker.dart'; // Import color picker

class CreateFlashcardScreen extends StatefulWidget {
  @override
  _CreateFlashcardScreenState createState() => _CreateFlashcardScreenState();
}

class _CreateFlashcardScreenState extends State<CreateFlashcardScreen> {
  final _frontController = TextEditingController();
  final _backController = TextEditingController();
  final _categoryController = TextEditingController();  // New controller for category/topic
  final _formKey = GlobalKey<FormState>();

  Color _cardTextColor = Colors.black; // Default text color
  Color _cardBackgroundColor = Colors.grey[200] ?? Colors.grey; // Default background color

  @override
  void dispose() {
    _frontController.dispose();
    _backController.dispose();
    _categoryController.dispose();  // Dispose the category controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Flashcard"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Flashcard preview with GestureFlipCard
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: GestureFlipCard(
                        animationDuration: const Duration(milliseconds: 300),
                        axis: FlipAxis.vertical,
                        frontWidget: _buildFlashcardFront(),
                        backWidget: _buildFlashcardBack(),
                      ),
                    ),
                    SizedBox(height: 20),



                    // Icons for changing colors vertically
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildColorIcon(Icons.text_fields, "Text Color", _cardTextColor),
                        SizedBox(width: 20),
                        _buildColorIcon(Icons.brush, "Background Color", _cardBackgroundColor),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Flashcard category input
                    _buildTextField('Category/Topic', 'Enter Category or Topic', _categoryController),

                    SizedBox(height: 16),

                    // Flashcard front side input
                    _buildTextField('Question', 'Enter Question', _frontController),

                    SizedBox(height: 16),

                    // Flashcard back side input
                    _buildTextField('Answer', 'Enter Answer', _backController),

                    SizedBox(height: 16),

                    // Button to submit the flashcard
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Handle flashcard creation logic
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Flashcard Created')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14), backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('Create Flashcard', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create text fields
  // Helper method to create text fields
  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16), // Slightly smaller font size for label
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: hint,
            labelStyle: TextStyle(fontSize: 12), // Slightly smaller font size for label text
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Slightly reduced padding
          ),
          maxLines: 2,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a $label';
            }
            return null;
          },
          onChanged: (text) {
            setState(() {});
          },
        ),
      ],
    );
  }


  // Helper method for color icon buttons
  Widget _buildColorIcon(IconData icon, String colorType, Color currentColor) {
    return GestureDetector(
      onTap: () async {
        Color? selectedColor = await _showColorPicker(context, colorType);
        if (selectedColor != null) {
          setState(() {
            if (colorType == "Text Color") {
              _cardTextColor = selectedColor;
            } else {
              _cardBackgroundColor = selectedColor;
            }
          });
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8), // Reduced padding for smaller icons
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24, // Reduced icon size
            ),
          ),
          SizedBox(height: 8),
          Text(
            colorType == "Text Color" ? 'Text' : 'Background',
            style: TextStyle(fontSize: 14), // Reduced font size for label
          ),
        ],
      ),
    );
  }


  // Method to build the flashcard front
  Widget _buildFlashcardFront() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          color: _cardBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                _frontController.text.isEmpty ? "Enter Question" : _frontController.text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _cardTextColor,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Icon(
                Icons.compare_arrows_rounded,
                color: _cardTextColor,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build the flashcard back
  Widget _buildFlashcardBack() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          color: _cardBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                _backController.text.isEmpty ? "Enter Answer" : _backController.text,
                style: TextStyle(
                  fontSize: 16,
                  color: _cardTextColor,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Icon(
                Icons.compare_arrows_rounded,
                color: _cardTextColor,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show color picker
  Future<Color?> _showColorPicker(BuildContext context, String title) async {
    return showDialog<Color?>(
      context: context,
      builder: (BuildContext context) {
        Color initialColor = title == "Text Color" ? _cardTextColor : _cardBackgroundColor;

        return AlertDialog(
          title: Text('Select $title'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: initialColor,
              onColorChanged: (Color color) {
                setState(() {
                  if (title == "Text Color") {
                    _cardTextColor = color;
                  } else {
                    _cardBackgroundColor = color;
                  }
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Select'),
              onPressed: () {
                Navigator.of(context).pop(title == "Text Color" ? _cardTextColor : _cardBackgroundColor);
              },
            ),
          ],
        );
      },
    );
  }
}
