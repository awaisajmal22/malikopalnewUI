import 'package:intl/intl.dart';

class Constant {
  static final currencyFormat = new NumberFormat("#,##0.0", "en_US");
  static final currencyFormatWithoutDecimal =
      new NumberFormat("#,##0", "en_US");
  static const TITLE_FORGOT_PASS = "account.passwordrecovery";
  static const TITLE_CHANGE_PASS = "account.changepassword";
  static const TITLE_REGISTER = "pagetitle.register";
  static const TITLE_REVIEW = "reviews";
  static const TITLE_MY_REVIEW = "pagetitle.customerproductreviews";
  static const TITLE_ORDER_DETAILS = "pagetitle.orderdetails";
  static const TITLE_ORDER_SHIPMENT_DETAILS = "pagetitle.shipmentdetails";
  static const TITLE_SEARCH = "pagetitle.search";
  static const TITLE_ACCOUNT = "pagetitle.account";

  static const HOME_NAV_HOME = "common.home";
  static const HOME_NAV_CATEGORY = "nopstation.webapi.common.category";
  static const HOME_NAV_SEARCH = "common.search";
  static const HOME_NAV_ACCOUNT = "nopstation.webapi.common.account";
  static const HOME_NAV_MORE = "nopstation.webapi.common.more";

  static const HOME_MANUFACTURER = "manufacturers";
  static const HOME_FEATURED_PRODUCT = "homepage.products";
  static const HOME_BESTSELLER = "bestsellers";
  static const HOME_OUR_CATEGORIES = "nopstation.webapi.home.ourcategories";

  static const CHANGE_PASS_BTN = "account.changepassword.button";
  static const CHANGE_PASS_OLD = "account.changepassword.fields.oldpassword";
  static const CHANGE_PASS_OLD_REQ =
      "account.changepassword.fields.oldpassword.required";
  static const CHANGE_PASS_NEW = "account.changepassword.fields.newpassword";
  static const CHANGE_PASS_NEW_REQ =
      "account.changepassword.fields.confirmnewpassword.required";
  static const CHANGE_PASS_CONFIRM =
      "account.changepassword.fields.confirmnewpassword";
  static const CHANGE_PASS_CONFIRM_REQ =
      "account.changepassword.fields.confirmnewpassword.required";
  static const CHANGE_PASS_MISMATCH =
      "account.changepassword.fields.newpassword.enteredpasswordsdonotmatch";

  static const FORGOT_PASS_BTN =
      "account.passwordrecovery.changepasswordbutton";
  static const FORGOT_PASS_EMAIL = "account.passwordrecovery.email";
  static const FORGOT_PASS_EMAIL_REQ =
      "account.passwordrecovery.email.required";

  static const REVIEW_WRITE = "reviews.write";
  static const REVIEW_HELPFUL = "reviews.helpfulness.washelpful?";
  static const REVIEW_TITLE = "reviews.fields.title";
  static const REVIEW_TITLE_REQ = "reviews.fields.title.required";
  static const REVIEW_TEXT = "reviews.fields.reviewtext";
  static const REVIEW_TEXT_REQ = "reviews.fields.reviewtext.required";
  static const REVIEW_SUBMIT_BTN = "reviews.submitbutton";
  static const REVIEW_RATING = "reviews.fields.rating";
  static const REVIEW_NO_DATA = "account.customerproductreviews.norecords";
  static const REVIEW_DATE = "reviews.date";

  static const SETTINGS_URL = "nopstation.webapi.settings.nopcommerceurl";
  static const SETTINGS_LANGUAGE = "nopstation.webapi.settings.language";
  static const SETTINGS_CURRENCY = "nopstation.webapi.settings.currency";
  static const SETTINGS_THEME = "nopstation.webapi.settings.darktheme";
  static const SETTINGS_INconstID_URL =
      "nopstation.webapi.settings.inconstidurl";
  static const SETTINGS_BTN_TEST = "nopstation.webapi.settings.test";
  static const SETTINGS_BTN_SET_DEFAULT =
      "nopstation.webapi.settings.setdefault";
  static const SETTINGS_BASE_URL_CHANGE_FAIL =
      "nopstation.webapi.settings.baseUrl_fail";

