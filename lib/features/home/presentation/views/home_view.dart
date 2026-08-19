import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/failure_view.dart';
import '../../../../core/widgets/responsive_body.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../calls/presentation/widgets/call_record_list.dart';
import '../../../calls/presentation/widgets/quick_dial_strip.dart';
import '../view_models/home_view_model.dart';
import '../widgets/call_status_card.dart';
import '../widgets/greeting_header.dart';

/// The Home tab.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final dimens = context.dimens;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

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
                child: GreetingHeader(greeting: viewModel.greeting),
              ),
              SizedBox(height: dimens.sectionSpacing),
              Padding(
                padding: dimens.screenPadding,
                child: CallStatusCard(settings: viewModel.settings),
              ),
              SizedBox(height: dimens.sectionSpacing),
              const _QuickDialSection(),
              SizedBox(height: dimens.sectionSpacing),
              const _RecentSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickDialSection extends StatelessWidget {
  const _QuickDialSection();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final dimens = context.dimens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: dimens.screenPadding,
          child: const SectionHeader(title: 'Quick dial'),
        ),
        SizedBox(height: dimens.sectionHeaderSpacing),
        if (viewModel.quickDial.isEmpty)
          Padding(
            padding: dimens.screenPadding,
            child: const EmptyState(
              message: 'People you call often will show up here.',
            ),
          )
        else
          QuickDialStrip(entries: viewModel.quickDial),
      ],
    );
  }
}

class _RecentSection extends StatelessWidget {
  const _RecentSection();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final dimens = context.dimens;
    final failure = viewModel.load.failure;

    return Padding(
      padding: dimens.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(
            title: 'Recent',
            actionLabel: viewModel.recentCalls.isEmpty ? null : 'See all',
            onActionPressed: () => context.goNamed(AppRoutes.recentsName),
          ),
          SizedBox(height: dimens.sectionHeaderSpacing),
          if (failure != null)
            FailureView(failure: failure, onRetry: viewModel.refresh)
          else if (viewModel.load.running && viewModel.recentCalls.isEmpty)
            const _SectionLoader()
          else if (viewModel.recentCalls.isEmpty)
            const EmptyState(message: 'Your recent calls will appear here.')
          else
            CallRecordList(records: viewModel.recentCalls, now: viewModel.now),
        ],
      ),
    );
  }
}

class _SectionLoader extends StatelessWidget {
  const _SectionLoader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dimens.spaceXl),
      child: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
