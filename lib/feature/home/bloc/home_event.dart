import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent();
}

class HomeStarted extends HomeEvent {

  HomeStarted();

  @override
  List<Object> get props => [];
}

class HomeExpiredStarted extends HomeEvent {
  final String status;

  HomeExpiredStarted({@required this.status});

  @override
  List<Object> get props => [];
}

class HomeTapped extends HomeEvent {
  final int index;
  final String status;

  HomeTapped({@required this.index, @required this.status});

  @override
  String toString() => 'HomeTapped: $index, status : $status';

  @override
  List<Object> get props => [index, status];
}

class ProductCategoryTapped extends HomeEvent {
  final String text;
  final int id;

  ProductCategoryTapped({@required this.text, @required this.id});

  @override
  List<Object> get props => [text, id];
}

class NewShared extends HomeEvent {
  @override
  List<Object> get props => [];
}

class EditButtonPressed extends HomeEvent {
  final String name;
  final String purchase_date;
  final int warranty_month;
  final String description;
  final String note;
  final int category_id;
  final int brand_id;
  final int supplier_id;
  final int product_id;
  final String photo;
  final String receipt0;
  final String receipt1;
  final String receipt2;

  EditButtonPressed(
      {@required this.name,
      @required this.purchase_date,
      @required this.warranty_month,
      @required this.description,
      @required this.note,
      @required this.category_id,
      @required this.brand_id,
      @required this.supplier_id,
      @required this.product_id,
      @required this.photo,
      @required this.receipt0,
      @required this.receipt1,
      @required this.receipt2});

  @override
  List<Object> get props => [name, product_id];

  @override
  String toString() =>
      'EditButtonPressed { name: $name, product_id: $product_id}';
}

class DeleteButtonPressed extends HomeEvent {
  final int product_id;

  DeleteButtonPressed({
    @required this.product_id,
  });

  @override
  List<Object> get props => [product_id];

  @override
  String toString() => 'DeleteButtonPressed {product_id: $product_id}';
}

class NewPageProduct extends HomeEvent {

  NewPageProduct();

  @override
  List<Object> get props => [];
}

class EmptyHome extends HomeEvent {
  final String text;

  EmptyHome({@required this.text});

  @override
  String toString() => "$text";

  @override
  List<Object> get props => [text];
}
