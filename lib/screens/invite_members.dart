import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/utils/custom_appBar.dart';
import 'package:plane_startup/utils/submit_button.dart';
import 'package:plane_startup/widgets/loading_widget.dart';

import '../provider/provider_list.dart';
import '../utils/constants.dart';
import '../utils/custom_text.dart';

class InviteMembers extends ConsumerStatefulWidget {
  const InviteMembers({super.key});

  @override
  ConsumerState<InviteMembers> createState() => _InviteMembersState();
}

class _InviteMembersState extends ConsumerState<InviteMembers> {
  TextEditingController _emailController = TextEditingController();
  String _role = '';
  String _displayRole = '';
  TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var workspaceProvider = ref.watch(ProviderList.workspaceProvider);
    return Scaffold(
      // backgroundColor: themeProvider.isDarkThemeEnabled
      //     ? darkSecondaryBackgroundColor
      //     : lightSecondaryBackgroundColor,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: 'Invite Members',
      ),
      body: LoadingWidget(
        loading:
            workspaceProvider.workspaceInvitationState == AuthStateEnum.loading,
        widgetClass: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Email',
                        type: FontStyle.title,
                      ),
                      CustomText(
                        '*',
                        type: FontStyle.appbarTitle,
                        color: Colors.red,
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  controller: _emailController,
                  decoration: kTextFieldDecoration.copyWith(
                    fillColor: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    filled: true,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: Row(
                    children: [
                      CustomText(
                        'Role',
                        type: FontStyle.title,
                      ),
                      CustomText(
                        '*',
                        type: FontStyle.appbarTitle,
                        color: Colors.red,
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                decoration: BoxDecoration(
                    color: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadius.circular(4)),
                child: DropdownButtonFormField(
                    dropdownColor: themeProvider.isDarkThemeEnabled
                        ? darkSecondaryBackgroundColor
                        : lightSecondaryBackgroundColor,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'Admin',
                        child: CustomText(
                          'Admin',
                          type: FontStyle.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Member',
                        child: CustomText(
                          'Member',
                          type: FontStyle.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Viewer',
                        child: CustomText(
                          'Viewer',
                          type: FontStyle.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Guest',
                        child: CustomText(
                          'Guest',
                          type: FontStyle.subtitle,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      setState(() {
                        _displayRole = val!;
                        if (_displayRole == 'Admin') {
                          _role = '20';
                        } else if (_displayRole == 'Member') {
                          _role = '15';
                        } else if (_displayRole == 'Viewer') {
                          _role = '10';
                        } else if (_displayRole == 'Guest') {
                          _role = '5';
                        }
                      });
                    }),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 5),
                  child: CustomText(
                    'Message ',
                    type: FontStyle.title,
                  )),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  controller: _messageController,
                  maxLines: 6,
                  decoration: kTextFieldDecoration.copyWith(
                    fillColor: themeProvider.isDarkThemeEnabled
                        ? darkBackgroundColor
                        : lightBackgroundColor,
                    filled: true,
                  ),
                ),
              ),

              //button for invite at bottom
              SizedBox(
                height: 150,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: 20,
                ),
                child: SubmitButton(
                  onPressed: () {
                    workspaceProvider.inviteToWorkspace(
                      slug: workspaceProvider.selectedWorkspace!.workspaceSlug,
                      email: _emailController.text,
                      role: _role,
                    );
                  },
                  text: 'Invite',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
