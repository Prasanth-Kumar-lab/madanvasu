class ApiEndpoints {

  // static const String baseUrl = 'https://madanvasu.in/new';

  static const String baseUrl = 'https://madanvasu.in/new';

  static const String loginUrl = '/apis/api_users/user_login';

  static const String registerUser = '/apis/api_users/user_reg';

  static const String contactus = '/apis/Api_contactus/getcontactus';

  static const String getcategories = '/apis/Api_categories/getcategories';

  static const String categorys_based_on_Properties = '/apis/Api_properties_list_by_status/properties_list_by_status';

  static const String sold_propertieslist = '/apis/Api_properties_list_by_status/properties_list_by_status?property_status_id=1';

  static const String propertieslist_Bystatus = '/apis/Api_properties_list_by_status/properties_list_by_status?property_status_id=4';

  static const String Available_propertieslist = '/apis/Api_properties_list_by_status/properties_list_by_status?property_status_id=2';

  static const String Rented_propertieslist = '/apis/Api_properties_list_by_status/properties_list_by_status?property_status_id=3';


  static const String get_property_details = '/apis/Api_properties/get_property_details';

  static const String add_favorite_property = '/apis/Api_favorite_properties/add_favorite_property';

  static const String remove_favorite_property = '/apis/Api_favorite_properties/remove_favourite_property';

  static const String favorite_properties_list = '/apis/Api_favorite_properties/user_favorite_properties_list';

  static const String submit_property_review = '/apis/Api_property_reviews/add_property_review';

  static const String get_property_reviews = '/apis/Api_property_reviews/user_property_reviews_list';

  static const String my_properties_list = '/apis/Api_my_property_list/my_properties_list';

  static const String propertyPlanDays = '/apis/Api_property_plan/get_property_plan_days';

  static const String propertyPriceUrl = '/apis/Api_property_plan/get_property_price_per_days';

  static const String aboutUsUrl = '/apis/Api_aboutus/getaboutus';

  static const String updateProfile = '/apis/Api_profile_edit/update_user_details';

  static const String privacyPolicy = '/apis/Api_privacy_policy/getprivacypolicy';

  static const String termsConditions = '/apis/Api_terms_conditions/gettermsconditions';

  static const String propertyDetails = '/apis/Api_properties/get_property_details';

  static const String propertyStatusList = '/apis/Api_add_property_status/property_status_list';

  static const String getDistricts = '/apis/Api_districts/get_districts';

  static const String getMandals = '/apis/Api_mandals/get_mandals';

  static const String getStates = '/apis/Api_states/get_states';

  static const String getVillages = '/apis/Api_villages/get_villages';


}