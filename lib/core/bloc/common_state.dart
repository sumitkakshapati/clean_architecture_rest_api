import 'package:equatable/equatable.dart';

abstract class CommonState extends Equatable {}

class CommonInitialState extends CommonState {
  @override
  List<Object?> get props => [];
}

class CommonLoadingState extends CommonState {
  @override
  List<Object?> get props => [];
}

class CommonErrorState extends CommonState {
  final String message;

  CommonErrorState({required this.message});

  @override
  List<String> get props => [message];
}

class CommonSuccessState<Type> extends CommonState {
  final Type? data;

  CommonSuccessState({required this.data});

  @override
  List<Type?> get props => [data];
}
