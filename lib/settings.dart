class Routes {
  // ***** customer routes *****

  // Emulator Localhost IP
  // static const String CUSTOMER_LOGIN = 'http://10.0.2.2:3000/api/customer-login';
  // static const String CUSTOMER_REGISTER = 'http://10.0.2.2:3000/api/customer-register';
  // static const String CUSTOMER_UPDATE_PROFILE = 'http://10.0.2.2:3000/api/customer-update-profile';
  // static const String CUSTOMER_CHANGE_PASSWORD = 'http://10.0.2.2:3000/api/customer-change-password';
  // static const String CUSTOMER_REQUEST = 'http://10.0.2.2:3000/api/customer-request';
  // static const String CUSTOMER_VIEW_ORDERS = 'http://10.0.2.2:3000/api/customer-view-orders';

  // AWS Server
  static const String CUSTOMER_LOGIN = 'http://3.80.138.224/api/customer-login';
  static const String CUSTOMER_REGISTER = 'http://3.80.138.224/api/customer-register';
  static const String CUSTOMER_UPDATE_PROFILE = 'http://3.80.138.224/api/customer-update-profile';
  static const String CUSTOMER_CHANGE_PASSWORD = 'http://3.80.138.224/api/customer-change-password';
  static const String CUSTOMER_REQUEST = 'http://3.80.138.224/api/customer-request';
  static const String CUSTOMER_VIEW_ORDERS = 'http://3.80.138.224/api/customer-view-orders';

  // ***** truck driver routes *****

  // Emulator Localhost IP
  // static const String TRUCKER_LOGIN = 'http://10.0.2.2:3000/api/trucker-login';
  // static const String TRUCKER_REGISTER = 'http://10.0.2.2:3000/api/trucker-register';
  // static const String TRUCKER_UPDATE_PROFILE = 'http://10.0.2.2:3000/api/trucker-update-profile';
  // static const String TRUCKER_CHANGE_PASSWORD = 'http://10.0.2.2:3000/api/trucker-change-password';
  // static const String TRUCKER_VIEW_ORDERS = 'http://10.0.2.2:3000/api/trucker-view-orders';

  // AWS Server
  static const String TRUCKER_LOGIN = 'http://3.80.138.224/api/trucker-login';
  static const String TRUCKER_REGISTER = 'http://3.80.138.224/api/trucker-register';
  static const String TRUCKER_UPDATE_PROFILE = 'http://3.80.138.224/api/trucker-update-profile';
  static const String TRUCKER_CHANGE_PASSWORD = 'http://3.80.138.224/api/trucker-change-password';
  static const String TRUCKER_VIEW_ORDERS = 'http://3.80.138.224/api/trucker-view-orders';

  // headers
  static const Map<String, String> LOGIN_HEADER = {
    'Content-Type': 'application/json'
  };
}