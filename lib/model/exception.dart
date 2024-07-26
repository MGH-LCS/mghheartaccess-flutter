//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.
import 'package:flutter/material.dart';

class MGHHeartException implements Exception {
  final String? message;
  final String? title;
  final String? detail;
  final IconData? iconData;

  MGHHeartException([this.message, this.title, this.detail, this.iconData]);

  @override
  String toString() {
    return "$title: $message";
  }
}

class MGHHeartRunTimeException extends MGHHeartException {
  MGHHeartRunTimeException([String? message])
      : super(message, "Unknown Error", "There was a problem",
            Icons.error_outline);
}

class MGHHeartRequestTimeoutException extends MGHHeartException {
  MGHHeartRequestTimeoutException([String? message])
      : super(
            message,
            "Request Timeout",
            "The service request has taken the maximum amount of time and is not responding",
            Icons.timelapse);
}

class MGHHeartServiceExcepton extends MGHHeartException {
  MGHHeartServiceExcepton([String? message])
      : super(message, "Service Error", "An unknown error has occured",
            Icons.error_outline);
}

class MGHHeartMessagingException extends MGHHeartException {
  MGHHeartMessagingException([String? message])
      : super(message, "Messaging Error", null, Icons.error_outline);
}

class MGHHeartDeviceExcepton extends MGHHeartException {
  MGHHeartDeviceExcepton([String? message])
      : super(
            message,
            "Device Error",
            "There was a problem getting your device information",
            Icons.error_outline);
}
