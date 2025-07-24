import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/componant/myTextFeild.dart';
import 'package:legal_app/view/homePage.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'User'),
              Tab(text: 'Lawyer'),
              Tab(text: 'Representative'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StepForm(role: 'user'),
            StepForm(role: 'lawyer'),
            StepForm(role: 'representative'),
          ],
        ),
      ),
    );
  }
}

class StepForm extends StatefulWidget {
  final String role;
  StepForm({required this.role});

  @override
  _StepFormState createState() => _StepFormState();
}

class _StepFormState extends State<StepForm> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          bool isValid = _formKey.currentState!.validate();
          if (isValid) {
            if (_currentStep < getSteps().length - 1) {
              setState(() => _currentStep++);
            } else {
              // Submit form
              print("✅ Form Submitted");
              _controllers.forEach((key, controller) {
                print('$key: ${controller.text}');
              });
              Get.to(HomePage(userInfo: {}));
            }
          } else {
            print('Form validation failed');
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        steps: getSteps(),
      ),
    );
  }

  List<Step> getSteps() {
    final List<String> fields = getFormFieldsByRole(widget.role);
    final int chunkSize = 5;
    List<Step> steps = [];

    for (int i = 0; i < fields.length; i += chunkSize) {
      final chunk = fields.skip(i).take(chunkSize).toList();
      steps.add(
        Step(
          title: Text('Step ${(i ~/ chunkSize) + 1}'),
          content: Column(
            children: chunk.map((field) => buildField(field)).toList(),
          ),
          isActive: true,
        ),
      );
    }

    return steps;
  }

  List<String> getFormFieldsByRole(String role) {
    List<String> commonFields = [
      'Profile Image',
      'Name',
      'Email',
      'Password',
      'Address',
      'Birthdate',
      'Birthplace',
      'National Number',
      'Gender',
      'Phone',
    ];

    List<String> userExtra = ['Address', 'Agencies', 'Issues'];
    List<String> lawyerExtra = [
      'Address',
      'Union Branch',
      'Union Number',
      'Affiliation Date',
      'Years of Experience',
      'Description',
      'Role',
    ];
    List<String> repExtra = [
      'Union Branch',
      'Union Number',
      'Affiliation Date',
      'Agencies',
    ];

    List<String> allFields = List.from(commonFields);

    if (role == 'user') {
      allFields.addAll(userExtra);
    } else if (role == 'lawyer') {
      allFields.addAll(lawyerExtra);
    } else if (role == 'representative') {
      allFields.addAll(repExtra);
    }

    return allFields;
  }

  Widget buildField(String label) {
    _controllers.putIfAbsent(label, () => TextEditingController());

    if (label == 'Profile Image') {
      return ProfileImagePicker();
    }

    if (label.contains('Date')) {
      return TextFormField(
        controller: _controllers[label],
        decoration: InputDecoration(labelText: label),
        readOnly: true,
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            _controllers[label]!.text = picked.toIso8601String().split('T')[0];
            setState(() {});
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required';
          }
          return null;
        },
      );
    }

    if (label == 'Gender') {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label),
        value:
            _controllers[label]!.text.isEmpty
                ? null
                : _controllers[label]!.text,
        items:
            ['Male', 'Female']
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
        onChanged: (value) {
          _controllers[label]!.text = value!;
          setState(() {});
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required';
          }
          return null;
        },
      );
    }

    return MyTextFeild(
      text: label,
      obscureText: label.toLowerCase().contains("password"),
      icon: Icon(Icons.person),
      controller: _controllers[label]!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ProfileImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/default_avatar.png'),
        ),
        IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            // Image picker logic here
          },
        ),
      ],
    );
  }
}
