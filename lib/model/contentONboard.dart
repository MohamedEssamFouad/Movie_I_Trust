class ContentOnboard {
  String title; // Not static

  ContentOnboard(this.title);
  static List<ContentOnboard> contents = [
    ContentOnboard("Now you can more quickly and easily note your movie into your watchlist!"),
    ContentOnboard("Easy to add and maintain."),
    ContentOnboard("Imagine your life without the app."),
  ];
}
