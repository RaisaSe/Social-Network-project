import 'package:flutter/material.dart';
import 'package:social_network/screens/add_post_screen.dart';
import 'package:social_network/screens/feed_screen.dart';

const webScreenSize = 600;

var homeScreenItems = [
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('notification'),
  Text('profile'),
];
