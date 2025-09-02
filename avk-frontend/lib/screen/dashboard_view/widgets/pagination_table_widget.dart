import 'package:avk/config/extensions/user_management_extensions.dart';
import 'package:avk/router/path_exporter.dart';

class CommonPaginatedTable extends StatelessWidget {
  const CommonPaginatedTable({
    super.key,
    required this.totalItemCount,
    required this.selectedIndex,
    required this.onRowPerPageChanged,
    required this.onSkipTap,
    required this.skipLimits,
    required this.rowsPerPageEnumValues,
    required this.headerTitles,
    required this.bodyData,
    this.headerCellBuilder,
    this.bodyCellBuilder,
    this.pageLabelText = 'pages',
    this.showPopupMenu = false,
    this.onEditTap,
    this.onDeleteTap,
    this.onResetTap,
    this.popupWithReset = false,
    this.rowLoadingStates,
  });

  final int totalItemCount;
  final int selectedIndex;
  final void Function(RowPerPageEnum? rowPerPageEnum) onRowPerPageChanged;
  final void Function(int skipLimit) onSkipTap;
  final RowPerPageEnum skipLimits;
  final List<RowPerPageEnum> rowsPerPageEnumValues;

  final List<String> headerTitles;
  final List<List<String>> bodyData;

  final Widget Function(String text, int index)? headerCellBuilder;
  final Widget Function(String text, int rowIndex, int colIndex)?
  bodyCellBuilder;

  final String pageLabelText;

  // New Features
  final bool showPopupMenu;
  final void Function(int rowIndex)? onEditTap;
  final void Function(int rowIndex)? onDeleteTap;
  final void Function(int rowIndex)? onResetTap;

  final bool popupWithReset;

  final List<bool>? rowLoadingStates; // optional loading state per row

  @override
  Widget build(BuildContext context) {
    final int pageCount = (totalItemCount / skipLimits.index.getRowCount())
        .ceil();

    return bodyData.isNotEmpty
        ? Column(
            spacing: 20,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ValueListenableBuilder<bool>(
                  valueListenable: drawerShrinkNotifier,
                  builder: (BuildContext context, bool isShrinked, _) {
                    return SizedBox(
                      width: !context.isLargeScreen()
                          ? 800
                          : MediaQuery.of(context).size.width -
                                ((isShrinked
                                        ? appConstants.minDrawerWidgetWidth
                                        : appConstants.maxDrawerWidgetWidth) +
                                    50),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: context.getColor().primaryContainer,
                          ),
                        ),
                        child: Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(4),
                            2: FlexColumnWidth(5),
                          },
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: context.getColor().primaryContainer,
                            ),
                            // top: BorderSide(color: context.getColor().primaryContainer),
                            // bottom: BorderSide(color: context.getColor().primaryContainer),
                            // right: BorderSide(color: context.getColor().primaryContainer),
                            // left: BorderSide(color: context.getColor().primaryContainer),
                            verticalInside: const BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: <TableRow>[
                            TableRow(
                              children: <Widget>[
                                ...List<dynamic>.generate(
                                  headerTitles.length,
                                  (int i) =>
                                      headerCellBuilder?.call(
                                        headerTitles[i],
                                        i,
                                      ) ??
                                      _defaultHeaderCell(
                                        headerTitles[i],
                                        context,
                                      ),
                                ),
                                if (showPopupMenu)
                                  const SizedBox(), // No header for popup
                              ],
                            ),
                            ...List<dynamic>.generate(
                              bodyData.length,
                              (int row) => TableRow(
                                children: <Widget>[
                                  ...List<dynamic>.generate(
                                    bodyData[row].length,
                                    (int col) =>
                                        bodyCellBuilder?.call(
                                          bodyData[row][col],
                                          row,
                                          col,
                                        ) ??
                                        _defaultBodyCell(
                                          bodyData[row][col],
                                          context,
                                        ),
                                  ),
                                  if (showPopupMenu)
                                    popupWithReset
                                        ? _popupMenuWithReset(context, row)
                                        : _popupMenu(context, row),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (pageCount > 1) _paginationView(context, pageCount),
              const SizedBox(height: 50),
            ],
          )
        : Center(
            child: SizedBox(
              height: context.getSize().height * 0.7,
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  appSvg.noDataIcon,
                  Text(
                    context.getText().no_data_found,
                    style: context.getStyle().headlineLarge,
                  ),
                ],
              ),
            ),
          );
  }

