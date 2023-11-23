import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Wireframe8 extends StatelessWidget {
  const Wireframe8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wireframe 8'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Wireframe 8'),
          ],
        ),
      ),
    );
  }
}

class Wireframe9 extends StatelessWidget {
  const Wireframe9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wireframe 9'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Wireframe 9'),
          ],
        ),
      ),
    );
  }
}

class Wireframe10 extends StatelessWidget {
  const Wireframe10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wireframe 10'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Wireframe 10'),
          ],
        ),
      ),
    );
  }
}

class Wireframe11 extends StatelessWidget {
  const Wireframe11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wireframe 11'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Wireframe 11'),
          ],
        ),
      ),
    );
  }
}

class Wireframe12 extends StatelessWidget {
  const Wireframe12({Key? key}) : super(key: key);

  Future<void> _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      // Do something with the image file

      // For example, you can navigate to a new page with the captured image
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CapturedImagePage(imageFile: imageFile)),
      );
    }
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      // Do something with the image file

      // For example, you can navigate to a new page with the selected image
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectedImagePage(imageFile: imageFile)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _getImageFromCamera(context),
              child: const Text('Capture Image'),
            ),
            ElevatedButton(
              onPressed: () => _getImageFromGallery(context),
              child: const Text('Choose Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class CapturedImagePage extends StatelessWidget {
  final File imageFile;

  const CapturedImagePage({Key? key, required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captured Image'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}

class SelectedImagePage extends StatelessWidget {
  final File imageFile;

  const SelectedImagePage({Key? key, required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Image'),
      ),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}

void main() {
  runApp(const CountMeIn());
}

class CountMeIn extends StatelessWidget {
  const CountMeIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CountMeIn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Wireframe8(),
        '/wireframe9': (context) => const Wireframe9(),
        '/wireframe10': (context) => const Wireframe10(),
        '/wireframe11': (context) => const Wireframe11(),
        '/wireframe12': (context) => const Wireframe12(),
      },
    );
  }
}
