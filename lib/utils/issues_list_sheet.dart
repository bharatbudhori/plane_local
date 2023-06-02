import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/config/enums.dart';
import 'package:plane_startup/provider/provider_list.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/custom_text.dart';

class IssuesListSheet extends ConsumerStatefulWidget {
  bool parent;
  String issueId;
  IssuesListSheet({required this.parent, required this.issueId, super.key});

  @override
  ConsumerState<IssuesListSheet> createState() => _IssuesListSheetState();
}

class _IssuesListSheetState extends ConsumerState<IssuesListSheet> {
  @override
  void initState() {
    super.initState();
    ref.read(ProviderList.searchIssueProvider).setStateToLoading();
    ref.read(ProviderList.searchIssueProvider).getIssues(
          slug:
              ref.read(ProviderList.workspaceProvider).currentWorkspace['slug'],
          projectId:
              ref.read(ProviderList.projectProvider).currentProject['id'],
          parent: widget.parent,
        );
  }

  @override
  Widget build(BuildContext context) {
    var searchIssueProvider = ref.watch(ProviderList.searchIssueProvider);
    var searchIssueProviderRead = ref.read(ProviderList.searchIssueProvider);
    var themeProvider = ref.watch(ProviderList.themeProvider);
    var issueProvider = ref.read(ProviderList.issueProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      constraints: BoxConstraints(maxHeight: height * 0.7),
      child: searchIssueProvider.searchIssuesState == AuthStateEnum.loading
          ? Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineSpinFadeLoader,
                  colors: themeProvider.isDarkThemeEnabled
                      ? [Colors.white]
                      : [Colors.black],
                  strokeWidth: 1.0,
                  backgroundColor: Colors.transparent,
                ),
              ),
            )
          : Column(
              children: [
                TextField(
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: greyColor,
                    ),
                  ),
                  onChanged: (value) => searchIssueProviderRead.getIssues(
                      slug: ref
                          .read(ProviderList.workspaceProvider)
                          .currentWorkspace['slug'],
                      projectId: ref
                          .read(ProviderList.projectProvider)
                          .currentProject['id'],
                      input: value,
                      parent: widget.parent),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchIssueProvider.issues.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (widget.parent) {
                              issueProvider.upDateIssue(
                                slug: ref
                                    .read(ProviderList.workspaceProvider)
                                    .currentWorkspace['slug'],
                                projID: ref
                                    .read(ProviderList.projectProvider)
                                    .currentProject['id'],
                                issueID: widget.issueId,
                                data: {
                                  "parent": searchIssueProvider.issues[index]
                                      ['id']
                                },
                                index: index,
                                ref: ref,
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                !widget.parent
                                    ? const Icon(
                                        Icons.check_box,
                                        color: primaryColor,
                                      )
                                    : Container(),
                                CustomText(
                                  searchIssueProvider.issues[index]
                                          ['project__identifier'] +
                                      '-' +
                                      searchIssueProvider.issues[index]
                                              ['sequence_id']
                                          .toString() +
                                      ' ',
                                  type: FontStyle.description,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: width * 0.6,
                                  child: CustomText(
                                    searchIssueProvider.issues[index]['name'] ??
                                        '',
                                    type: FontStyle.description,
                                    maxLines: 4,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                !widget.parent
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {},
                              child: CustomText(
                                'Add issues',
                                type: FontStyle.buttonText,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }
}
