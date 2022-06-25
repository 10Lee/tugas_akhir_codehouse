import 'package:flutter_lorem/flutter_lorem.dart';

import 'package:tugas_akhir_stenly_rachmad/models/get_api/result_airsoft_model.dart';

List<ResultsAirsoftModel> ListOfAirsoftItem = [
  ResultsAirsoftModel(
    id: 0,
    name: 'Desert Eagle',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://i.pinimg.com/564x/e5/30/e0/e530e00fd1d86ea5083414526d71a962.jpg',
    qty: 0,
  ),
  ResultsAirsoftModel(
    id: 1,
    name: 'Arctic Warfare Magnum',
    description: lorem(paragraphs: 1, words: 30),
    price: 9000000,
    photo:
        'https://i.pinimg.com/564x/46/c6/d6/46c6d6b43c08996c78d4e069555bea9d.jpg',
    qty: 0,
  ),
  ResultsAirsoftModel(
    id: 2,
    name: 'Desert Eagle',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://i.pinimg.com/564x/73/e0/92/73e092cf6e343a3e3692477bbdcf495d.jpg',
    qty: 0,
  ),
  ResultsAirsoftModel(
    id: 3,
    name: 'Desert Eagle',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://i.pinimg.com/564x/73/e0/92/73e092cf6e343a3e3692477bbdcf495d.jpg',
    qty: 0,
  ),
  ResultsAirsoftModel(
    id: 4,
    name: 'Desert Eagle',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://i.pinimg.com/564x/73/e0/92/73e092cf6e343a3e3692477bbdcf495d.jpg',
    qty: 0,
  ),
  ResultsAirsoftModel(
    id: 5,
    name: 'Desert Eagle',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://i.pinimg.com/564x/73/e0/92/73e092cf6e343a3e3692477bbdcf495d.jpg',
    qty: 0,
  ),
  ResultsAirsoftModel(
    id: 6,
    name: 'Desert Eagle',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://i.pinimg.com/564x/73/e0/92/73e092cf6e343a3e3692477bbdcf495d.jpg',
    qty: 0,
  ),
];

List<ResultsAirsoftModel> listOfHotItem = [
  ResultsAirsoftModel(
    id: 11,
    name: 'Sniper',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://images.unsplash.com/photo-1482649671545-bc53dcf1ad7c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
    qty: 0,
  ),
  ResultsAirsoftModel(
    id: 12,
    name: 'Ammo',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://images.unsplash.com/photo-1517651468335-5164984ba2c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1812&q=80',
    qty: 0,
  ),
  ResultsAirsoftModel(
    id: 10,
    name: 'Suite',
    description: lorem(paragraphs: 1, words: 30),
    price: 2300000,
    photo:
        'https://i.pinimg.com/originals/ba/4f/53/ba4f5374304c5b98f9b67f3d91fc48c4.jpg',
    qty: 0,
  ),
];

class FrontInfo {
  late String title;
  late double rating;
  late int comments;

  FrontInfo({
    required this.title,
    required this.rating,
    required this.comments,
  });
}

List<FrontInfo> frontInfoItems = [
  FrontInfo(title: 'Top Selling Scope', rating: 4.5, comments: 320),
  FrontInfo(title: 'Best Ammo', rating: 4, comments: 121),
  FrontInfo(title: 'Favorite Kevlar', rating: 5, comments: 211),
];
