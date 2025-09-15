import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _image_file;

  // image picker
  Future pickimage() async {
    // picker
    final ImagePicker picker = ImagePicker();

    // pick from gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // update image preview
    if (image != null) {
      setState(() {
        _image_file = File(image.path);
      });
    }
  }

  // upload
  Future uploadimage() async {
    if (_image_file == null) return;

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName';

    await Supabase.instance.client.storage
        .from('images')
        .upload(path, _image_file!)
        .then(
          (value) => ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Image upload successful!'))),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Upload Page')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              _image_file != null ? Image.file(_image_file!) : Text('No Image'),

              SizedBox(height: 20),
              ElevatedButton(onPressed: pickimage, child: Text('Pick Image')),

              SizedBox(height: 20),
              ElevatedButton(onPressed: uploadimage, child: Text('Upload')),
            ],
          ),
        ),
      ),
    );
  }
}