  static const ENTER_constID_EMAIL =
      "nopstation.webapi.common.enterconstidemail";
  static const ENTER_PRICE =
      "nopstation.webapi.shoppingcart.donation.enterprice";
  static const ENTER_PRICE_REQ =
      "nopstation.webapi.shoppingcart.donation.enterprice.required";

  static const LOGIN_EMAIL = "account.login.fields.email";
  static const LOGIN_EMAIL_REQ = "account.login.fields.email.required";
  static const LOGIN_PASS = "account.login.fields.password";
  static const LOGIN_PASS_REQ = "nopstation.webapi.login.password.required";
  static const LOGIN_NEW_CUSTOMER = "account.login.newcustomer";
  static const LOGIN_FORGOT_PASS = "account.login.forgotpassword";
  static const LOGIN_LOGIN_BTN = "account.login.loginbutton";
  static const LOGIN_OR = "nopstation.webapi.login.or";
  static const LOGIN_LOGIN_WITH_FB = "nopstation.webapi.loginwithfb";

  static const REWARD_NO_HISTORY = "rewardpoints.nohistory";
  static const REWARD_POINT_DATE = "rewardpoints.fields.createddate";
  static const REWARD_POINT_END_DATE = "rewardpoints.fields.enddate";
  static const REWARD_POINT_MSG = "rewardpoints.fields.message";
  static const REWARD_POINT_ = "rewardpoints.fields.points";
  static const REWARD_POINT_BALANCE = "rewardpoints.fields.pointsbalance";
  static const REWARD_POINT_BALANCE_MIN = "rewardpoints.minimumbalance";
  static const REWARD_POINT_BALANCE_CURRENT = "rewardpoints.currentbalance";

  static const ORDER_NUMBER = "account.customerorders.ordernumber";
  static const ORDER_STATUS = "account.customerorders.orderstatus";
  static const ORDER_TOTAL = "account.customerorders.ordertotal";
  static const ORDER_DATE = "account.customerorders.orderdate";
  static const ORDER_PRICE = "order.product(s).price";
  static const ORDER_QUANTITY = "order.product(s).quantity";
  static const ORDER_TOTAL_ = "order.product(s).sku";
  static const ORDER_REORDER = "order.reorder";
  static const ORDER_PDF_INVOICE = "order.getpdfinvoice";
  static const ORDER_NOTES = "order.notes";
  static const ORDER_RETURN_ITEMS = "order.returnitems";
  static const ORDER_REWARD_POINTS = "order.rewardpoints";
  static const ORDER_SHIPPING_STATUS = "order.shipping.status";

  static const ORDER_RETRY_PAYMENT = "order.retrypayment";
  static const ORDER_SHIPMENT = "order.shipments";
  static const ORDER_SHIPMENT_ID = "order.shipments.id";
  static const ORDER_DATE_SHIPPED = "order.shipments.shippeddate";
  static const ORDER_DATE_DELIVERED = "order.shipments.deliverydate";
  static const SHIPMENT_TRACKING_NUMBER = "order.shipments.trackingnumber";

  static const RETURN_ID = "account.customerreturnrequests.title";
  static const RETURNED_ITEM = "account.customerreturnrequests.item";
  static const RETURN_REASON = "account.customerreturnrequests.reason";
  static const RETURN_ACTION = "returnrequests.returnaction";
  static const RETURN_DATE_REQUESTED = "account.customerreturnrequests.date";
  static const RETURN_UPLOADED_FILE =
      "account.customerreturnrequests.uploadedfile";

  static const RETURN_REQ_UPLOAD = "returnrequests.uploadedfile";
  static const RETURN_REQ_UPLOAD_FILE = "common.fileuploader.upload";
  static const RETURN_REQ_SUBMIT = "returnrequests.submit";
  static const RETURN_REQ_COMMENTS = "returnrequests.comments";
  static const RETURN_REQ_REASON = "returnrequests.returnreason";
  static const RETURN_REQ_ACTION = "returnrequests.returnaction";
  static const RETURN_REQ_TITLE_WHY = "returnrequests.whyreturning";
  static const RETURN_REQ_TITLE_WHICH_ITEM = "returnrequests.selectproduct(s)";
  static const RETURN_REQ_RETURN_QTY = "returnrequests.products.quantity";

//        static const RETURN_REQ_ =;

