class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to Chat Application",
    image: "assets/images/logo.png",
    desc: "A simple, free, fast, secure and reliable way for chatting application to other people.",
  ),
  OnboardingContents(
    title: "🌐 Security & Reliability",
    image: "assets/images/image2.png",
    desc:
        "ustomers access Comfy’s product solutions over the internet with industry-standard secure and encrypted connections (TLS 1.0-1.2).",
  ),
  OnboardingContents(
    title: "☁ Cloud Based & Good 📈 Performance",
    image: "assets/images/image3.png",
    desc:
        "(of digital data) stored, managed, and processed on a network of remote servers hosted on the internet, rather than on local servers.",
  ),
];
