import 'package:avk/router/path_exporter.dart';

class UserManagementView extends StatefulWidget {
  const UserManagementView({super.key});

  @override
  State<UserManagementView> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementView> {
  late UserManagementBloc _userManagementBloc;

  @override
  void initState() {
    readBaseUrl();
    _userManagementBloc = BlocProvider.of(context);
    _userManagementBloc.add(
      GetUsersEvent(skipIndex: 0, skipLimits: RowPerPageEnum.count25),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserManagementBloc, UserManagementState>(
      builder: (BuildContext context, UserManagementState state) {
        if (state is UserManagementSuccess) {
          return DashboardScaffold(
            isLoading: state.stateEnum == UserManagementStateEnum.loading,
            isEmpty: state.stateEnum == UserManagementStateEnum.empty404,
            headerWidget: <Widget>[
              _buildHeader(context,state.stateEnum == UserManagementStateEnum.empty404),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryAppButton(
                  showAccessError: true,
                  onButtonTap: _inAddUserTap,
                  buttonLabel: context.getText().add_user,
                  isSmall: true,
                  customIcon: Icon(
                    Icons.add,
                    color: context.getColor().surface,
                    size: 20,
                  ),
                ),
              ),
            ],
            child: (state.stateEnum == UserManagementStateEnum.success)
                ? CommonPaginatedTable(
                    rowLoadingStates: state.userList.map((UserEntity user) => user.isLoading??false).toList(),
                    totalItemCount: state.totalUserCount,
                    selectedIndex: state.selectedIndex,
                    skipLimits: state.skipLimits,
                    rowsPerPageEnumValues: RowPerPageEnum.values,
                    onRowPerPageChanged: onRowPerPageChanged,
                    onSkipTap: onSkipTap,
                    headerTitles: <String>[
                      context.getText().s_no,
                      context.getText().email_id,
                      context.getText().roles,
                    ],
                    bodyData: List<List<String>>.generate(
                      state.userList.length,
                      (int i) => <String>[
                        ((i + 1) + state.skipValue).toString(),
                        state.userList[i].email ?? '',
                        state.userList[i].roleName ?? '',
                      ],
                    ),
                    showPopupMenu: true,
                    popupWithReset: true,
                    onEditTap: (int index) => GetIt.I<RouteHelper>().pushNamed(
                      routerKeys.addUser,
                      params: BaseRouteEntity(
                        id: state.userList[index].id ?? '',
                      ),
                    ),
                    onDeleteTap: (int index) async {
                      await dialogHelper.showDeletePopup(
                        context.getText().delete_user,
                        context,
                        () {
                          _userManagementBloc.add(
                            DeleteUserEvent(
                              userID: state.userList[index].id ?? '',
                            ),
                          );
                        },
                        subtitle: context.getText().delete_user_content,
                        content: state.userList[index].email ?? '',
                      );
                    },
                    onResetTap: (int index) async {
                      _userManagementBloc.add(
                        ResetPasswordEvent(
                          password: '',
                          email: state.userList[index].email ?? '',
                          userId: state.userList[index].id ?? '',
                        ),
                      );
                      await dialogHelper.resetPasswordPopup(
                        context,
                        state.userList[index].email ?? '',
                      );
                    },
                  )
                : const SizedBox(),
          );
        }
        return const SizedBox();
      },
    );
  }

  Row _buildHeader(BuildContext context, bool isEmpty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          context.getText().user_management,
          style: context.getStyle().headlineLarge,
        ),
        if(!isEmpty)
        Flexible(
          child: BaseTextFormField(
            isSearchField: true,
            isExtraSmall: true,
            label: context.getText().search,
            onChanged: (String? query) {
              _userManagementBloc.add(
                GetUsersEvent(skipIndex: 0, query: query),
              );
            },
            maxLength: GetIt.I<AppConstants>().fieldLimit100,
            inputFormatters: regexHelper.inputPasswordFormatters,
          ),
        ),
      ],
    );
  }

  void onRowPerPageChanged(RowPerPageEnum? rowPerPageEnum) {
    _userManagementBloc.add(
      GetUsersEvent(skipIndex: 0, skipLimits: rowPerPageEnum),
    );
  }

  void onSkipTap(int skipLimit) {
    _userManagementBloc.add(GetUsersEvent(skipIndex: skipLimit));
  }

  Future<void> _inAddUserTap() async {
    await GetIt.I<RouteHelper>().pushNamed(routerKeys.addUser);
  }
}
