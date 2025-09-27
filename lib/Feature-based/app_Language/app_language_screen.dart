import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Language_model.dart';

class LanguageSelectionScreen extends StatelessWidget {
  LanguageSelectionScreen({Key? key}) : super(key: key);

  final List<Language> languages = [
    Language(name: "English", languageCode: "en", countryCode: "US", flagEmoji: "🇺🇸"),
    Language(name: "हिंदी", languageCode: "hi", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "తెలుగు", languageCode: "te", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "বাংলা", languageCode: "bn", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "मराठी", languageCode: "mr", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "தமிழ்", languageCode: "ta", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "ગુજરાતી", languageCode: "gu", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "ಕನ್ನಡ", languageCode: "kn", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "മലയാളം", languageCode: "ml", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "ଓଡ଼ିଆ", languageCode: "or", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "اردو", languageCode: "ur", countryCode: "IN", flagEmoji: "🇮🇳"),
    Language(name: "ਪੰਜਾਬੀ", languageCode: "pa", countryCode: "IN", flagEmoji: "🇮🇳"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('select_language'.tr),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: languages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final lang = languages[index];
            final isSelected = Get.locale?.languageCode == lang.languageCode;

            return GestureDetector(
              onTap: () {
                Get.updateLocale(Locale(lang.languageCode, lang.countryCode));
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.grey.shade300 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey.shade400,
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(lang.flagEmoji, style: const TextStyle(fontSize: 30)),
                    const SizedBox(height: 10),
                    Text(
                      lang.name,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
