class AppLandingDataModel {
  bool? showHomepageSlider;
  bool? showFeaturedProducts;
  bool? sliderAutoPlay;
  num? sliderAutoPlayTimeout;
  bool? showBestsellersOnHomepage;
  bool? showHomepageCategoryProducts;
  bool? showManufacturers;
  bool? rtl;
  String? androidVersion;
  bool? andriodForceUpdate;
  String? playStoreUrl;
  String? iOSVersion;
  bool? iOSForceUpdate;
  String? appStoreUrl;
  String? logoUrl;
  num? totalShoppingCartProducts;
  num? totalWishListProducts;
  bool? showAllVendors;
  bool? anonymousCheckoutAllowed;
  bool? showChangeBaseUrlPanel;
  bool? hasReturnRequests;
  bool? hideDownloadableProducts;
  String? primaryThemeColor;
  String? topBarBackgroundColor;
  String? topBarTextColor;
  String? bottomBarBackgroundColor;
  String? bottomBarActiveColor;
  String? bottomBarInactiveColor;
  String? gradientStartingColor;
  String? gradientMiddleColor;
  String? gradientEndingColor;
  bool? gradientEnabled;
  num? iOSProductPriceTextSize;
  num? androidProductPriceTextSize;
  num? ionicProductPriceTextSize;
  bool? newProductsEnabled;
  bool? recentlyViewedProductsEnabled;
  bool? compareProductsEnabled;
  bool? allowCustomersToUploadAvatars;
  num? avatarMaximumSizeBytes;
  bool? hideBackInStockSubscriptionsTab;

  AppLandingDataModel({
    this.showHomepageSlider,
    this.showFeaturedProducts,
    this.sliderAutoPlay,
    this.sliderAutoPlayTimeout,
    this.showBestsellersOnHomepage,
    this.showHomepageCategoryProducts,
    this.showManufacturers,
    this.rtl,
    this.androidVersion,
    this.andriodForceUpdate,
    this.playStoreUrl,
    this.iOSVersion,
    this.iOSForceUpdate,
    this.appStoreUrl,
    this.logoUrl,
    this.totalShoppingCartProducts,
    this.totalWishListProducts,
    this.showAllVendors,
    this.anonymousCheckoutAllowed,
    this.showChangeBaseUrlPanel,
    this.hasReturnRequests,
    this.hideDownloadableProducts,
    this.primaryThemeColor,
    this.topBarBackgroundColor,
    this.topBarTextColor,
    this.bottomBarBackgroundColor,
    this.bottomBarActiveColor,
    this.bottomBarInactiveColor,
    this.gradientStartingColor,
    this.gradientMiddleColor,
    this.gradientEndingColor,
    this.gradientEnabled,
    this.iOSProductPriceTextSize,
    this.androidProductPriceTextSize,
    this.ionicProductPriceTextSize,
    this.newProductsEnabled,
    this.recentlyViewedProductsEnabled,
    this.compareProductsEnabled,
    this.allowCustomersToUploadAvatars,
    this.avatarMaximumSizeBytes,
    this.hideBackInStockSubscriptionsTab,
  });

