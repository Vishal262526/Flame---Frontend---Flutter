import 'dart:async';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:flame/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flame/core/common/enums/gender_enum.dart';
import 'package:flame/core/common/models/user_model.dart';
import 'package:flame/core/exceptions/location_exception.dart';
import 'package:flame/core/exceptions/server_exception.dart';
import 'package:flame/core/utils/app_utils.dart';
import 'package:flame/core/utils/location_utils.dart';
import 'package:flame/features/profile/models/interest_model.dart';
import 'package:flame/features/profile/repository/profile_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_state_city/models/state.dart' as state;
import 'package:country_state_city/models/city.dart' as city;

class ProfileController extends GetxController {
  final _profileRepository = ProfileRepository();

  // Loading
  final isLoading = false.obs;
  final isLocationUpdating = false.obs;
  final isProfileUpdating = false.obs;

  // Loading without states
  bool isSearchStateRequestProcessing = false;
  bool isSearchCitiesRequestProcessing = false;

  final interestData = <InterestModel>[].obs;
  final selectedInterestList = <String>[].obs;

  // Page View Controller
  final pageController = PageController();

  // States and Cities
  final stateList = <state.State>[].obs;
  final cityList = <city.City>[].obs;
  final searchStateList = <state.State>[].obs;
  final searchCityList = <city.City>[].obs;

  // Input Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final instagramController = TextEditingController();
  final snapchatController = TextEditingController();

  final selectedGender = Rx<Gender>(Gender.male);
  final selectedShowMeGender = Rx<Gender>(Gender.male);
  final selectedImages = <File>[].obs;
  final selectedDOB = Rx<DateTime>(
    DateTime.now().subtract(
      const Duration(days: 6570),
    ),
  );
  final selectedState = Rx<state.State?>(null);
  final selectedCity = Rx<city.City?>(null);

  final userCurrentLocation = Rx<Position?>(null);

  // Error Messages
  final nameValidationError = Rx<String?>(null);
  final emailValidationError = Rx<String?>(null);
  final dobValidationError = Rx<String?>(null);
  final imagesValidationError = Rx<String?>(null);
  final interestsValidationError = Rx<String?>(null);
  final stateCityValidationError = Rx<String?>(null);
  final socialValidationError = Rx<String?>(null);

  final locationValidationError = Rx<String?>(null);

  // Validators
  final _nameValidator = ValidationBuilder()
      .minLength(3, "Name is too small")
      .maxLength(20, "Name is too large")
      .required()
      .build();
  final _emailValidator = ValidationBuilder().required().build();

  // Debounce Timers
  Timer? searchCountryDebounceTimer;
  Timer? searchStateDebounceTimer;

  @override
  void onReady() async {
    _loadInterestData();
    super.onReady();
  }

  void _loadInterestData() async {
    interestData.value = await _profileRepository.getAllInterests();
  }

  void validateName() {
    final validationError = _nameValidator(nameController.text.trim());

    if (validationError == null) {
      goToNextPage();
    }

    nameValidationError.value = validationError;
  }

  void validateEmail() {
    final validationError = _emailValidator(emailController.text.trim());

    if (validationError == null) {
      goToNextPage();
    }

    emailValidationError.value = validationError;
  }

  void validateDOB() {
    final age = AgeCalculator.age(selectedDOB.value);

    dobValidationError.value =
        age.years >= 18 ? null : "You need atleast 18 year old to signup ";

    if (dobValidationError.value == null) {
      goToNextPage();
    }
  }

  void validateImages() {
    if (selectedImages.isEmpty) {
      imagesValidationError.value = "Please upload atleast 1 image";
      return;
    } else if (selectedImages.length > 4) {
      imagesValidationError.value = "You can only upload 4 images";
      return;
    }

    imagesValidationError.value = null;
    updateProfile();
  }

  void validateSocials() {
    socialValidationError.value = null;

    if (instagramController.text.isEmpty && snapchatController.text.isEmpty) {
      socialValidationError.value = "One of the field is required";
    }

    if (socialValidationError.value == null) {
      goToNextPage();
    }
  }

  void validateInterests() {
    interestsValidationError.value = selectedInterestList.length < 5
        ? "Please select at least 5 interest"
        : null;

    if (interestsValidationError.value == null) {
      goToNextPage();
    }
  }

  void validateStateAndCity() {
    if (selectedCity.value == null || selectedState.value == null) {
      stateCityValidationError.value = "State and City are required";
      return;
    }

    stateCityValidationError.value = null;

    if (stateCityValidationError.value == null) {
      goToNextPage();
    }
  }

  void goToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }

  void goToPreviousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }

  void updateSelectedGender(Gender gender) {
    selectedGender.value = gender;
  }

  void updateSelectedShowMeGender(Gender gender) {
    selectedShowMeGender.value = gender;
  }

  void updateSelectedDOB(DateTime dob) {
    selectedDOB.value = dob;
  }

  void updateUserLocation() async {
    isLocationUpdating.value = true;
    try {
      final currentLocation = await LocationUtils.getCurrentLocation();
      userCurrentLocation.value = currentLocation;
    } on LocationException catch (e) {
      AppUtils.showSnackBar(title: "Error", message: e.message);
    } finally {
      isLocationUpdating.value = false;
    }
  }

  void updateProfile() async {
    isProfileUpdating.value = true;
    try {
      final selectedInterestsName = selectedInterestList
          .map(
            (interest) => interest,
          )
          .toList();

      final user = CurrentUserModel(
        uid: "",
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        gender: selectedGender.value,
        images: [],
        lastActive: DateTime.now(),
        age: 0,
        showMeGender: selectedShowMeGender.value,
        instagramUsername:
            instagramController.text.isEmpty ? null : instagramController.text,
        snapchatUsername:
            snapchatController.text.isEmpty ? null : snapchatController.text,
        dob: selectedDOB.value,
        country: "IN",
        state: selectedState.value!.name,
        city: selectedCity.value!.name,
        interests: selectedInterestsName,
        flames: 100,
      );

      await _profileRepository.updateProfile(
        user: user,
        images: selectedImages,
      );

      // Save the user to the state and navigate to the home screen

      Get.offAllNamed(RoutesName.home);
    } on ServerException catch (e) {
      AppUtils.showSnackBar(title: "Error", message: e.message);
    } finally {
      isProfileUpdating.value = false;
    }
  }

  void updateInterestList(String interest) {
    if (selectedInterestList.contains(interest)) {
      selectedInterestList.remove(interest);
    } else {
      selectedInterestList.add(interest);
    }

    // selectedInterestList.refresh();
  }

  void updateState(state.State state) {
    searchCityList.value = [];
    if (selectedCity.value != null) {
      selectedCity.value = null;
    }

    selectedState.value = state;
  }

  void updateCity(city.City city) {
    selectedCity.value = city;
  }

  void pickImages() async {
    final image = await AppUtils.pickImage(imageSource: ImageSource.gallery);
    if (image == null) {
      return;
    }

    if (selectedImages.length < 4) {
      selectedImages.add(image);
    } else {
      AppUtils.showSnackBar(
        title: "Validation Error",
        message: "You can only upload 4 images",
      );
    }

    refresh();
  }

  void searchState(String query) async {
    final foundStates = stateList
        .where(
          (state) => state.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    searchStateList.value = foundStates;
  }

  void searchCity(String query) async {
    final foundCities = cityList
        .where(
          (city) => city.name.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    searchCityList.value = foundCities;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    nameController.dispose();
    emailController.dispose();
    isLoading.value = false;
    super.onClose();
  }
}
