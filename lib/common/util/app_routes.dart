import 'package:distributed_activity_tracker/screens/AddActivityPage/add_activity_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/ActivityPage/activity_page.dart';
import '../../screens/HomePage/home_page.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'activity/new',
            builder: (BuildContext context, GoRouterState state) {
              return AddActivityPage(
                addNewActivity: (state.extra as Map)['addNewActivity'],
              );
            },
          ),
          GoRoute(
            path: 'activity/:id',
            builder: (BuildContext context, GoRouterState state) {
              final params = (state.extra as Map);
              return ActivityPage(
                activity: params['activity'],
                updateActivity: params['updateActivity'],
                deleteActivity: params['deleteActivity'],
                color: params['color'],
              );
            },
          ),
        ],
      ),
    ],
  );
}