  Widget _paginationView(BuildContext context, int pageCount) {
    return Column(
      spacing: 20,
      children: <Widget>[
        Row(
          mainAxisAlignment: context.isMobile()
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 15,
                children: <Widget>[
                  FadeAndDisableWrapper(
                    isFade: selectedIndex == 0,
                    isDisable: selectedIndex == 0,
                    child: Row(
                      spacing: 15,
                      children: <Widget>[
                        BaseButton(
                          onTap: () => onSkipTap(0),
                          child: appSvg.overAllSkipLeftIcon,
                        ),
                        BaseButton(
                          onTap: () => onSkipTap(selectedIndex - 1),
                          child: appSvg.skipLeftIcon,
                        ),
                      ],
                    ),
                  ),
                  Flexible(child: _countWidget(context, pageCount)),
                  FadeAndDisableWrapper(
                    isFade: selectedIndex == pageCount - 1,
                    isDisable: selectedIndex == pageCount - 1,
                    child: Row(
                      spacing: 15,
                      children: <Widget>[
                        BaseButton(
                          onTap: () => onSkipTap(selectedIndex + 1),
                          child: appSvg.skipRightIcon,
                        ),
                        BaseButton(
                          onTap: () => onSkipTap(pageCount - 1),
                          child: appSvg.overAllSkipRightIcon,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!context.isMobile()) ...<Widget>[
              Text(
                '${selectedIndex + 1} of $pageCount $pageLabelText',
                style: context.getStyle().labelSmall,
              ),
              SizedBox(
                width: 120,
                child: EnumDropdown<RowPerPageEnum>(
                  isSearchFieldRequired: false,
                  items: rowsPerPageEnumValues,
                  selectedItem: skipLimits,
                  onChanged: onRowPerPageChanged,
                  itemLabelBuilder: (RowPerPageEnum item) =>
                      item.index.getRowCount().toString(),
                  headerLabelBuilder: (RowPerPageEnum item) =>
                      item.index.getRowCount().toString(),
                  hintText: context.getText().rows_per_page,
                ),
              ),
            ],
          ],
        ),
        if (context.isMobile()) ...<Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${selectedIndex + 1} of $pageCount $pageLabelText',
                style: context.getStyle().labelSmall,
              ),
              SizedBox(
                width: 120,
                child: EnumDropdown<RowPerPageEnum>(
                  isSearchFieldRequired: false,
                  items: rowsPerPageEnumValues,
                  selectedItem: skipLimits,
                  onChanged: onRowPerPageChanged,
                  itemLabelBuilder: (RowPerPageEnum item) =>
                      item.index.getRowCount().toString(),
                  headerLabelBuilder: (RowPerPageEnum item) =>
                      item.index.getRowCount().toString(),
                  hintText: context.getText().rows_per_page,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _popupMenu(BuildContext context, int rowIndex) {
    final bool isLoading = rowLoadingStates?[rowIndex] ?? false;
    if(isLoading){
      return const AppLoader(isSmall: true,);
    }
    return Align(
      alignment: Alignment.centerRight,
      child: CustomPopupMenu<EditDeleteEnum>(
        menuItems: EditDeleteEnum.values,
        onSelected: (EditDeleteEnum value) {
          switch (value) {
            case EditDeleteEnum.edit:
              onEditTap?.call(rowIndex);
            case EditDeleteEnum.delete:
              onDeleteTap?.call(rowIndex);
          }
        },
        iconBuilder: (EditDeleteEnum value) {
          switch (value) {
            case EditDeleteEnum.edit:
              return appSvg.editIcon;
            case EditDeleteEnum.delete:
              return appSvg.deleteIcon;
          }
        },
        labelBuilder: (EditDeleteEnum value) {
          switch (value) {
            case EditDeleteEnum.edit:
              return context.getText().edit;
            case EditDeleteEnum.delete:
              return context.getText().delete;
          }
        },
      ),
    );
  }

  Widget _popupMenuWithReset(BuildContext context, int rowIndex) {
    final bool isLoading = rowLoadingStates?[rowIndex] ?? false;
    if(isLoading){
      return const AppLoader(isSmall: true,);
    }
    return Align(
      alignment: Alignment.centerRight,
      child: CustomPopupMenu<UserManagementPopupEnum>(
        menuItems: UserManagementPopupEnum.values,
        onSelected: (UserManagementPopupEnum value) {
          switch (value) {
            case UserManagementPopupEnum.edit:
              onEditTap?.call(rowIndex);
            case UserManagementPopupEnum.delete:
              onDeleteTap?.call(rowIndex);
            case UserManagementPopupEnum.resetPassword:
              onResetTap?.call(rowIndex);
          }
        },
        iconBuilder: (UserManagementPopupEnum value) {
          switch (value) {
            case UserManagementPopupEnum.edit:
              return appSvg.editIcon;
            case UserManagementPopupEnum.delete:
              return appSvg.deleteIcon;
            case UserManagementPopupEnum.resetPassword:
              return SizedBox(
                height: 30,
                width: 30,
                child: appSvg.resetPasswordIcon,
              );
          }
        },
        labelBuilder: (UserManagementPopupEnum value) {
          switch (value) {
            case UserManagementPopupEnum.edit:
              return context.getText().edit;
            case UserManagementPopupEnum.delete:
              return context.getText().delete;
            case UserManagementPopupEnum.resetPassword:
              return context.getText().reset_password;
          }
        },
      ),
    );
  }

  Widget _countWidget(BuildContext context, int pageCount) {
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(maxWidth: 250),
      height: 28,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: pageCount,
        itemBuilder: (BuildContext context, int i) {
          return BaseButton(
            onTap: () => onSkipTap(i),
            child: Container(
              height: 28,
              width: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: selectedIndex == i
                    ? context.getColor().primaryFixed
                    : Colors.transparent,
              ),
              child: Text(
                (i + 1).toString(),
                style: context.getStyle().labelSmall,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _defaultHeaderCell(String text, BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
      child: Text(text, style: context.getStyle().bodyLarge),
    );
  }

  Widget _defaultBodyCell(String text, BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
      child: Text(text, style: context.getStyle().bodySmall),
    );
  }
}
