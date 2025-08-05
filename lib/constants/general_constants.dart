import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

const bool viewLog = true;

const String testImage = 'https://i.imgur.com/X30QPYP.jpg';

String googleApiKey = Platform.isAndroid ? '' : '';
const String sharedKey = '';

int? unReadNotifications = 0;

// **** MediaQuery ****
double pixelRatio = window.devicePixelRatio;

// ----------------------------------------

/// Size in physical pixels
Size physicalScreenSize = window.physicalSize;
double physicalWidth = physicalScreenSize.width;
double physicalHeight = physicalScreenSize.height;

/// Size in logical pixels
Size logicalScreenSize = window.physicalSize / pixelRatio;

///  ignore: duplicate_ignore, non_constant_identifier_names
double DEVICE_WIDTH = logicalScreenSize.width;
// ignore: non_constant_identifier_names
double DEVICE_HEIGHT = logicalScreenSize.height;

dynamic filterMapData;