  static const SKU = "products.sku";
  static const ORDER_QUANTITY_SHIPPED = "order.shipments.product(s).quantity";
  static const ORDER_NO_DATA = "account.customerorders.noorders";

  static const CATALOG_ITEMS_PER_PAGE = "catalog.pagesize.label";
  static const CATALOG_ORDER_BY = "catalog.orderby";

  static const MORE_SCAN_BARCODE = "nopstation.webapi.scanbarcode";
  static const MORE_SETTINGS = "nopstation.webapi.settings";
  static const MORE_PRIVACY_POLICY = "nopstation.webapi.privacypolicy";
  static const MORE_ABOUT_US = "nopstation.webapi.aboutus";
  static const MORE_CONTACT_US = "contactus";

  static const ACCOUNT_MY_REVIEW = "account.customerproductreviews";
  static const ACCOUNT_INFO = "nopstation.webapi.account.info";
  static const ACCOUNT_CUSTOMER_ADDRESS = "account.customeraddresses";
  static const ACCOUNT_REWARD_POINT = "account.rewardpoints";
  static const ACCOUNT_LOGIN = "account.login";
  static const ACCOUNT_LOGOUT = "account.logout";
  static const ACCOUNT_LOGOUT_CONFIRM =
      "nopstation.webapi.account.logoutconfirmation";
  static const ACCOUNT_ORDERS = "account.customerorders";
  static const ACCOUNT_RETURN_REQUESTS = "account.customerreturnrequests";
  static const ACCOUNT_DOWNLOADABLE_PRODUCTS = "account.downloadableproducts";
  static const ACCOUNT_WISHLIST = "wishlist";
  static const ACCOUNT_RECENTLY_VIEWED = "pagetitle.recentlyviewedproducts";
  static const ACCOUNT_NEW_PRODUCTS = "pagetitle.newproducts";
  static const ACCOUNT_BACK_IN_STOCK_SUBSCRIPTION =
      "account.backinstocksubscriptions";

  static const CONTACT_US_FULLNAME = "contactus.fullname.hint";
  static const CONTACT_US_EMAIL = "contactus.email.hint";
  static const CONTACT_US_ENQUIRY = "contactus.enquiry.hint";
  static const CONTACT_US_SUBJECT = "contactus.subject.hint";
  static const CONTACT_US_BUTTON = "contactus.button";
  static const CONTACT_US_REQUIRED_FULLNAME = "contactus.fullname.required";
  static const CONTACT_US_REQUIRED_EMAIL = "contactvendor.email.required";
  static const CONTACT_US_REQUIRED_ENQUIRY = "contactus.enquiry.required";

  static const VENDOR_CONTACT_VENDOR = "contactvendor";
  static const VENDOR_FULLNAME = "contactvendor.fullname.hint";
  static const VENDOR_EMAIL = "contactvendor.email.hint";
  static const VENDOR_ENQUIRY = "contactvendor.enquiry.hint";
  static const VENDOR_SUBJECT = "contactvendor.subject.hint";
  static const VENDOR_BUTTON = "contactvendor.button";
  static const VENDOR_REQUIRED_FULLNAME = "contactvendor.fullname.required";
  static const VENDOR_REQUIRED_EMAIL = "contactvendor.email.required";
  static const VENDOR_REQUIRED_ENQUIRY = "contactvendor.enquiry.required";
  static const VENDOR_REQUIRED_SUBJECT = "contactvendor.subject.required";

  static const ADDRESS_COMPANY_NAME = "account.fields.company";
  static const ADDRESS_FAX = "account.fields.fax";
  static const ADDRESS_PHONE = "account.fields.phone";
  static const ADDRESS_EMAIL = "account.fields.email";
  static const ADDRESS_COUNTY = "account.fields.county";

  static const REGISTER_USER_AGREEMENT = "account.useragreement";
  static const REGISTER_PREFERENCES = "account.preferences";
  static const REGISTER_TIMEZONE = "account.fields.timezone";
  static const REGISTER_ACCEPT_PRIVACY =
      "account.fields.acceptprivacypolicy.required";

  static const FILTER = "nopstation.webapi.filtering.filter";
  static const FILTER_REMOVE = "filtering.pricerangefilter.remove";
  static const FILTER_PRICE_RANGE = "filtering.pricerangefilter";
  static const FILTER_SPECIFICATION = "filtering.specificationfilter";
  static const FILTER_FILTER_BY =
      "filtering.specificationfilter.currentlyfilteredby";

