import 'dart:math';

String generateRandomHumanName() {
  final List<String> names = <String>[
    'Alberto',
    'Lorenzo',
    'Pippo',
    'Pluto',
    'Topolino',
    'Minnie',
    'Paperino',
    'Paperina',
    'Zio Paperone',
    'Paperoga',
    'Qui',
    'Quo',
    'Qua',
  ];
  final int randomIndex = Random().nextInt(names.length);
  final String name = names[randomIndex];
  return name;
}