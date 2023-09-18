part of util;

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}

final GoRouter router = GoRouter(
  initialLocation: '/inicio',
  routes: <RouteBase>[
    GoRoute(
      path: '/inicio',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: '/nueva-tarea',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const NewTask(),
      ),
    ),
    GoRoute(
      path: '/editar-tarea',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const NewTask(),
      ),
    ),
  ],
);
