import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Activity {
  final String name;
  final String category;
  final String date;
  final String location;
  final int capacity;
  final String intro;
  final List<String> images;

  Activity({
    required this.name,
    required this.category,
    required this.date,
    required this.location,
    required this.capacity,
    required this.intro,
    required this.images,
  });
}

class Registration {
  final String id;
  final Activity activity;
  final String name;
  final String studentId;
  final String role;
  final bool needMeal;
  final String status;

  Registration({
    required this.id,
    required this.activity,
    required this.name,
    required this.studentId,
    required this.role,
    required this.needMeal,
    this.status = '報名成功',
  });
}

final List<Activity> activities = [
  Activity(
    name: 'AI 人工智慧體驗營',
    category: '科技',
    date: '2026/12/05',
    location: '資訊大樓 305 教室',
    capacity: 30,
    intro: '透過實作體驗機器學習與生成式 AI，適合所有對人工智慧有興趣的同學。',
    images: [
      'https://picsum.photos/seed/ai1/600/400',
      'https://picsum.photos/seed/ai2/600/400',
      'https://picsum.photos/seed/ai3/600/400',
    ],
  ),
  Activity(
    name: 'Flutter APP 開發工作坊',
    category: '科技',
    date: '2026/12/12',
    location: '資訊大樓 401 電腦教室',
    capacity: 25,
    intro: '從零開始學會用 Flutter 開發跨平台手機 APP，現場動手完成作品。',
    images: [
      'https://picsum.photos/seed/flutter1/600/400',
      'https://picsum.photos/seed/flutter2/600/400',
      'https://picsum.photos/seed/flutter3/600/400',
    ],
  ),
  Activity(
    name: '校園攝影創作比賽',
    category: '藝文',
    date: '2026/12/19',
    location: '中央廣場',
    capacity: 40,
    intro: '用鏡頭記錄校園之美，優勝作品將於圖書館展出並頒發獎品。',
    images: [
      'https://picsum.photos/seed/photo1/600/400',
      'https://picsum.photos/seed/photo2/600/400',
      'https://picsum.photos/seed/photo3/600/400',
    ],
  ),
  Activity(
    name: '創意手作設計課程',
    category: '藝文',
    date: '2026/12/26',
    location: '藝術大樓 2 樓工坊',
    capacity: 20,
    intro: '由專業講師帶領，親手製作屬於自己的文創小物，材料由主辦單位提供。',
    images: [
      'https://picsum.photos/seed/craft1/600/400',
      'https://picsum.photos/seed/craft2/600/400',
      'https://picsum.photos/seed/craft3/600/400',
    ],
  ),
  Activity(
    name: '校園路跑活動',
    category: '運動',
    date: '2027/01/09',
    location: '田徑場',
    capacity: 100,
    intro: '全長 5 公里的校園路跑，一起流汗、一起健康，完賽可獲紀念牌。',
    images: [
      'https://picsum.photos/seed/run1/600/400',
      'https://picsum.photos/seed/run2/600/400',
      'https://picsum.photos/seed/run3/600/400',
    ],
  ),
  Activity(
    name: '羽球友誼交流賽',
    category: '運動',
    date: '2027/01/16',
    location: '體育館 羽球場',
    capacity: 32,
    intro: '以球會友的雙打友誼賽，不分系所，歡迎新手與高手同場切磋。',
    images: [
      'https://picsum.photos/seed/badminton1/600/400',
      'https://picsum.photos/seed/badminton2/600/400',
      'https://picsum.photos/seed/badminton3/600/400',
    ],
  ),
];

final List<Registration> registrations = [];

final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

int nextId = 1;

int registeredCount(Activity a) {
  return registrations.where((r) => r.activity.name == a.name).length;
}

