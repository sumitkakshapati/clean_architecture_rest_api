import 'package:equatable/equatable.dart';

class GraphqlResponse<T> extends Equatable {
  final T data;
  const GraphqlResponse({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}
