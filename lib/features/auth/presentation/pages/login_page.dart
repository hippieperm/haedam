import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/auth_provider.dart';
import '../../data/models/user_model.dart';
import '../../../../shared/services/firebase_service.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 로고 또는 제목
              const Icon(Icons.local_florist, size: 80, color: Colors.green),
              const SizedBox(height: 24),
              Text(
                '해담에 오신 것을 환영합니다',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '분재 경매 플랫폼',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // 이메일 입력
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: '이메일',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일을 입력해주세요';
                  }
                  if (!value.contains('@')) {
                    return '올바른 이메일 형식을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 비밀번호 입력
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해주세요';
                  }
                  if (value.length < 6) {
                    return '비밀번호는 6자 이상이어야 합니다';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // 로그인 버튼
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('로그인'),
              ),
              const SizedBox(height: 16),

              // 회원가입 링크
              TextButton(
                onPressed: () => context.push('/register'),
                child: const Text('계정이 없으신가요? 회원가입'),
              ),
              const SizedBox(height: 16),

              // 관리자 계정 생성 버튼 (개발용)
              if (kDebugMode)
                ElevatedButton(
                  onPressed: _isLoading ? null : _createAdminAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('관리자 계정 생성 (개발용)'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _createAdminAccount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      const adminEmail = 'goeka@goeka.com';
      const adminPassword = 'ss135798!!';

      final auth = FirebaseService.instance.auth;
      final firestore = FirebaseService.instance.firestore;

      // 이미 로그인된 사용자가 있다면 로그아웃
      if (auth.currentUser != null) {
        await auth.signOut();
      }

      // 먼저 계정 생성 시도
      try {
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: adminEmail,
          password: adminPassword,
        );

        final user = userCredential.user!;

        // 사용자 문서 생성
        final userModel = UserModel(
          id: user.uid,
          email: adminEmail,
          displayName: '관리자',
          roles: {'admin': true, 'seller': true},
          createdAt: DateTime.now(),
          verified: true,
        );

        await firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toJson());

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('관리자 계정이 생성되었습니다'),
              backgroundColor: Colors.green,
            ),
          );
          context.go('/');
        }
      } catch (e) {
        if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
          // 이미 존재하는 계정인 경우 로그인 시도
          try {
            await auth.signInWithEmailAndPassword(
              email: adminEmail,
              password: adminPassword,
            );

            // 관리자 권한 확인 및 설정
            final user = auth.currentUser!;
            final userDoc = await firestore
                .collection('users')
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data()!;
              if (userData['roles']?['admin'] != true) {
                // 관리자 권한 부여
                await firestore.collection('users').doc(user.uid).update({
                  'roles': {'admin': true, 'seller': true},
                });
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('관리자 권한이 부여되었습니다'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('이미 관리자 계정입니다'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
              }
            } else {
              // 사용자 문서가 없는 경우 생성
              final userModel = UserModel(
                id: user.uid,
                email: adminEmail,
                displayName: '관리자',
                roles: {'admin': true, 'seller': true},
                createdAt: DateTime.now(),
                verified: true,
              );

              await firestore
                  .collection('users')
                  .doc(user.uid)
                  .set(userModel.toJson());

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('관리자 계정이 생성되었습니다'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            }

            if (mounted) {
              context.go('/');
            }
          } catch (loginError) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('로그인 중 오류: ${loginError.toString()}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('계정 생성 중 오류: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('오류 발생: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
