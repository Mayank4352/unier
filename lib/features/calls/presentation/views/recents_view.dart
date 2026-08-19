import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/failure_view.dart';
import '../../../../core/widgets/responsive_body.dart';
import '../../../../core/widgets/section_header.dart';
import '../view_models/recents_view_model.dart';
import '../widgets/call_record_list.dart';

/// The Recents tab. Styling follows the home design until its own is ready.
class RecentsView extends StatelessWidget {
  const RecentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecentsViewModel>();
    final dimens = context.dimens;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final failure = viewModel.load.failure;

    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: viewModel.refresh,
        child: ResponsiveBody(
          child: ListView(
            padding: EdgeInsets.only(
              top: dimens.screenPaddingTop,
              bottom:
                  dimens.navBarContentHeight +
                  bottomInset +
                  dimens.sectionSpacing,
            ),
            children: <Widget>[
              Padding(
                padding: dimens.screenPadding,
                child: Text(
                  'Recents',
                  style: context.textStyles.greetingTitle.copyWith(
                    color: context.colors.label,
                  ),
                ),
              ),
              SizedBox(height: dimens.sectionSpacing),
              Padding(
                padding: dimens.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SectionHeader(title: 'All calls'),
                    SizedBox(height: dimens.sectionHeaderSpacing),
                    if (failure != null)
                      FailureView(failure: failure, onRetry: viewModel.refresh)
                    else if (viewModel.records.isEmpty)
                      const EmptyState(
                        message: 'Calls you make and receive will appear here.',
                      )
                    else
                      CallRecordList(
                        records: viewModel.records,
                        now: viewModel.now,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
