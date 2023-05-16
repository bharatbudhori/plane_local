import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/auth_provider.dart';
import 'package:plane_startup/provider/profile_provider.dart';
import 'package:plane_startup/provider/workspace_provider.dart';

import 'theme_provider.dart';

class ProviderList {
    static final authProvider =
      ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider(ref));
  static final profileProvider =
      ChangeNotifierProvider<ProfileProvider>((_) => ProfileProvider());

  static final workspaceProvider =
      ChangeNotifierProvider<WorkspaceProvider>((_) => WorkspaceProvider());
   static var themeProvider =
      ChangeNotifierProvider<ThemeProvider>((_) => ThemeProvider());
}
