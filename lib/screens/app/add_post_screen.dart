import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lifegram/shared/constants/env_constants.dart';
import 'package:lifegram/widgets/bars/home_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _textEditingController = TextEditingController();

  XFile? _selectedImage;

  Future<void> _openImagePicker() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    print(selectedImage?.mimeType);
    print(selectedImage?.name);
    print(selectedImage?.path);
    setState(() {
      _selectedImage = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HomeAppBar(),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    _openImagePicker();
                  },
                  child: const Text("Select Image")),
            ),
            _selectedImage?.path != null
                ? (kIsWeb
                    ? Image.network(_selectedImage?.path ?? "")
                    : Image.file(File(_selectedImage?.path ?? "")))
                : const SizedBox(width: 0, height: 0),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: 'Enter Caption'),
            ),
            ElevatedButton(
                onPressed: () {
                  createNewPost();
                },
                child: const Text("Submit"))
          ],
        ));
  }

  createNewPost() async {
    try {
      if (_selectedImage != null) {
        var strm = _selectedImage?.openRead();
        var stream = http.ByteStream(DelegatingStream.typed(strm!));
        var length = await _selectedImage?.length();

        var uri = Uri.parse('${EnvConstants.apiUrl}/posts');

        var request = http.MultipartRequest("POST", uri);
        var multipartFile = http.MultipartFile('file', stream, length!,
            filename: _selectedImage?.name);

        request.files.add(multipartFile);

        request.fields['text'] = _textEditingController.text;

        var response = await request.send();

        print(response.statusCode);

        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
        });
      }
    } catch (error) {
      print("inside catch");
      print(error);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
