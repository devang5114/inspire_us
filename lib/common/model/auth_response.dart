class AuthResponse {
  final String? authToken;
  final int? forgetPassWordOtp;
  final bool? isEmailVerified;
  final int? registerCode;
  final String? error;
  final String? successMessage;

  AuthResponse(
      {this.authToken,
      this.successMessage,
      this.isEmailVerified,
      this.forgetPassWordOtp,
      this.registerCode,
      this.error});
  @override
  String toString() {
    return 'authToken:$authToken,successMessage: $successMessage forgetPassWord Otp : $forgetPassWordOtp isEmailVerified: $isEmailVerified registercode:$registerCode error :$error';
  }
}
