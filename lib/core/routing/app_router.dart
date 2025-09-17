import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/items/presentation/pages/home_page.dart';
import '../../features/items/presentation/pages/item_detail_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/orders/presentation/pages/order_detail_page.dart';
import '../../features/orders/presentation/pages/my_orders_page.dart';
import '../../features/items/presentation/pages/my_bids_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.when(
        data: (user) => user != null,
        loading: () => false,
        error: (_, __) => false,
      );

      final isAdmin = ref.read(isAdminProvider);

      // 로그인이 필요한 페이지들
      final protectedRoutes = ['/profile', '/my-orders', '/my-bids'];
      final adminRoutes = ['/admin'];

      final isProtectedRoute = protectedRoutes.any(
        (route) => state.uri.toString().startsWith(route),
      );
      final isAdminRoute = adminRoutes.any(
        (route) => state.uri.toString().startsWith(route),
      );

      if (isProtectedRoute && !isLoggedIn) {
        return '/login';
      }

      if (isAdminRoute && (!isLoggedIn || !isAdmin)) {
        return '/';
      }

      return null;
    },
    routes: [
      // 홈 페이지
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // 아이템 상세 페이지
      GoRoute(
        path: '/items/:id',
        name: 'item-detail',
        builder: (context, state) {
          final itemId = state.pathParameters['id']!;
          return ItemDetailPage(itemId: itemId);
        },
      ),

      // 인증 관련 페이지
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),

      // 주문 관련 페이지
      GoRoute(
        path: '/orders/:id',
        name: 'order-detail',
        builder: (context, state) {
          final orderId = state.pathParameters['id']!;
          return OrderDetailPage(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/my-orders',
        name: 'my-orders',
        builder: (context, state) => const MyOrdersPage(),
      ),

      // 입찰 관련 페이지
      GoRoute(
        path: '/my-bids',
        name: 'my-bids',
        builder: (context, state) => const MyBidsPage(),
      ),

      // 프로필 페이지
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),

      // 관리자 페이지
      GoRoute(
        path: '/admin',
        name: 'admin',
        builder: (context, state) => const AdminDashboardPage(),
      ),
    ],
  );
});
