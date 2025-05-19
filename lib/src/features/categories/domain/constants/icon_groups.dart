import 'package:flutter/material.dart';

class IconGroups {
  static const String finance = 'finance';
  static const String transport = 'transport';
  static const String health = 'health';
  static const String home = 'home';
  static const String pets = 'pets';
  static const String groceries = 'groceries';
  static const String restaurants = 'restaurants';
  static const String entertainment = 'entertainment';
  static const String work = 'work';
  static const String education = 'education';
  static const String gifts = 'gifts';
  static const String clothes = 'clothes';
  static const String sports = 'sports';
  static const String electronics = 'electronics';
  static const String beauty = 'beauty';
  static const String technology = 'technology';
  static const String gardening = 'gardening';
  static const String family = 'family';
  static const String subscriptions = 'subscriptions';
  static const String ecology = 'ecology';
  static const String freelance = 'freelance';

  static final Map<String, List<IconData>> allIcons = {
    finance: [
      Icons.account_balance_outlined,
      Icons.savings_outlined,
      Icons.timeline_outlined,
      Icons.attach_money_outlined,
      Icons.trending_up_outlined,
      Icons.wallet_outlined,
      Icons.credit_card_outlined,
      Icons.request_page_outlined,
      Icons.money_off_csred_outlined,
      Icons.receipt_long_outlined,
    ],
    transport: [
      Icons.directions_car_outlined,
      Icons.airplanemode_active_outlined,
      Icons.local_parking_outlined,
      Icons.directions_boat_outlined,
      Icons.train_outlined,
      Icons.electric_car_outlined,
      Icons.electric_scooter_outlined,
      Icons.local_taxi_outlined,
      Icons.bike_scooter_outlined,
      Icons.directions_bus_outlined,
    ],
    health: [
      Icons.medical_services_outlined,
      Icons.health_and_safety_outlined,
      Icons.medication_outlined,
      Icons.fitness_center_outlined,
      Icons.psychology_outlined,
      Icons.healing_outlined,
      Icons.bloodtype_outlined,
      Icons.spa_outlined,
      Icons.local_hospital_outlined,
    ],
    home: [
      Icons.cleaning_services_outlined,
      Icons.home_repair_service_outlined,
      Icons.home_outlined,
      Icons.construction_outlined,
      Icons.wifi_outlined,
      Icons.security_outlined,
      Icons.lightbulb_outline,
      Icons.water_drop_outlined,
      Icons.fireplace_outlined,
    ],
    pets: [
      Icons.pets_outlined,
      Icons.food_bank_outlined,
    ],
    groceries: [
      Icons.local_grocery_store_outlined,
      Icons.shopping_bag_outlined,
      Icons.fastfood_outlined,
      Icons.restaurant_outlined,
      Icons.local_pizza_outlined,
      Icons.emoji_food_beverage_outlined,
      Icons.icecream_outlined,
    ],
    restaurants: [
      Icons.restaurant_menu_outlined,
      Icons.local_cafe_outlined,
      Icons.emoji_food_beverage_outlined,
      Icons.local_bar_outlined,
      Icons.dinner_dining_outlined,
      Icons.brunch_dining_outlined,
      Icons.liquor_outlined,
    ],
    entertainment: [
      Icons.palette_outlined,
      Icons.videogame_asset_outlined,
      Icons.theaters_outlined,
      Icons.live_tv_outlined,
      Icons.movie_outlined,
      Icons.music_note_outlined,
      Icons.sports_esports_outlined,
      Icons.theater_comedy_outlined,
      Icons.festival_outlined,
    ],
    work: [
      Icons.work_outline,
      Icons.business_outlined,
      Icons.people_outline,
      Icons.monetization_on_outlined,
    ],
    education: [
      Icons.school_outlined,
      Icons.menu_book_outlined,
      Icons.language_outlined,
      Icons.science_outlined,
      Icons.calculate_outlined,
      Icons.computer_outlined,
      Icons.cast_for_education_outlined,
      Icons.online_prediction_outlined,
    ],
    gifts: [
      Icons.card_giftcard_outlined,
      Icons.volunteer_activism_outlined,
      Icons.handshake_outlined,
      Icons.redeem_outlined,
    ],
    clothes: [
      Icons.shopping_cart_outlined,
      Icons.checkroom_outlined,
      Icons.watch_outlined,
      Icons.style_outlined,
      Icons.face_outlined,
    ],
    sports: [
      Icons.sports_soccer_outlined,
      Icons.sports_tennis_outlined,
      Icons.sports_martial_arts_outlined,
      Icons.pool_outlined,
    ],
    electronics: [
      Icons.devices_outlined,
      Icons.smartphone_outlined,
      Icons.headphones_outlined,
      Icons.laptop_outlined,
    ],
    beauty: [
      Icons.cut_outlined,
      Icons.face_retouching_natural_outlined,
      Icons.spa_outlined,
      Icons.clean_hands_outlined,
    ],
    technology: [
      Icons.code_outlined,
      Icons.developer_board_outlined,
      Icons.router_outlined,
      Icons.cloud_outlined,
    ],
    gardening: [
      Icons.agriculture_outlined,
      Icons.forest_outlined,
      Icons.grass_outlined,
    ],
    family: [
      Icons.child_friendly_outlined,
      Icons.toys_outlined,
      Icons.family_restroom_outlined,
      Icons.cake_outlined,
    ],
    subscriptions: [
      Icons.subscriptions_outlined,
      Icons.stream_outlined,
      Icons.music_video_outlined,
      Icons.newspaper_outlined,
    ],
    ecology: [
      Icons.eco_outlined,
      Icons.recycling_outlined,
      Icons.solar_power_outlined,
      Icons.wind_power_outlined,
    ],
    freelance: [
      Icons.design_services_outlined,
      Icons.photo_camera_outlined,
      Icons.edit_note_outlined,
      Icons.graphic_eq_outlined,
    ],
  };

  static Map<String, List<IconData>> allIconGroups() {
    return allIcons;
  }
}
