import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_template/core/bloc/common_state.dart';
import 'package:flutter_clean_architecture_template/core/widgets/placeholder/common_error_widget.dart';
import 'package:flutter_clean_architecture_template/core/widgets/placeholder/common_loading_widget.dart';

class BlocBuilderWrapper<B extends StateStreamable<CommonState>>
    extends StatelessWidget {
  final BlocWidgetBuilder<CommonState> builder;
  final bool overrideLoading;
  final bool overrideError;
  final B? bloc;
  const BlocBuilderWrapper({
    super.key,
    required this.builder,
    this.overrideError = false,
    this.overrideLoading = false,
    this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, CommonState>(
      bloc: bloc,
      builder: (context, state) {
        if ((state is CommonLoadingState || state is CommonInitialState) &&
            !overrideLoading) {
          return const Center(
            child: CommonLoadingWidget(),
          );
        } else if (state is CommonErrorState && !overrideError) {
          return CommonErrorWidget(
            message: state.message,
          );
        } else {
          return builder(context, state);
        }
      },
    );
  }
}
