import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
 final String name;

  const CategoriesEntity({ required this.name});



  @override
  List<Object?> get props => [name];

}