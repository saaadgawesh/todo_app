import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/localstorage/applocal.dart';
import 'package:todo_app/view/tabs/HomeScreen.dart';
import 'package:todo_app/view/widget/appthem.dart';
import 'package:todo_app/view/widget/defaultelevatedbotton.dart';
import 'package:todo_app/view/widget/defaulttextfield.dart';

class Loadimagename extends StatefulWidget {
  const Loadimagename({super.key});

  @override
  State<Loadimagename> createState() => _LoadimagenameState();
}

class _LoadimagenameState extends State<Loadimagename> {
  final controller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String? imagepath;
  String? name;

  @override
  void initState() {
    super.initState();

    // استرجاع الاسم من SharedPreferences
    Applocal.getdata(Applocal.namekey).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          name = value;
          controller.text = name!;
        });
      }
    });

    // استرجاع الصورة من SharedPreferences
    Applocal.getdata(Applocal.imagekey).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          imagepath = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appthem.primary,
      body: Form(
        key: formkey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundImage:
                    (imagepath != null && imagepath!.isNotEmpty)
                        ? FileImage(File(imagepath!))
                        : const AssetImage('assets/1.png') as ImageProvider,
              ),
              const SizedBox(height: 15),
              Defaulttextfield(
                controller: controller,
                label: 'Enter your name',
                onChanged: (value) {
                  name = value;
                },
              ),
              const SizedBox(height: 15),
              DefaultElevatedButton(
                label: 'Choose from Files',
                onpress: () {
                  pickImageFromFiles();
                },
              ),
              const SizedBox(height: 15),
              DefaultElevatedButton(
                label: 'Done',
                onpress: () async {
                  final currentName = name ?? '';

                  if (formkey.currentState!.validate() == true) {
                    await Applocal.savedata(currentName, Applocal.namekey);
                    await Applocal.savedata(imagepath!, Applocal.imagekey);

                    if (context.mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const Homescreen()),
                      );
                    } else if (imagepath == null ||
                        imagepath!.isEmpty ||
                        currentName.isEmpty) {
                      // تخزين الاسم والصورة بشكل منفصل
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'Please choose an image and name before saving!',
                            ),
                          ),
                        );
                      }
                      // الانتقال للصفحة التالية
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة اختيار صورة من أي مكان على الجهاز
  Future<void> pickImageFromFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'svg',
        'jpeg',
        'mp4',
        'mov',
        'mb3',
        'pdf',
        'doc',
        'txt',
        'wav',
      ],
    );

    if (result != null &&
        result.files.single.path != null &&
        result.files.single.path!.isNotEmpty) {
      setState(() {
        imagepath = result.files.single.path!;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No valid file selected!')));
    }
  }
}