  static const SEARCH_QUERY_LENGTH =
      "search.searchtermminimumlengthisncharacters";
  static const SEARCH_NO_RESULT = "search.noresultstext";

  static const PRODUCT_TIER_PRICE_QUANTITY = 'products.tierprices.quantity';
  static const PRODUCT_TIER_PRICE_PRICE = 'products.tierprices.price';
  static const PRODUCT_GROUPED_PRODUCT =
      "enums.nop.core.domain.catalog.producttype.groupedproduct";
  static const PRODUCT_MANUFACTURER = "products.manufacturer";
  static const PRODUCT_TAG = "products.tags";
  static const PRODUCT_VENDOR = "products.vendor";
  static const PRODUCT_AVAILABILITY = "products.availability";
  static const PRODUCT_QUANTITY = "products.tierprices.quantity";
  static const PRODUCT_FREE_SHIPPING = "products.freeshipping";
  static const PRODUCT_INVALID_PRODUCT =
      "nopstation.webapi.sliders.fields.entityid.inconstidproduct";
  static const PRODUCT_GTIN = "products.gtin";
  static const PRODUCT_MANUFACTURER_PART_NUM =
      "products.manufacturerpartnumber";
  static const PRODUCT_BTN_BUY_NOW = "nopstation.webapi.shoppingcart.buynow";
  static const PRODUCT_BTN_RENT_NOW = "nopstation.webapi.shoppingcart.rentnow";
  static const PRODUCT_WISHLIST_DISABLED = "shoppingcart.wishlistdisabled";
  static const PRODUCT_BUY_DISABLED = "shoppingcart.buyingdisabled";
  static const PRODUCT_BTN_ADDTOCART = "shoppingcart.addtocart";
  static const PRODUCT_BTN_ADDTO_WISHLIST = "shoppingcart.addtowishlist";
  static const PRODUCT_SAMPLE_DOWNLOAD = "products.downloadsample";
  static const PRODUCT_ADDED_TO_WISHLIST =
      "products.producthasbeenaddedtothewishlist";
  static const PRODUCT_ADDED_TO_CART = "products.producthasbeenaddedtothecart";
  static const PRODUCT_ALSO_PURCHASED = "products.alsopurchased";
  static const PRODUCT_DESCRIPTION = "account.vendorinfo.description";
  static const PRODUCT_RELATED_PRODUCT = "products.relatedproducts";
  static const PRODUCT_RENTAL_START = "shoppingcart.rental.enterstartdate";
  static const PRODUCT_RENTAL_END = "shoppingcart.rental.enterenddate";
  static const PRODUCT_RENT = "shoppingcart.rent";
  static const PRODUCT_SPECIFICATION = "products.specs";
  static const PRODUCT_DELIVERY_DATE = "products.deliverydate";
  static const PRODUCT_GIFT_CARD_SENDER = "products.giftcard.sendername";
  static const PRODUCT_GIFT_CARD_SENDER_EMAIL = "products.giftcard.senderemail";
  static const PRODUCT_GIFT_CARD_RECIPIENT = "products.giftcard.recipientname";
  static const PRODUCT_GIFT_CARD_RECIPIENT_EMAIL =
      "products.giftcard.recipientemail";
  static const PRODUCT_GIFT_CARD_MESSAGE = "products.giftcard.message";
  static const PRODUCT_QUANTITY_POSITIVE =
      "shoppingcart.quantityshouldpositive";
  static const PRODUCT_CALL_FOR_PRICE = "products.callforprice";
  static const BACK_IN_STOCK_NOTIFY_ME_WHEN_AVAILABLE =
      "backinstocksubscriptions.notifymewhenavailable";
  static const BACK_IN_STOCK_ONLY_REGISTERED =
      "backinstocksubscriptions.onlyregistered";
  static const BACK_IN_STOCK_POPUP_TITLE =
      "backinstocksubscriptions.popuptitle";
  static const BACK_IN_STOCK_POPUP_TITLE_ALREADY_SUBSCRIBED =
      "backinstocksubscriptions.alreadysubscribed";
  static const BACK_IN_STOCK_NOTIFY_ME = "backinstocksubscriptions.notifyme";
  static const BACK_IN_STOCK_UNSUBSCRIBED =
      "backinstocksubscriptions.unsubscribe";
  static const BACK_IN_STOCK_DESCRIPTION =
      "account.backinstocksubscriptions.description";
  static const BACK_IN_STOCK_DELETE_SELECTED =
      "account.backinstocksubscriptions.deleteselected";
  static const BACK_IN_STOCK_NO_SUBSCRIPTION =
      "account.backinstocksubscriptions.nosubscriptions";