  AppLandingDataModel.fromJson(Map<String, dynamic> json) {
    showHomepageSlider = json['ShowHomepageSlider'];
    showFeaturedProducts = json['ShowFeaturedProducts'];
    sliderAutoPlay = json['SliderAutoPlay'];
    sliderAutoPlayTimeout = json['SliderAutoPlayTimeout'];
    showBestsellersOnHomepage = json['ShowBestsellersOnHomepage'];
    showHomepageCategoryProducts = json['ShowHomepageCategoryProducts'];
    showManufacturers = json['ShowManufacturers'];
    rtl = json['Rtl'];
    androidVersion = json['AndroidVersion'];
    andriodForceUpdate = json['AndriodForceUpdate'];
    playStoreUrl = json['PlayStoreUrl'];
    iOSVersion = json['IOSVersion'];
    iOSForceUpdate = json['IOSForceUpdate'];
    appStoreUrl = json['AppStoreUrl'];
    logoUrl = json['LogoUrl'];
    totalShoppingCartProducts = json['TotalShoppingCartProducts'];
    totalWishListProducts = json['TotalWishListProducts'];
    showAllVendors = json['ShowAllVendors'];
    anonymousCheckoutAllowed = json['AnonymousCheckoutAllowed'];
    showChangeBaseUrlPanel = json['ShowChangeBaseUrlPanel'];
    hasReturnRequests = json['HasReturnRequests'];
    hideDownloadableProducts = json['HideDownloadableProducts'];
    primaryThemeColor = json['PrimaryThemeColor'];
    topBarBackgroundColor = json['TopBarBackgroundColor'];
    topBarTextColor = json['TopBarTextColor'];
    bottomBarBackgroundColor = json['BottomBarBackgroundColor'];
    bottomBarActiveColor = json['BottomBarActiveColor'];
    bottomBarInactiveColor = json['BottomBarInactiveColor'];
    gradientStartingColor = json['GradientStartingColor'];
    gradientMiddleColor = json['GradientMiddleColor'];
    gradientEndingColor = json['GradientEndingColor'];
    gradientEnabled = json['GradientEnabled'];
    iOSProductPriceTextSize = json['IOSProductPriceTextSize'];
    androidProductPriceTextSize = json['AndroidProductPriceTextSize'];
    ionicProductPriceTextSize = json['IonicProductPriceTextSize'];
    newProductsEnabled = json['NewProductsEnabled'];
    recentlyViewedProductsEnabled = json['RecentlyViewedProductsEnabled'];
    compareProductsEnabled = json['CompareProductsEnabled'];
    allowCustomersToUploadAvatars = json['AllowCustomersToUploadAvatars'];
    avatarMaximumSizeBytes = json['AvatarMaximumSizeBytes'];
    hideBackInStockSubscriptionsTab = json['HideBackInStockSubscriptionsTab'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ShowHomepageSlider'] = this.showHomepageSlider;
    data['ShowFeaturedProducts'] = this.showFeaturedProducts;
    data['SliderAutoPlay'] = this.sliderAutoPlay;
    data['SliderAutoPlayTimeout'] = this.sliderAutoPlayTimeout;
    data['ShowBestsellersOnHomepage'] = this.showBestsellersOnHomepage;
    data['ShowHomepageCategoryProducts'] = this.showHomepageCategoryProducts;
    data['ShowManufacturers'] = this.showManufacturers;
    data['Rtl'] = this.rtl;
    data['AndroidVersion'] = this.androidVersion;
    data['AndriodForceUpdate'] = this.andriodForceUpdate;
    data['PlayStoreUrl'] = this.playStoreUrl;
    data['IOSVersion'] = this.iOSVersion;
    data['IOSForceUpdate'] = this.iOSForceUpdate;
    data['AppStoreUrl'] = this.appStoreUrl;
    data['LogoUrl'] = this.logoUrl;
    data['TotalShoppingCartProducts'] = this.totalShoppingCartProducts;
    data['TotalWishListProducts'] = this.totalWishListProducts;
    data['ShowAllVendors'] = this.showAllVendors;
    data['AnonymousCheckoutAllowed'] = this.anonymousCheckoutAllowed;
    data['ShowChangeBaseUrlPanel'] = this.showChangeBaseUrlPanel;
    data['HasReturnRequests'] = this.hasReturnRequests;
    data['HideDownloadableProducts'] = this.hideDownloadableProducts;
    data['PrimaryThemeColor'] = this.primaryThemeColor;
    data['TopBarBackgroundColor'] = this.topBarBackgroundColor;
    data['TopBarTextColor'] = this.topBarTextColor;
    data['BottomBarBackgroundColor'] = this.bottomBarBackgroundColor;
    data['BottomBarActiveColor'] = this.bottomBarActiveColor;
    data['BottomBarInactiveColor'] = this.bottomBarInactiveColor;
    data['GradientStartingColor'] = this.gradientStartingColor;
    data['GradientMiddleColor'] = this.gradientMiddleColor;
    data['GradientEndingColor'] = this.gradientEndingColor;
    data['GradientEnabled'] = this.gradientEnabled;
    data['IOSProductPriceTextSize'] = this.iOSProductPriceTextSize;
    data['AndroidProductPriceTextSize'] = this.androidProductPriceTextSize;
    data['IonicProductPriceTextSize'] = this.ionicProductPriceTextSize;
    data['NewProductsEnabled'] = this.newProductsEnabled;
    data['RecentlyViewedProductsEnabled'] = this.recentlyViewedProductsEnabled;
    data['CompareProductsEnabled'] = this.compareProductsEnabled;
    data['AllowCustomersToUploadAvatars'] = this.allowCustomersToUploadAvatars;
    data['AvatarMaximumSizeBytes'] = this.avatarMaximumSizeBytes;
    data['HideBackInStockSubscriptionsTab'] =
        this.hideBackInStockSubscriptionsTab;
    return data;
  }
}
