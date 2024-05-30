class Endpoints {
  
  static const site_url = 'http://webapi.malikopal.com/api/';
 

  static const uploadPicUrl =
      'http://portal.malikopal.com/Home/UpdateProfileImage';
     

  static const profilePicUrl =
     
      'http://portal.malikopal.com/Content/Client/ProfileImages/';

  static const profilePicReqUrl =

      ///Content/Client/ProfileImages/
      'http://portal.malikopal.com/Content/Client/ProfileImages/';
     
  static const noProfilePicUrl =
      'http://portal.malikopal.com/Content/Client/img-blue/no-photo.png';
  // static const galleryPicUrl =
  
  static String rollerOverStatus = "dashboard/allrollover-get";

  static String transferdata = "dashboard/transferrollover-get";

  static String autoRollerOver = "dashboard/auto-rollover-get";

  static String postAutoRollover = "dashboard/auto-rollover-post";

  // static String GetGalleryUrl(String name) {
  //   if (name.isNotEmpty)
  //     return galleryPicUrl + name;
  //   else
  //     return noProfilePicUrl;
  // }

  static const LoginUrl = 'account/login';
  static const OtpUrl = "account/sendotp";
  static const VerifyOtpUrl = "account/verify-otp";
  static const sendOtp = "account/request-reset-password-code?UserID=";
  static const verifyPassword = "account/verify-reset-password-code?UserID=";

  static const UserLogoutUrl = 'account/logout';
  static const ChangePasswordUrl = 'account/change-password';

  static const ActivateThumbUrl = 'account/thumb-activate';
  static const LoginByThumbUrl = 'account/thumb-login';

  static const DashboardDataUrl = 'dashboard/data';
  static const RatioUrl = 'dashboard/closing-ratio-data';

  static const SaveWithDrawUrl = "dashboard/save-withdraw";
  static const WithdrawDataUrl = "dashboard/withdraw-data";

  static const widthdrawget = "dashboard/withdraw-get";
  static const subRefenceApi = "dashboard/current-user-plus-members-list";
  static const subRefenceUseranyApi = "dashboard/any-user-members-list";

  static const SaveProfileUrl = "dashboard/save-profile";
  static const ProfileDataUrl = "dashboard/profile-request";
  static const ProfileViewDataUrl = "dashboard/profile";

  static const SaveBankUrl = "dashboard/save-bank";
  static const BankDataUrl = "dashboard/bank-data";

  static const SavePaymeyRolloverUrl = "dashboard/save-payment";
  static const SaveRolloverUrl = "dashboard/save-rollover";
  static const PaymentRolloverDataUrl = "dashboard/payment-data";

  static const PaymentRolloverHistoryUrl = "dashboard/payment-history";
  static const LastAddAmountHistoryUrl = "dashboard/last-amountadded-history";
  static const NotificationUrl = "dashboard/notifications";

  static const CapitalHistoryUrl = "dashboard/capital-history";
  static const ReceivedAmountUrl = "dashboard/received-amount";

  static const SaveReferenceInUrl = "dashboard/current-user-members-list";

  static const MessageHistoryUrl = "dashboard/message-history";
  static const SaveMessageUrl = "dashboard/save-message";
  static const galleryUrl = "dashboard/gallery";
}
