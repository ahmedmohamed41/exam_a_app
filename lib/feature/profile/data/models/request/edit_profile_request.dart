import '../../../domain/models/edit_profile_params.dart';

class EditProfileRequest {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  EditProfileRequest({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory EditProfileRequest.fromParams(EditProfileParams params) {
    return EditProfileRequest(
      username: params.username,
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      phone: params.phone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
  }
}