  static const WISHLIST_NO_ITEM = "wishlist.cartisempty";

  static const WISHLIST_ADD_ALL_TO_CART = "nopstation.webapi.wishlist.addall";

  static const APP_UPDATE_MSG = "nopstation.webapi.update.msg";

  static const APP_UPDATE_BTN = "nopstation.webapi.update.label";

  static const COMMON_SOMETHING_WENT_WRONG =
      "nopstation.webapi.common.somethingwrong";

  static const COMMON_NO_DATA = "nopstation.webapi.common.nodata";

  static const COMMON_SEE_ALL = "nopstation.webapi.home.seeall";

  static const COMMON_DONE = "nopstation.webapi.common.done";

  static const COMMON_PLEASE_WAIT =
      "Please wait while processing your request.";
  static const COMMON_SELECT = "nopstation.webapi.common.select";
  static const COMMON_AGAIN_PRESS_TO_EXIT =
      "nopstation.webapi.home.pressagaintoexit";
  static const COMMON_YES = "common.yes";
  static const COMMON_NO = "common.no";
  static const FILE_DOWNLOADED = "File downloaded to Download directory";
  static const RIBBON_NEW = 'New'; //"nopstation.webapi.productribbon.new";
  static const COMMON_MAX_FILE_SIZE = "shoppingcart.maximumuploadedfilesize";

  static const DOWNLOADABLE_I_AGREE = "downloadableproducts.iagree";
  static const DOWNLOADABLE_USER_AGREEMENT =
      "downloadableproducts.useragreement";
  static const DOWNLOADABLE_USER_DOWNLOAD =
      "downloadableproducts.fields.download";

  //SHOPPING CART;
  static const SHOPPING_CART_TITLE = "pagetitle.shoppingcart";

  static const PRODUCTS = "shoppingcart.product(s)";
  static const ITEMS = "shoppingcart.mini.items";
  static const ENTER_YOUR_COUPON = "shoppingcart.discountcouponcode.tooltip";
  static const ENTER_GIFT_CARD = "shoppingcart.giftcardcouponcode.tooltip";

  static const APPLY_COUPON = "shoppingcart.discountcouponcode.button";
  static const ADD_GIFT_CARD = "shoppingcart.giftcardcouponcode.button";

  static const ENTERED_COUPON_CODE =
      "shoppingcart.discountcouponcode.currentcode";

  static const SUB_TOTAL = "shoppingcart.totals.subtotal";
  static const SHIPPING = "shoppingcart.totals.shipping";
  static const DISCOUNT = "shoppingcart.totals.subtotaldiscount";
  static const GIFT_CARD = "shoppingcart.totals.giftcardinfo";
  static const GIFT_CARD_REMAINING =
      "shoppingcart.totals.giftcardinfo.remaining";
  static const TAX = "shoppingcart.totals.tax";
  static const TOTAL = "shoppingcart.totals.ordertotal";
  static const PAYMENT_FEE = "shoppingcart.totals.paymentmethodadditionalfee";

  static const CART_EMPTY = "shoppingcart.cartisempty";
  static const CHECKOUT = "checkout.button";
  static const CHECKOUT_PICKUP_FROM_STORE = "checkout.pickuppoints.description";
  static const CART_YOU_SAVED = "shoppingcart.itemyousave";
  static const CART_PRE_ORDER = "shoppingcart.preorder";
  static const CART_ESTIMATE_SHIPPING_BTN =
      "shoppingcart.estimateshipping.button";

