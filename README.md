**README**

This repository contains a Flutter app for the Flutter Challenge project.

### Disclaimer
During debugging, you may notice the appearance of NetworkImageLoadException. This error is related to Image.network present in RoundedNetworkImage, despite the fact that an errorBuilder has been defined within Image.network. I believe the cause gives related to trying to load a broken image from the cache since some images received from the backend are not available but for some reason are cached anyway. This does not seem to affect the execution of the application because the error widget is still shown and execution continues normally without too many rebuilds.
There are various workarounds that perform worse than the solution adopted (longer loading times or more rebuilds).
I would like to discuss about this error which seems to me more like a framework level bug.
More information can also be found on GitHub:
https://github.com/flutter/flutter/issues/118586#issuecomment-1450474036.

During integration testing to prevent this error from causing the test to fail, FlutterError.onError was redefined to not present this type of exception.

### Steps to Execute the Flutter App:

1. Clone the repository using the following command:
   ```
   git clone https://github.com/mgabriele00/flutter_challenge.git
   ```

2. Navigate to the cloned directory:
   ```
   cd flutter_challenge
   ```

3. Get the required dependencies using Flutter's package manager:
   ```
   flutter pub get
   ```

4. Ensure you have an emulator set up and running.

5. Run the Flutter app on your emulator:
   ```
   flutter run
   ```

### Running Tests:

To execute the tests, follow these commands:

1. Run integration tests (note that you must have a simulator running):
   ```
   flutter test integration_test
   ```

2. Run unit tests:
   ```
   flutter test
   ```

### More info:

This app has been developed and tested using Flutter version 3.16.0.

If you encounter any issues feel free to reach me out.

Happy Fluttering! 🚀✨