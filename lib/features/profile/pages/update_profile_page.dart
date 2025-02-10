import 'package:flame/features/auth/controller/auth_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:flame/core/common/widgets/input.dart';
import 'package:flame/core/common/widgets/loader.dart';
import 'package:flame/core/theme/app_colors.dart';
import 'package:flame/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flame/features/profile/widgets/profile_gender_field.dart';
import 'package:flame/features/profile/widgets/profile_images_field.dart';
import 'package:flame/features/profile/widgets/select_city_sheet.dart';
import 'package:flame/features/profile/widgets/select_state_sheet.dart';
import 'package:flame/features/profile/widgets/update_field_widget.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _authController = Get.find<AuthController>();
  final _profileController = Get.put(ProfileController());

  List<String> interests = [
    "Hiking",
    "Cooking",
    "Traveling",
    "Reading",
    "Photography",
    "Painting",
    "Music (listening)",
    "Music (playing)",
    "Movies",
    "TV Shows",
    "Gaming",
    "Dancing",
    "Singing",
    "Writing",
    "Yoga",
    "Meditation",
    "Fitness",
    "Sports (watching)",
    "Sports (playing)",
    "Coffee",
    "Tea",
    "Wine",
    "Craft Beer",
    "Fine Dining",
    "Casual Dining",
    "Baking",
    "Gardening",
    "DIY Projects",
    "Volunteering",
    "Animals (pets)",
    "Animals (wildlife)",
    "Technology",
    "Science",
    "History",
    "Philosophy",
    "Politics",
    "Business",
    "Investing",
    "Coding",
    "Learning Languages",
    "Podcasts",
    "Stand-up Comedy",
    "Live Music",
    "Art Museums",
    "Science Museums",
    "Historical Sites",
    "National Parks",
    "Beaches",
    "Mountains",
    "City Life",
    "Small Towns",
    "Road Trips",
    "Camping",
    "Fishing",
    "Kayaking",
    "Rock Climbing",
    "Surfing",
    "Skiing",
    "Snowboarding",
    "Skateboarding",
    "Running",
    "Swimming",
    "Cycling",
    "Weightlifting",
    "Crossfit",
    "Martial Arts",
    "Board Games",
    "Card Games",
    "Video Games",
    "Anime",
    "Manga",
    "Comics",
    "Fantasy Novels",
    "Sci-Fi Novels",
    "Mystery Novels",
    "Romance Novels",
    "Historical Fiction",
    "Poetry",
    "Creative Writing",
    "Digital Art",
    "Traditional Art",
    "Fashion",
    "Interior Design",
    "Architecture",
    "Cars",
    "Motorcycles",
    "Aviation",
    "Space Exploration",
    "Astrology",
    "Spirituality",
    "Personal Development",
    "Self-Improvement",
    "Travel Photography",
    "Street Photography",
    "Nature Photography",
    "Portrait Photography",
    "Food Photography",
    "Abstract Art",
    "Pop Art",
    "Surrealism",
    "Impressionism",
    "Classical Music",
    "Jazz Music",
    "Rock Music",
    "Pop Music",
    "Hip Hop Music",
    "Electronic Music",
    "Country Music",
    "Folk Music",
    "Blues Music",
    "World Music",
    "Indie Music",
    "Alternative Music",
    "Metal Music",
    "Punk Music",
    "Reggae Music",
    "Ska Music",
    "Gospel Music",
    "Classical Literature",
    "Modern Literature",
    "Contemporary Literature",
    "Foreign Literature",
    "Children's Literature",
    "Young Adult Literature",
    "Graphic Novels",
    "Webcomics",
    "Fanfiction",
    "Poetry Slams",
    "Open Mic Nights",
    "Improv Comedy",
    "Sketch Comedy",
    "Stand-up Comedy",
    "Film Festivals",
    "Theater",
    "Musicals",
    "Opera",
    "Ballet",
    "Modern Dance",
    "Contemporary Dance",
    "Folk Dance",
    "Ballroom Dance",
    "Latin Dance",
    "Hip Hop Dance",
    "Breakdancing",
    "Salsa Dancing",
    "Tango Dancing",
    "Swing Dancing",
    "Line Dancing",
    "Square Dancing",
    "Contra Dancing",
    "Irish Dancing",
    "Scottish Dancing",
    "Indian Classical Dance",
    "Bollywood Dance",
    "African Dance",
    "Brazilian Dance",
    "Flamenco Dance",
    "Belly Dancing",
    "Pole Dancing",
    "Burlesque Dancing",
    "Cosplay",
    "LARPing",
    "Renaissance Fairs",
    "Comic Conventions",
    "Gaming Conventions",
    "Anime Conventions",
    "Music Festivals",
    "Food Festivals",
    "Art Festivals",
    "Film Festivals",
    "Theater Festivals",
    "Dance Festivals",
    "Cultural Festivals",
    "Religious Festivals",
    "Holiday Celebrations",
    "Birthday Celebrations",
    "Anniversary Celebrations",
    "Weddings",
    "Funerals",
    "Baby Showers",
    "Bridal Showers",
    "Bachelor Parties",
    "Bachelorette Parties",
    "Graduation Ceremonies",
    "Retirement Parties",
    "Housewarmings",
    "BBQs",
    "Picnics",
    "Potlucks",
    "Game Nights",
    "Movie Nights",
    "Book Clubs",
    "Wine Tastings",
    "Beer Tastings",
    "Coffee Tastings",
    "Tea Tastings",
    "Cooking Classes",
    "Dance Classes",
    "Art Classes",
    "Music Lessons",
    "Language Lessons",
    "Fitness Classes",
    "Yoga Classes",
    "Meditation Classes",
    "Self-Defense Classes",
    "First Aid Classes",
    "CPR Classes",
    "Financial Literacy Classes",
    "Personal Development Workshops",
    "Career Counseling",
    "Life Coaching",
    "Mentorship Programs",
    "Networking Events",
    "Conferences",
    "Seminars",
    "Webinars",
    "Online Courses",
    "MOOCs",
    "Podcasts",
    "Audiobooks",
    "Ebooks",
    "Blogs",
    "Vlogs",
    "Social Media",
    "Online Forums",
    "Dating Apps",
    "Meetup Groups",
    "Volunteer Organizations",
    "Charities",
    "Nonprofits",
    "Political Campaigns",
    "Social Movements",
    "Community Events",
    "Local Businesses",
    "Small Businesses",
    "Startups",
    "Tech Companies",
    "Large Corporations",
    "Government Agencies",
    "Educational Institutions",
    "Healthcare Providers",
    "Religious Organizations",
    "Cultural Institutions",
    "Historical Societies",
    "Environmental Groups",
    "Animal Shelters",
    "Hobby Clubs",
    "Sports Leagues",
    "Recreational Activities",
    "Outdoor Adventures",
    "Indoor Activities",
    "Creative Pursuits",
    "Intellectual Discussions",
    "Deep Conversations",
    "Meaningful Connections",
    "Shared Experiences",
    "Lasting Memories",
    "True Love",
    "Happily Ever After",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileController.nameController.text =
        _authController.user.value?.userMetadata?['name'] ?? "";
    _profileController.emailController.text =
        _authController.user.value?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Obx(
              () => _profileController.isProfileUpdating.value
                  ? const Loader()
                  : PageView(
                      // physics: const NeverScrollableScrollPhysics(),
                      controller: _profileController.pageController,
                      children: [
                        UpdateFieldWidget(
                          errorMessage:
                              _profileController.nameValidationError.value,
                          showBackButton: false,
                          title: "Full Name",
                          onNextTap: () {
                            _profileController.validateName();
                          },
                          onBackTap: null,
                          child: Input(
                            placeholder: "eg. Vishal",
                            controller: _profileController.nameController,
                          ),
                        ),
                        UpdateFieldWidget(
                          title: "Email",
                          onNextTap: () {
                            _profileController.validateEmail();
                          },
                          onBackTap: _profileController.goToPreviousPage,
                          errorMessage:
                              _profileController.emailValidationError.value,
                          child: Input(
                            readOnly: true,
                            placeholder: "Email",
                            controller: _profileController.emailController,
                          ),
                        ),
                        UpdateFieldWidget(
                          errorMessage: null,
                          title: "Gender",
                          onNextTap: _profileController.goToNextPage,
                          onBackTap: _profileController.goToPreviousPage,
                          child: ProfileGenderField(
                            onChange: (gender) {
                              _profileController.updateSelectedGender(gender);
                            },
                            selectedGender:
                                _profileController.selectedGender.value,
                          ),
                        ),
                        UpdateFieldWidget(
                          errorMessage:
                              _profileController.dobValidationError.value,
                          title: "Date of Birth",
                          onNextTap: () {
                            _profileController.validateDOB();
                          },
                          onBackTap: _profileController.goToPreviousPage,
                          child: SizedBox(
                            height: 300,
                            child: Obx(() => ScrollDatePicker(
                                  maximumDate: DateTime.now().subtract(
                                    const Duration(days: 6570),
                                  ),
                                  minimumDate: DateTime.now().subtract(
                                    const Duration(days: 21900),
                                  ),
                                  options: const DatePickerOptions(
                                    backgroundColor: DarkColors.background,
                                  ),
                                  locale: const Locale('en'),
                                  selectedDate:
                                      _profileController.selectedDOB.value,
                                  onDateTimeChanged: (dob) {
                                    _profileController.updateSelectedDOB(dob);
                                  },
                                )),
                          ),
                        ),
                        UpdateFieldWidget(
                          errorMessage:
                              _profileController.stateCityValidationError.value,
                          title: "State & City",
                          onNextTap: () {
                            _profileController.validateStateAndCity();
                          },
                          onBackTap: _profileController.goToPreviousPage,
                          child: Column(
                            children: [
                              Input(
                                placeholder:
                                    _profileController.selectedState.value !=
                                            null
                                        ? _profileController
                                            .selectedState.value!.name
                                        : "State",
                                readOnly: true,
                                onTap: () {
                                  Get.bottomSheet(
                                    backgroundColor: DarkColors.background,
                                    Obx(
                                      () => SelectStateSheet(
                                        onSelected: (state) {
                                          Get.back();
                                          _profileController.updateState(state);
                                        },
                                        statesList: _profileController
                                            .searchStateList.value,
                                        onChanged:
                                            _profileController.searchState,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Input(
                                placeholder:
                                    _profileController.selectedCity.value !=
                                            null
                                        ? _profileController
                                            .selectedCity.value!.name
                                        : "City",
                                readOnly: true,
                                onTap: () {
                                  if (_profileController.selectedState.value ==
                                      null) {
                                    _profileController.stateCityValidationError
                                        .value = "Please select state first";
                                    return;
                                  }
                                  Get.bottomSheet(
                                    // isScrollControlled: true,
                                    backgroundColor: DarkColors.background,
                                    Obx(() => SelectCitySheet(
                                          onSelected: (city) {
                                            Get.back();

                                            _profileController.updateCity(city);
                                          },
                                          cityList: _profileController
                                              .searchCityList.value,
                                          onChanged:
                                              _profileController.searchCity,
                                        )),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        UpdateFieldWidget(
                          errorMessage:
                              _profileController.interestsValidationError.value,
                          title: "Interests",
                          onNextTap: () {
                            _profileController.validateInterests();
                          },
                          onBackTap: _profileController.goToPreviousPage,
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: interests
                                  .map((interest) => Obx(
                                        () => GestureDetector(
                                          onTap: () {
                                            _profileController
                                                .updateInterestList(interest);
                                          },
                                          child: ChoiceChip(
                                            backgroundColor:
                                                DarkColors.secondary,
                                            label: Text(interest),
                                            selected: _profileController
                                                .selectedInterestList
                                                .contains(interest),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        UpdateFieldWidget(
                          errorMessage: null,
                          title: "Show Me",
                          onNextTap: _profileController.goToNextPage,
                          onBackTap: _profileController.goToPreviousPage,
                          child: ProfileGenderField(
                            onChange: (gender) {
                              _profileController
                                  .updateSelectedShowMeGender(gender);
                            },
                            selectedGender:
                                _profileController.selectedShowMeGender.value,
                          ),
                        ),
                        UpdateFieldWidget(
                          errorMessage:
                              _profileController.socialValidationError.value,
                          title: "Social's",
                          onNextTap: _profileController.validateSocials,
                          onBackTap: _profileController.goToPreviousPage,
                          child: Column(
                            children: [
                              Input(
                                controller:
                                    _profileController.snapchatController,
                                icon: const Icon(Icons.snapchat),
                                placeholder: "Snapchat Username",
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Input(
                                controller:
                                    _profileController.instagramController,
                                icon: const Icon(
                                  FontAwesomeIcons.instagram,
                                ),
                                placeholder: "Instagram Username",
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        UpdateFieldWidget(
                          errorMessage:
                              _profileController.imagesValidationError.value,
                          title: "Upload Images",
                          onNextTap: () {
                            _profileController.validateImages();
                          },
                          nextBUttonText: "Update",
                          onBackTap: _profileController.goToPreviousPage,
                          child: ProfileImagesField(
                            onTap: _profileController.pickImages,
                            images: _profileController.selectedImages.value,
                            onRemove: (index) {
                              _profileController.selectedImages.removeAt(index);
                            },
                          ),
                        ),
                      ],
                    ),
            )),
          ],
        ),
      ),
    );
  }
}