  static const ESTIMATE_SHIPPING_TITLE =
      "shipping.estimateshippingpopup.shiptotitle";
  static const ESTIMATE_SHIPPING_ZIP =
      "shipping.estimateshippingpopup.zippostalcode";
  static const ESTIMATE_SHIPPING_APPLY =
      "shipping.estimateshippingpopup.selectshippingoption.button";
  static const ESTIMATE_SHIPPING_NO_OPTION =
      "shipping.estimateshippingpopup.noshippingoptions";
  static const ESTIMATE_SHIPPING_NAME =
      "shipping.estimateshippingpopup.shippingoption.name";
  static const ESTIMATE_SHIPPING_DELIVERY =
      "shipping.estimateshippingpopup.shippingoption.estimateddelivery";
  static const ESTIMATE_SHIPPING_PRICE =
      "shipping.estimateshippingpopup.shippingoption.price";

  static const CALCULATED_DURING_CHECKOUT =
      "shoppingcart.totals.calculatedduringcheckout";

  // GUEST CHECOUT DIALOG;

  static const CHECKOUT_AS_GUEST_TITLE =
      "account.login.checkoutasguestorregister";
  static const CHECKOUT_AS_GUEST = "account.login.checkoutasguest";
  static const REGISTER_AND_SAVE_TIME = "nopstation.webapi.registersavetime";
  static const CREATE_ACCOUNT_LONG_TEXT =
      "nopstation.webapi.creatingaccountlongtext";
  static const RETURNING_CUSTOMER = "nopstation.webapi.returningcustomer";

  //CHECKOUT;
  static const PLEASE_COMPLETE_PREVIOUS_STEP =
      "nopstation.webapi.checkout.completepreviousstep";

  static const ADDRESS_TAB = "checkout.progress.address";
  static const SHIPPING_TAB = "checkout.progress.shipping";
  static const PAYMENT_TAB = "checkout.progress.payment";
  static const CONFIRM_TAB = "checkout.progress.confirm";

  static const BILLING_ADDRESS_TAB = "checkout.billingaddress";
  static const SHIPPING_ADDRESS_TAB = "checkout.shippingaddress";

  static const SHIP_TO_SAME_ADDRESS = "checkout.shiptosameaddress";

  static const NEW_ADDRESS = "checkout.newaddress";

  //Payment method;
  static const USE_REWARD_POINTS = "checkout.userewardpoints";

  static const FIRST_NAME = "address.fields.firstname";
  static const LAST_NAME = "address.fields.lastname";
  static const COMPANY = "address.fields.company";
  static const CITY = "address.fields.city";
  static const PHONE = "address.fields.phonenumber";
  static const FAX = "account.fields.fax";
  static const ADDRESS_1 = "address.fields.address1";
  static const ADDRESS_2 = "address.fields.address2";
  static const EMAIL = "address.fields.email";
  static const CONFIRM_EMAIL = "account.fields.confirmemail";

  static const REGISTRATION_PERSONAL_DETAILS = "account.yourpersonaldetails";
  static const REGISTRATION_PASSWORD = "account.yourpassword";
  static const GENDER = "account.fields.gender";
  static const GENDER_MALE = "account.fields.gender.male";
  static const GENDER_FEMALE = "account.fields.gender.female";
  static const ACCOUNT_REMOVE_AVATAR = "account.avatar.removeavatar";
  static const ACCOUNT_AVATAR_SIZE = "account.avatar.maximumuploadedfilesize";

  static const ENTER_PASSWORD =
      "nopstation.webapi.account.fields.enterpassword";
  static const CONFIRM_PASSWORD = "account.fields.confirmpassword";
  static const OPTIONS = "account.options";
  static const CHANGE_PASSWORD = "account.changepassword";
  static const NEWSLETTER = "account.fields.newsletter";
  static const ACCEPT_PRIVACY_POLICY = "account.fields.acceptprivacypolicy";

  static const DATE_OF_BIRTH = "account.fields.dateofbirth";

  static const USERNAME = "account.fields.username";

  static const CONTINUE = "common.continue";
  static const REGISTER_BUTTON = "account.register.button";
  static const SAVE_BUTTON = "common.save";
  static const CONFIRM_BUTTON = "checkout.confirmbutton";

  static const THANK_YOU = "Thank You";

  static const NO_INTERNET = "Not connected to internet.";
  static const SETTINGS = "nopstation.webapi.settings";
  static const TRY_AGAIN = "Please try again.";

  static const READ_BEFORE_CONTINUE = "nopstation.webapi.readbeforecontinue";
  static const I_READ_I_ACCEPT = "nopstation.webapi.accept";
}
