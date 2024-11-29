

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class VisitorDetails extends StatefulWidget {
  const VisitorDetails({super.key});

  @override
  _VisitorDetailsState createState() => _VisitorDetailsState();
}

class _VisitorDetailsState extends State<VisitorDetails> {
  // Step tracking variable
  int _currentStep = 0;

  // Stepper steps list
  List<Step> get steps => [
    Step(
      title: const Text('Personal Information'),
      content: _buildPersonalInfoForm(),
      isActive: _currentStep >= 0,
      state: _currentStep > 0 ? StepState.complete : StepState.indexed,
    ),
    Step(
      title: const Text('Appointment Details'),
      content: _buildAppointmentForm(),
      isActive: _currentStep >= 1,
      state: _currentStep > 1 ? StepState.complete : StepState.indexed,
    ),
    Step(
      title: const Text('Confirmation'),
      content: _buildConfirmationStep(),
      isActive: _currentStep >= 2,
      state: _currentStep > 2 ? StepState.complete : StepState.indexed,
    ),
  ];

  // Text Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Variable to hold the selected purpose
  String? _selectedPurpose;

  // List of purposes for the dropdown
  final List<String> _purposes = [
    'Business',
    'Personal',
    'Medical',
    'Education',
    'Other',
  ];

  // Form Keys
  final GlobalKey<FormState> _personalInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _appointmentFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  // Continue to next step
  void _continueToNextStep() {
    if (_currentStep < steps.length - 1) {
      // Validate current step before moving
      bool isStepValid = _validateCurrentStep();
      
      if (isStepValid) {
        setState(() {
          _currentStep += 1;
        });
      }
    }
  }

  // Go back to previous step
  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  // Validate current step
  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _personalInfoFormKey.currentState?.validate() ?? false;
      case 1:
        return _appointmentFormKey.currentState?.validate() ?? false;
      default:
        return true;
    }
  }

  // Submit form
  void _submitForm() {
    if (_validateCurrentStep()) {
      // Perform submission logic
      _showConfirmationDialog();
    }
  }

  // Show confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Visitor Registration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Name: ${_nameController.text}'),
            Text('Email: ${_emailController.text}'),
            Text('Phone: ${_phoneController.text}'),
            Text('Date: ${_dateController.text}'),
            Text('Time: ${_timeController.text}'),
            Text('Purpose: ${_selectedPurpose ?? "Not specified"}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Reset or navigate as needed
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Registration'),
        centerTitle: true,
      ),
      body: Center(
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: _continueToNextStep,
          onStepCancel: _goToPreviousStep,
          steps: steps,
          controlsBuilder: (context, details) {
            return Row(
              children: [
                if (_currentStep < steps.length - 1)
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: const Text('Continue'),
                  ),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
                if (_currentStep == steps.length - 1)
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Personal Information Form
  Widget _buildPersonalInfoForm() {
    return Form(
      key: _personalInfoFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              // Add email validation regex if needed
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Phone Number'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Appointment Details Form
  Widget _buildAppointmentForm() {
    return Form(
      key: _appointmentFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: 'Appointment Date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                _dateController.text = 
                  "${picked.day}/${picked.month}/${picked.year}";
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a date';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _timeController,
            decoration: const InputDecoration(
              labelText: 'Appointment Time',
              suffixIcon: Icon(Icons.access_time),
            ),
            onTap: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) {
                _timeController.text = picked.format(context);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a time';
              }
              return null;
            },
          ),
          // Dropdown for Purpose of Visit
          DropdownButtonFormField<String>(
            value: _selectedPurpose,
            hint: const Text('Select Purpose of Visit'),
            items: _purposes.map((String purpose) {
              return DropdownMenuItem<String>(
                value: purpose,
                child: Text(purpose),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedPurpose = newValue;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select the purpose of your visit';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  // Confirmation Step
  Widget _buildConfirmationStep() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Please confirm your details:'),
          ListTile(
            title: const Text('Full Name'),
            subtitle: Text(_nameController.text),
          ),
          ListTile(
            title: const Text('Email'),
            subtitle: Text(_emailController.text),
          ),
          ListTile(
            title: const Text('Phone Number'),
            subtitle: Text(_phoneController.text),
          ),
          ListTile(
            title: const Text('Appointment Date'),
            subtitle: Text(_dateController.text),
          ),
          ListTile(
            title: const Text('Appointment Time'),
            subtitle : Text(_timeController.text),
          ),
          ListTile(
            title: const Text('Purpose of Visit'),
            subtitle: Text(_selectedPurpose ?? "Not specified"),
          ),
        ],
      ),
    );
  }
}