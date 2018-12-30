class Routes {
  // ***** customer routes *****

  // Emulator Localhost IP
  // static const String CUSTOMER_LOGIN = 'http://10.0.2.2:3000/api/customer-login';
  // static const String CUSTOMER_REGISTER = 'http://10.0.2.2:3000/api/customer-register';
  // static const String CUSTOMER_REQUEST = 'http://10.0.2.2:3000/api/customer-request';

  // AWS Server
  static const String CUSTOMER_LOGIN = 'http://3.85.142.160/api/customer-login';
  static const String CUSTOMER_REGISTER = 'http://3.85.142.160/api/customer-register';
  static const String CUSTOMER_REQUEST = 'http://3.85.142.160/api/customer-request';


  // ***** truck driver routes *****

  // Emulator Localhost IP
  // static const String TRUCKER_LOGIN = 'http://10.0.2.2:3000/api/trucker-login';
  // static const String TRUCKER_REGISTER = 'http://10.0.2.2:3000/api/trucker-register';

  // AWS Server
  static const String TRUCKER_LOGIN = 'http://3.85.142.160/api/trucker-login';
  static const String TRUCKER_REGISTER = 'http://3.85.142.160/api/trucker-register';

  // headers
  static const Map<String, String> LOGIN_HEADER = {
    'Content-Type': 'application/json'
  };
}