int remainingSeats(Activity a) {
  return a.capacity - registeredCount(a);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '智慧校園活動報名',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<String> titles = ['校園活動報名', '我的報名', '活動統計'];
  final List<String> categories = ['全部', '科技', '藝文', '運動'];

  void showAboutAppDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('關於 APP'),
          content: const Text('智慧校園活動報名 APP\n版本：1.0.0\n開發者：Flutter 初學者'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('確定'),
            ),
          ],
        );
      },
    );
  }

  void showAboutSystemDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('關於系統'),
          content: const Text('本系統提供學生瀏覽活動、報名活動與管理報名紀錄。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('關閉'),
            ),
          ],
        );
      },
    );
  }

  void openDetail(Activity activity) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(activity: activity)),
    ).then((_) {
      setState(() {});
    });
  }

  Widget buildActivityList(String category) {
    final List<Activity> list = category == '全部'
        ? activities
        : activities.where((a) => a.category == category).toList();

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: list.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final activity = list[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          child: InkWell(
            onTap: () => openDetail(activity),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  activity.images[0],
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 160,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image)),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text('分類：${activity.category}'),
                      Text('日期：${activity.date}'),
                      Text('地點：${activity.location}'),
                      Text(
                        '名額：剩餘 ${remainingSeats(activity)} / ${activity.capacity}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(titles[currentIndex]),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('目前沒有新通知')));
                  },
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'about') {
                      showAboutAppDialog();
                    } else if (value == 'clear') {
                      setState(() {
                        currentIndex = 0;
                      });
                      DefaultTabController.of(context).animateTo(0);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'about', child: Text('關於 APP')),
                    PopupMenuItem(value: 'clear', child: Text('清除篩選')),
                  ],
                ),
              ],
              bottom: currentIndex == 0
                  ? TabBar(tabs: categories.map((c) => Tab(text: c)).toList())
                  : null,
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.indigo),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '智慧校園活動',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('活動首頁'),
                    onTap: () {
                      setState(() => currentIndex = 0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list_alt),
                    title: const Text('我的報名'),
                    onTap: () {
                      setState(() => currentIndex = 1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: const Text('活動統計'),
                    onTap: () {
                      setState(() => currentIndex = 2);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('關於系統'),
                    onTap: () {
                      Navigator.pop(context);
                      showAboutSystemDialog();
                    },
                  ),
                ],
              ),
            ),
            body: currentIndex == 0
                ? TabBarView(
                    children: categories
                        .map((c) => buildActivityList(c))
                        .toList(),
                  )
                : currentIndex == 1
                ? const MyRegistrationPage()
                : const StatisticsPage(),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Activity activity;
  const DetailPage({super.key, required this.activity});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ValueNotifier<int> imageIndex;

  @override
  void initState() {
    super.initState();
    imageIndex = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    imageIndex.dispose();
    super.dispose();
  }

  void previousImage() {
    final total = widget.activity.images.length;
    imageIndex.value = (imageIndex.value - 1 + total) % total;
  }

  void nextImage() {
    final total = widget.activity.images.length;
    imageIndex.value = (imageIndex.value + 1) % total;
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;
    final seats = remainingSeats(activity);

    return Scaffold(
      appBar: AppBar(title: Text(activity.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: imageIndex,
              builder: (context, index, child) {
                return Column(
                  children: [
                    Image.network(
                      activity.images[index],
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 240,
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.broken_image)),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: previousImage,
                        ),
                        for (int i = 0; i < activity.images.length; i++)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: i == index ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: i == index ? Colors.indigo : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: nextImage,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('分類：${activity.category}'),
                  Text('日期：${activity.date}'),
                  Text('地點：${activity.location}'),
                  Text('剩餘名額：$seats / ${activity.capacity}'),
                  const SizedBox(height: 12),
                  const Text(
                    '活動簡介',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(activity.intro, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: seats <= 0
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage(activity: activity),
                                ),
                              ).then((_) {
                                setState(() {});
                              });
                            },
                      child: Text(seats <= 0 ? '名額已滿' : '我要報名'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  final Activity activity;
  const RegisterPage({super.key, required this.activity});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();

  String role = '一般生';
  bool needMeal = false;
  bool agree = false;

  @override
  void dispose() {
    nameController.dispose();
    studentIdController.dispose();
    super.dispose();
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> chooseRole() async {
    final String? result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('選擇參加身分'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, '一般生'),
              child: const Text('一般生'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, '社團幹部'),
              child: const Text('社團幹部'),
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        role = result;
      });
    }
  }

  Future<void> submit() async {
    final String name = nameController.text.trim();
    final String studentId = studentIdController.text.trim();

    if (name.isEmpty || studentId.isEmpty) {
      showMessage('請輸入姓名與學號');
      return;
    }
    if (!agree) {
      showMessage('請先勾選同意活動注意事項');
      return;
    }

    final bool repeated = registrations.any(
      (r) =>
          r.studentId == studentId && r.activity.name == widget.activity.name,
    );
    if (repeated) {
      showMessage('此學號已報名過這場活動，不可重複報名');
      return;
    }

    if (remainingSeats(widget.activity) <= 0) {
      showMessage('名額已滿');
      return;
    }

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('確認報名資料'),
          content: Text(
            '活動：${widget.activity.name}\n'
            '姓名：$name\n'
            '學號：$studentId\n'
            '身分：$role\n'
            '餐點：${needMeal ? '需要' : '不需要'}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('確認送出'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    final String id = 'R${nextId.toString().padLeft(3, '0')}';
    nextId++;
    registrations.add(
      Registration(
        id: id,
        activity: widget.activity,
        name: name,
        studentId: studentId,
        role: role,
        needMeal: needMeal,
      ),
    );
    listKey.currentState?.insertItem(registrations.length - 1);

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 64),
                const SizedBox(height: 12),
                const Text(
                  '報名成功！',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('活動名稱：${widget.activity.name}'),
                const Text('報名結果：成功'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('確定'),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('活動報名')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '姓名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: studentIdController,
              decoration: const InputDecoration(
                labelText: '學號',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: '活動名稱',
                border: OutlineInputBorder(),
              ),
              child: Text(widget.activity.name),
            ),
            const SizedBox(height: 16),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              title: const Text('參加身分'),
              subtitle: Text(role),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: chooseRole,
            ),
            const SizedBox(height: 16),
            const Text('是否需要餐點', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: needMeal,
                  onChanged: (value) {
                    setState(() => needMeal = value!);
                  },
                ),
                const Text('需要'),
                const SizedBox(width: 24),
                Radio<bool>(
                  value: false,
                  groupValue: needMeal,
                  onChanged: (value) {
                    setState(() => needMeal = value!);
                  },
                ),
                const Text('不需要'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: agree,
                  onChanged: (value) {
                    setState(() => agree = value!);
                  },
                ),
                const Expanded(child: Text('我已閱讀並同意活動注意事項')),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: submit,
                child: const Text('提交報名'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyRegistrationPage extends StatefulWidget {
  const MyRegistrationPage({super.key});

  @override
  State<MyRegistrationPage> createState() => _MyRegistrationPageState();
}

class _MyRegistrationPageState extends State<MyRegistrationPage> {
  Widget buildItem(
    Registration reg,
    Animation<double> animation, {
    bool showButton = true,
  }) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: ListTile(
          leading: CircleAvatar(child: Text(reg.id.substring(1))),
          title: Text(reg.activity.name),
          subtitle: Text('報名編號：${reg.id}\n姓名：${reg.name}\n狀態：${reg.status}'),
          isThreeLine: true,
          trailing: showButton
              ? TextButton(
                  onPressed: () => cancelRegistration(reg),
                  child: const Text(
                    '取消報名',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Future<void> cancelRegistration(Registration reg) async {
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('取消報名'),
          content: Text('確定要取消「${reg.activity.name}」的報名嗎？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('返回'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('確定取消'),
            ),
          ],
        );
      },
    );

    if (ok != true) return;

    final int index = registrations.indexOf(reg);
    if (index < 0) return;
    final Registration removed = registrations.removeAt(index);

    listKey.currentState?.removeItem(
      index,
      (context, animation) => buildItem(removed, animation, showButton: false),
      duration: const Duration(milliseconds: 400),
    );

    setState(() {});

    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('已取消報名')));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedList(
          key: listKey,
          initialItemCount: registrations.length,
          itemBuilder: (context, index, animation) {
            return buildItem(registrations[index], animation);
          },
        ),
        if (registrations.isEmpty)
          const Center(child: Text('目前沒有報名紀錄', style: TextStyle(fontSize: 18))),
      ],
    );
  }
}

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  int countByCategory(String category) {
    return registrations.where((r) => r.activity.category == category).length;
  }

  Widget buildStatCard(String title, int value, IconData icon, Color color) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 18))),
            Text(
              '$value',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          buildStatCard('活動總數', activities.length, Icons.event, Colors.indigo),
          buildStatCard(
            '報名總筆數',
            registrations.length,
            Icons.assignment,
            Colors.deepOrange,
          ),
          buildStatCard(
            '科技類報名',
            countByCategory('科技'),
            Icons.computer,
            Colors.blue,
          ),
          buildStatCard(
            '藝文類報名',
            countByCategory('藝文'),
            Icons.palette,
            Colors.purple,
          ),
          buildStatCard(
            '運動類報名',
            countByCategory('運動'),
            Icons.sports_basketball,
            Colors.green,
          ),
        ],
      ),
    );
  }
}
