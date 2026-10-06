import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const VideosApp());
}

class VideosApp extends StatelessWidget {
  const VideosApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Videos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.redAccent,
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) return const MainScreen();
        return const LoginScreen();
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  bool _isLogin = true;

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      if (_isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text.trim(), password: _pass.text.trim());
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text.trim(), password: _pass.text.trim());
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('خطأ: $e')));
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_circle_fill, size: 100, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text('Videos',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 40),
            TextField(
              controller: _email,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pass,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(_isLogin ? 'تسجيل الدخول' : 'إنشاء حساب',
                        style: const TextStyle(fontSize: 18)),
              ),
            ),
            TextButton(
              onPressed: () => setState(() => _isLogin = !_isLogin),
              child: Text(_isLogin ? 'ليس لديك حساب؟ سجل الآن' : 'لديك حساب؟ ادخل',
                  style: const TextStyle(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  final _pages = const [HomeFeed(), UploadScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'رفع'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('لا توجد فيديوهات بعد',
                  style: TextStyle(color: Colors.white70, fontSize: 18)),
            );
          }
          final docs = snapshot.data!.docs;
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              return VideoCard(videoId: docs[i].id, data: data);
            },
          );
        },
      ),
    );
  }
}

class VideoCard extends StatefulWidget {
  final String videoId;
  final Map<String, dynamic> data;
  const VideoCard({super.key, required this.videoId, required this.data});
  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _liked = false;
  int _likes = 0;

  @override
  void initState() {
    super.initState();
    _likes = widget.data['likes'] ?? 0;
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.data['url']))
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleLike() async {
    setState(() {
      _liked = !_liked;
      _likes += _liked ? 1 : -1;
    });
    await FirebaseFirestore.instance
        .collection('videos')
        .doc(widget.videoId)
        .update({'likes': _likes});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _controller.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
                  });
                },
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        Positioned(
          bottom: 0, left: 0, right: 0, height: 200,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30, left: 16, right: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('@${widget.data['username'] ?? 'user'}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 6),
              Text(widget.data['caption'] ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
        Positioned(
          right: 12, bottom: 80,
          child: Column(
            children: [
              _btn(_liked ? Icons.favorite : Icons.favorite_border,
                  _liked ? Colors.red : Colors.white, '$_likes', _toggleLike),
              const SizedBox(height: 20),
              _btn(Icons.comment, Colors.white, 'تعليق', () {}),
              const SizedBox(height: 20),
              _btn(Icons.share, Colors.white, 'مشاركة', () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _btn(IconData icon, Color color, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 34),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _caption = TextEditingController();
  File? _video;
  bool _uploading = false;
  double _progress = 0;

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final picked = await picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) setState(() => _video = File(picked.path));
  }

  Future<void> _upload() async {
    if (_video == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('اختر فيديو أولاً')));
      return;
    }
    setState(() => _uploading = true);
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final id = const Uuid().v4();
      final ref = FirebaseStorage.instance.ref().child('videos/$id.mp4');
      final task = ref.putFile(_video!);
      task.snapshotEvents.listen((e) {
        setState(() => _progress = e.bytesTransferred / e.totalBytes);
      });
      await task;
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('videos').doc(id).set({
        'url': url,
        'caption': _caption.text.trim(),
        'username': user.email?.split('@')[0] ?? 'user',
        'userId': user.uid,
        'likes': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('تم الرفع بنجاح ✅')));
      setState(() {
        _video = null;
        _caption.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('خطأ: $e')));
    }
    setState(() => _uploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('رفع فيديو'), backgroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickVideo,
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: _video == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_call, size: 60, color: Colors.white54),
                          SizedBox(height: 10),
                          Text('اختر فيديو من المعرض',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      )
                    : const Center(
                        child: Icon(Icons.check_circle, size: 60, color: Colors.green)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _caption,
              style: const TextStyle(color: Colors.white),
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'اكتب وصفاً للفيديو...',
                hintStyle: TextStyle(color: Colors.white38),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
              ),
            ),
            const SizedBox(height: 20),
            if (_uploading)
              LinearProgressIndicator(
                value: _progress,
                color: Colors.redAccent,
                backgroundColor: Colors.white12,
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _uploading ? null : _upload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(_uploading ? 'جاري الرفع...' : 'رفع',
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[800],
            child: const Icon(Icons.person, size: 60, color: Colors.white54),
          ),
          const SizedBox(height: 12),
          Text('@${user?.email?.split('@')[0] ?? 'user'}',
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(user?.email ?? '', style: const TextStyle(color: Colors.white54)),
          const SizedBox(height: 30),
          const Divider(color: Colors.white12),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('فيديوهاتي',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('videos')
                  .where('userId', isEqualTo: user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return const Center(
                    child: Text('لم ترفع فيديوهات بعد',
                        style: TextStyle(color: Colors.white54)),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4,
                  ),
                  itemCount: docs.length,
                  itemBuilder: (context, i) => Container(
                    color: Colors.grey[900],
                    child: const Icon(Icons.play_circle, color: Colors.white54, size: 40),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}