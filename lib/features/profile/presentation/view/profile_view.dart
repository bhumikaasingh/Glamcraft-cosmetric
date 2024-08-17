import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../Orders/presentation/view/order_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _profileImagePath = 'assets/images/Profile.jpeg';
  String _name = 'Bhumika Singh';
  String _email = 'bhumi@gmail.com';
  String _location = 'Kathmandu';
  String _phoneNumber = '+977-9835445327';

  void _updateProfile(String name, String email, String location,
      String phoneNumber, String imagePath) {
    setState(() {
      _name = name;
      _email = email;
      _location = location;
      _phoneNumber = phoneNumber;
      _profileImagePath = imagePath;
    });
  }

  void _logout(BuildContext context) {
    // Navigate to the SignInView page after logout
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignInView()),
    );
  }

  void _viewOrders(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              OrderListView()), // Adjust this to your OrderViewPage route
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundImage: _profileImagePath.startsWith('assets')
                    ? AssetImage(_profileImagePath) as ImageProvider
                    : FileImage(File(_profileImagePath)),
              ),
              const SizedBox(height: 12),
              Text(
                _name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _email,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey.shade400),

              // Info Section
              const SizedBox(height: 16),
              InfoCard(
                icon: Icons.phone,
                title: 'Phone',
                value: _phoneNumber,
              ),
              InfoCard(
                icon: Icons.location_on,
                title: 'Location',
                value: _location,
              ),
              const InfoCard(
                icon: Icons.reviews,
                title: 'My Reviews',
                value: 'January 2020',
              ),

              const SizedBox(height: 16),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        name: _name,
                        email: _email,
                        location: _location,
                        phoneNumber: _phoneNumber,
                        profileImagePath: _profileImagePath,
                        onSave: _updateProfile,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                    const Text('Edit Profile', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 10),

              // My Orders Button
              ElevatedButton(
                onPressed: () => _viewOrders(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('My Orders', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 10),

              // Logout Button
              ElevatedButton(
                onPressed: () {
                  _logout(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Logout', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String location;
  final String phoneNumber;
  final String profileImagePath;
  final Function(String, String, String, String, String) onSave;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.location,
    required this.phoneNumber,
    required this.profileImagePath,
    required this.onSave,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;
  late TextEditingController _phoneNumberController;
  late String _profileImagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _locationController = TextEditingController(text: widget.location);
    _phoneNumberController = TextEditingController(text: widget.phoneNumber);
    _profileImagePath = widget.profileImagePath;
  }

  Future<void> _changeProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  void _saveProfile() {
    widget.onSave(
      _nameController.text,
      _emailController.text,
      _locationController.text,
      _phoneNumberController.text,
      _profileImagePath,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image Section
            GestureDetector(
              onTap: _changeProfileImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _profileImagePath.startsWith('assets')
                    ? AssetImage(_profileImagePath) as ImageProvider
                    : FileImage(File(_profileImagePath)),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap to change profile image',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Email Field (Editable)
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Location Field
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Phone Number Field
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            // Save Changes Button
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Save Changes', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 28),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('Sign In Page'),
      ),
    );
  }
}
