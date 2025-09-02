import 'package:avk/config/extensions/user_management_extensions.dart';
import 'package:avk/model/user_management/user_entity.dart';
import 'package:avk/router/path_exporter.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  UserManagementBloc(this.userManagementController)
    : super(UserManagementInitial()) {
    on<GetUsersEvent>(_onGetUsersEvent);
    on<GetUserDataEvent>(_onGetUserDataEvent);
    on<CreateUserEvent>(_onCreateUserEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<EditUserEvent>(_onEditUserEvent);
    on<DeleteUserEvent>(_onDeleteUserEvent);
  }

  String _createdUserID = '';

  final UserManagementController userManagementController;

  int _totalUserCount = 0;
  RowPerPageEnum _skipLimits = RowPerPageEnum.count25;
  int _selectedIndex = 0;
  int _skipValue = 0;

  List<UserEntity> _users = <UserEntity>[];

  final ProjectSettingsController _projectSettingsController =
      ProjectSettingsController();

  List<NameId> _roleList = <NameId>[];
  List<TreeNode<UserName>> _zoneList = <TreeNode<UserName>>[];

  NameId? _selectedUserRole;

  UserEntity _user = UserEntity();
  FutureOr<void> _onGetUsersEvent(
    GetUsersEvent event,
    Emitter<UserManagementState> emit,
  ) async {
    if(event.skipIndex == 0 && (event.query == null)) {
      _emitState(emit, UserManagementStateEnum.loading);
    }
    if(event.skipLimits!=null){
      _skipLimits = event.skipLimits!;
    }
    final int limit = _skipLimits.index.getRowCount();
    if(event.skipIndex!=null){
      _selectedIndex = event.skipIndex!;
    }

    _skipValue =  limit * _selectedIndex;
    UserPaginationEntity? response = await userManagementController.getUsersController(limit.toString(), _skipValue.toString(),query: event.query);
    if(response!=null){
      _totalUserCount = response.total??0;
      _users = response.users??<UserEntity>[];
      _emitState(emit, UserManagementStateEnum.success);
    }else{
      _emitState(emit, UserManagementStateEnum.empty404);
    }

  }

  FutureOr<void> _onGetUserDataEvent(
    GetUserDataEvent event,
    Emitter<UserManagementState> emit,
  ) async {
    _emitState(emit, UserManagementStateEnum.userLoading);
    final [
      Object? roles,
      Object? zones,
      Object? user,
    ] = await Future.wait(<Future<Object?>>[
      _projectSettingsController.getRoles(),
      if (event.userId.isNotEmpty)
        userManagementController.getZonesList(event.userId)
      else
        _projectSettingsController.getZonesList(),
      userManagementController.getUserData(event.userId),
    ]);
    _roleList = <NameId>[];
    _zoneList = <TreeNode<UserName>>[];
    _user = UserEntity();
    _selectedUserRole = null;
    if (roles != null) {
      _roleList = (roles as List<RoleEntity>).map((RoleEntity e) => NameId(id:e.id??'', name:e.name??'')).toList();
    }
    if (zones != null) {
      _zoneList = GetIt.I<CommonLogics>().convertZonesToTree(
        zones as List<ZoneEntity>,
      );
    }
    if (user != null) {
      _user = user as UserEntity;
      final Iterable<NameId> filterData = _roleList.where(
        (NameId role) => role.id == _user.projectRoleId,
      );
      _selectedUserRole = filterData.isNotEmpty ? filterData.first : null;
    }
    _emitState(emit, UserManagementStateEnum.success);
  }

  void _emitState(
    Emitter<UserManagementState> emit,
    UserManagementStateEnum stateEnum, {
    String? email,
        String? password,
  }) {
    emit(
      UserManagementSuccess(
        skipValue: _skipValue,
        userList: _users,
        selectedUserRole: _selectedUserRole,
        user: _user,
        roleList: _roleList,
        zoneList: _zoneList,
        stateEnum: stateEnum,
        totalUserCount: _totalUserCount,
        skipLimits: _skipLimits,
        selectedIndex: _selectedIndex,
        email: email,
        password: password,
      ),
    );
  }

  FutureOr<void> _onCreateUserEvent(CreateUserEvent event, Emitter<UserManagementState> emit) async{
    _emitState(emit, UserManagementStateEnum.submitLoading);
    Map<String,dynamic> body = <String, dynamic>{
      'email': event.email,
      'site_ids': event.selectedSiteIdss,
      'role_id': event.projectRoleId
    };
    CommonEntity? response = await userManagementController.createUserController(body);
    if(response!=null) {
      _createdUserID = response.userId??'';
      _emitState(emit, UserManagementStateEnum.successPopup,email: event.email,password: response.password);
    }else{
      _emitState(emit, UserManagementStateEnum.success);
    }
  }

  FutureOr<void> _onResetPasswordEvent(ResetPasswordEvent event, Emitter<UserManagementState> emit) async{
    _emitState(emit, UserManagementStateEnum.resetLoading);
    CommonEntity? response = await userManagementController.resetUserController(event.userId??_createdUserID);
    if(response!=null) {
      _emitState(emit, UserManagementStateEnum.success,email: event.email,password: response.password);
    }else{
      _emitState(emit, UserManagementStateEnum.success,email: event.email,password: event.password);
    }
  }

  FutureOr<void> _onEditUserEvent(EditUserEvent event, Emitter<UserManagementState> emit) async{
    _emitState(emit, UserManagementStateEnum.submitLoading);
    Map<String,dynamic> body = <String, dynamic>{
      'email': event.email,
      'site_ids': event.selectedSiteIdss,
      'role_id': event.projectRoleId
    };
    bool response = await userManagementController.editUserController(event.userId,body);
    if(response) {
      _emitState(emit, UserManagementStateEnum.backPop);
    }else{
      _emitState(emit, UserManagementStateEnum.success);
    }
  }

  FutureOr<void> _onDeleteUserEvent(DeleteUserEvent event, Emitter<UserManagementState> emit) async{
    for(UserEntity user in _users){
      if(user.id == event.userID){
        user.isLoading = true;
        break;
      }
    }
    _emitState(emit, UserManagementStateEnum.success);
    bool response = await userManagementController.deleteUserController(event.userID);
    if(response) {
      _users.removeWhere((UserEntity e) => e.id == event.userID);
      if(_users.isEmpty){
        add(GetUsersEvent(skipIndex: _selectedIndex!=0 ? _selectedIndex -1:0));
      }else{
        _emitState(emit, UserManagementStateEnum.success);
      }
    }else{
      _emitState(emit, UserManagementStateEnum.success);
    }
  }
}
