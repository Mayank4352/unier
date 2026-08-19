import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_separator.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/responsive_body.dart';
import '../view_models/contacts_view_model.dart';
import '../widgets/contact_permission_prompt.dart';
import '../widgets/contact_tile.dart';

// The Contacts tab. Styling follows the home design until its own is ready.
class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<ContactsViewModel>();
    if (viewModel.load.result == null && !viewModel.load.running) {
      viewModel.load.execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ContactsViewModel>();
    final dimens = context.dimens;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final permissionFailure = viewModel.permissionFailure;
    final contacts = viewModel.contacts;

    return SafeArea(
      bottom: false,
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
                'Contacts',
                style: context.textStyles.greetingTitle.copyWith(
                  color: context.colors.label,
                ),
              ),
            ),
            SizedBox(height: dimens.sectionSpacing),
            if (permissionFailure != null)
              Padding(
                padding: dimens.screenPadding,
                child: ContactPermissionPrompt(
                  failure: permissionFailure,
                  onGrantPressed: viewModel.resolvePermission,
                ),
              )
            else ...<Widget>[
              Padding(
                padding: dimens.screenPadding,
                child: _SearchField(
                  value: viewModel.query,
                  onChanged: (value) => viewModel.query = value,
                ),
              ),
              SizedBox(height: dimens.sectionSpacing),
              if (viewModel.load.running && contacts.isEmpty)
                const Center(child: CircularProgressIndicator.adaptive())
              else if (contacts.isEmpty)
                Padding(
                  padding: dimens.screenPadding,
                  child: EmptyState(
                    message: viewModel.query.isEmpty
                        ? 'No contacts on this device yet.'
                        : 'No contacts match "${viewModel.query}".',
                  ),
                )
              else
                Padding(
                  padding: dimens.screenPadding,
                  child: AppCard(
                    padding: EdgeInsets.zero,
                    clipContents: true,
                    child: Column(
                      children: <Widget>[
                        for (final (index, contact)
                            in contacts.indexed) ...<Widget>[
                          if (index > 0) const AppSeparator(),
                          ContactTile(contact: contact),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final dimens = context.dimens;

    return TextField(
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      style: context.textStyles.listTitle.copyWith(color: colors.label),
      decoration: InputDecoration(
        hintText: 'Search contacts',
        hintStyle: context.textStyles.listTitle.copyWith(
          color: colors.secondaryLabel,
        ),
        filled: true,
        fillColor: colors.fill,
        prefixIcon: Icon(Icons.search, color: colors.secondaryLabel),
        contentPadding: EdgeInsets.symmetric(vertical: dimens.spaceMd),
        border: OutlineInputBorder(
          borderRadius: dimens.chipBorderRadius,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
