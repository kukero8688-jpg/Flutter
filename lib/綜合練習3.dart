import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Expense {
  final String id;
  final String type;
  final String category;
  final String title;
  final double amount;
  final String note;

  Expense({
    required this.id,
    required this.type,
    required this.category,
    required this.title,
    required this.amount,
    required this.note,
  });
}

final List<Expense> initialTestExpenses = [
  Expense(
    id: '1',
    type: '支出',
    category: '餐飲',
    title: '早餐',
    amount: 80.0,
    note: '麥當勞',
  ),
  Expense(
    id: '2',
    type: '支出',
    category: '交通',
    title: '公車',
    amount: 30.0,
    note: '悠遊卡',
  ),
  Expense(
    id: '3',
    type: '支出',
    category: '購物',
    title: '文具用品',
    amount: 150.0,
    note: '筆記本與筆',
  ),
  Expense(
    id: '4',
    type: '收入',
    category: '薪資',
    title: '兼職薪水',
    amount: 5000.0,
    note: '本月家教',
  ),
  Expense(
    id: '5',
    type: '支出',
    category: '娛樂',
    title: '電影票',
    amount: 320.0,
    note: '週末看電影',
  ),
  Expense(
    id: '6',
    type: '支出',
    category: '餐飲',
    title: '晚餐',
    amount: 180.0,
    note: '火鍋',
  ),
];

final ValueNotifier<List<Expense>> expensesNotifier = ValueNotifier([]);
final ValueNotifier<String> filterNotifier = ValueNotifier('全部紀錄');
final ValueNotifier<String> userNameNotifier = ValueNotifier('記帳達人');
final ValueNotifier<double> budgetNotifier = ValueNotifier(10000.0);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的智慧記帳 APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
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
  final ValueNotifier<int> _drawerIndexNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  @override
  void dispose() {
    _drawerIndexNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedList = prefs.getStringList('saved_expenses');

    if (savedList == null || savedList.isEmpty) {
      expensesNotifier.value = List.from(initialTestExpenses);
      await _saveExpensesToPrefs(expensesNotifier.value);
    } else {
      final List<Expense> loaded = [];
      for (var str in savedList) {
        final parts = str.split('|');
        if (parts.length >= 5) {
          loaded.add(
            Expense(
              id: parts[0],
              type: parts[1],
              category: parts[2],
              title: parts[3],
              amount: double.tryParse(parts[4]) ?? 0.0,
              note: parts.length > 5 ? parts[5] : '',
            ),
          );
        }
      }
      expensesNotifier.value = loaded;
    }

    userNameNotifier.value = prefs.getString('user_name') ?? '記帳達人';
    budgetNotifier.value = prefs.getDouble('monthly_budget') ?? 10000.0;
  }

  Future<void> _saveExpensesToPrefs(List<Expense> list) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stringList = [];
    for (var e in list) {
      stringList.add(
        '${e.id}|${e.type}|${e.category}|${e.title}|${e.amount}|${e.note}',
      );
    }
    await prefs.setStringList('saved_expenses', stringList);
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('關於 APP'),
        content: const Text('我的智慧記帳 APP v1.0\n協助您輕鬆記錄收支，管理個人預算！'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('關閉'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _drawerIndexNotifier,
      builder: (context, drawerIndex, _) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: userNameNotifier,
                  builder: (context, userName, _) {
                    return UserAccountsDrawerHeader(
                      accountName: Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      accountEmail: const Text('smart_budget@app.com'),
                      currentAccountPicture: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.account_balance_wallet,
                          size: 40,
                          color: Colors.teal,
                        ),
                      ),
                      decoration: const BoxDecoration(color: Colors.teal),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('記帳首頁'),
                  selected: drawerIndex == 0,
                  onTap: () {
                    _drawerIndexNotifier.value = 0;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_circle_outline),
                  title: const Text('新增紀錄'),
                  selected: drawerIndex == 1,
                  onTap: () {
                    _drawerIndexNotifier.value = 1;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.pie_chart_outline),
                  title: const Text('收支統計'),
                  selected: drawerIndex == 2,
                  onTap: () {
                    _drawerIndexNotifier.value = 2;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('個人設定'),
                  selected: drawerIndex == 3,
                  onTap: () {
                    _drawerIndexNotifier.value = 3;
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('關於 APP'),
                  onTap: () {
                    Navigator.pop(context);
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),
          ),
          body: IndexedStack(
            index: drawerIndex,
            children: [
              HomePage(onSaveExpenses: _saveExpensesToPrefs),
              AddRecordPage(
                onSaveExpenses: _saveExpensesToPrefs,
                onRecordAdded: () {
                  _drawerIndexNotifier.value = 0;
                },
              ),
              const StatsPage(),
              const SettingsPage(),
            ],
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final Future<void> Function(List<Expense>) onSaveExpenses;

  const HomePage({super.key, required this.onSaveExpenses});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _deleteExpense(BuildContext context, Expense item) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('刪除紀錄確認'),
        content: Text('確定要刪除「${item.title}」這筆紀錄嗎？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogCtx);
              final currentList = List<Expense>.from(expensesNotifier.value);
              final removeIndex = currentList.indexWhere(
                (e) => e.id == item.id,
              );
              if (removeIndex != -1) {
                final removedItem = currentList.removeAt(removeIndex);
                expensesNotifier.value = currentList;
                await widget.onSaveExpenses(currentList);

                _listKey.currentState?.removeItem(
                  removeIndex,
                  (context, animation) => SizeTransition(
                    sizeFactor: animation,
                    child: _buildExpenseTile(removedItem, null),
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('已刪除該筆紀錄'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('確定刪除'),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseTile(Expense item, VoidCallback? onDelete) {
    final isIncome = item.type == '收入';
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isIncome
              ? Colors.green.shade100
              : Colors.red.shade100,
          child: Icon(
            isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          '${item.category} ｜ ${item.note.isEmpty ? "無備註" : item.note}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${isIncome ? "+" : "-"}\$${item.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isIncome ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的智慧記帳 APP'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              filterNotifier.value = value;
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: '全部紀錄', child: Text('全部紀錄')),
              const PopupMenuItem(value: '只看收入', child: Text('只看收入')),
              const PopupMenuItem(value: '只看支出', child: Text('只看支出')),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Expense>>(
        valueListenable: expensesNotifier,
        builder: (context, allExpenses, _) {
          double totalIncome = 0;
          double totalExpense = 0;

          for (var item in allExpenses) {
            if (item.type == '收入') {
              totalIncome += item.amount;
            } else {
              totalExpense += item.amount;
            }
          }

          final balance = totalIncome - totalExpense;

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(12),
                color: Colors.teal.shade50,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                '總收入',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '+\$${totalIncome.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 30, width: 1, color: Colors.grey),
                          Column(
                            children: [
                              const Text(
                                '總支出',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '-\$${totalExpense.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 30, width: 1, color: Colors.grey),
                          Column(
                            children: [
                              const Text(
                                '結餘',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${balance.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: balance >= 0
                                      ? Colors.teal
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder<String>(
                valueListenable: filterNotifier,
                builder: (context, filter, _) {
                  List<Expense> filteredList = allExpenses;
                  if (filter == '只看收入') {
                    filteredList = allExpenses
                        .where((e) => e.type == '收入')
                        .toList();
                  } else if (filter == '只看支出') {
                    filteredList = allExpenses
                        .where((e) => e.type == '支出')
                        .toList();
                  }

                  if (filteredList.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          '目前無對應的記帳紀錄',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: filteredList.length,
                      itemBuilder: (context, index, animation) {
                        if (index >= filteredList.length)
                          return const SizedBox();
                        final item = filteredList[index];
                        return SizeTransition(
                          sizeFactor: animation,
                          child: _buildExpenseTile(
                            item,
                            () => _deleteExpense(context, item),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class AddRecordPage extends StatefulWidget {
  final Future<void> Function(List<Expense>) onSaveExpenses;
  final VoidCallback onRecordAdded;

  const AddRecordPage({
    super.key,
    required this.onSaveExpenses,
    required this.onRecordAdded,
  });

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  String _type = '支出';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _category = '餐飲';

  final List<String> _expenseCategories = ['餐飲', '交通', '購物', '娛樂', '其他'];
  final List<String> _incomeCategories = ['薪資', '獎金', '投資', '其他'];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final title = _titleController.text.trim();
    final amountText = _amountController.text.trim();
    final note = _noteController.text.trim();
    final double? amount = double.tryParse(amountText);

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('項目名稱不可空白'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('請輸入大於 0 的有效金額'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('確認新增記帳紀錄'),
        content: Text(
          '類型：$_type\n項目：$title\n金額：\$${amount.toStringAsFixed(0)}\n分類：$_category\n備註：${note.isEmpty ? "無" : note}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogCtx);

              final newExpense = Expense(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                type: _type,
                category: _category,
                title: title,
                amount: amount,
                note: note,
              );

              final currentList = List<Expense>.from(expensesNotifier.value);
              currentList.add(newExpense);
              expensesNotifier.value = currentList;
              await widget.onSaveExpenses(currentList);

              _titleController.clear();
              _amountController.clear();
              _noteController.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('已成功新增記帳紀錄！'),
                  duration: Duration(seconds: 2),
                ),
              );

              widget.onRecordAdded();
            },
            child: const Text('確認新增'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCategories = _type == '支出'
        ? _expenseCategories
        : _incomeCategories;

    return Scaffold(
      appBar: AppBar(title: const Text('新增收支紀錄')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '收支類型',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('支出'),
                    value: '支出',
                    groupValue: _type,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _type = val;
                          _category = _expenseCategories.first;
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('收入'),
                    value: '收入',
                    groupValue: _type,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _type = val;
                          _category = _incomeCategories.first;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '項目名稱',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '金額',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '分類',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: currentCategories.map((c) {
                return DropdownMenuItem(value: c, child: Text(c));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _category = val;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: '備註（可不填）',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: const Text('儲存紀錄', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  Widget _buildCategoryStats(List<Expense> expenses, String targetType) {
    final filtered = expenses.where((e) => e.type == targetType).toList();
    final Map<String, double> categoryTotals = {};

    double totalSum = 0;
    for (var e in filtered) {
      categoryTotals[e.category] = (categoryTotals[e.category] ?? 0) + e.amount;
      totalSum += e.amount;
    }

    if (categoryTotals.isEmpty) {
      return Center(
        child: Text('無 $targetType 資料', style: const TextStyle(fontSize: 16)),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: categoryTotals.entries.map((entry) {
        final percentage = totalSum > 0 ? (entry.value / totalSum * 100) : 0.0;
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${entry.value.toStringAsFixed(0)} (${percentage.toStringAsFixed(1)}%)',
                  style: const TextStyle(fontSize: 16, color: Colors.teal),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('收支分類統計'),
          bottom: const TabBar(
            tabs: [
              Tab(text: '支出分類'),
              Tab(text: '收入分類'),
            ],
          ),
        ),
        body: ValueListenableBuilder<List<Expense>>(
          valueListenable: expensesNotifier,
          builder: (context, expenses, _) {
            return TabBarView(
              children: [
                _buildCategoryStats(expenses, '支出'),
                _buildCategoryStats(expenses, '收入'),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _nameController;
  late TextEditingController _budgetController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: userNameNotifier.value);
    _budgetController = TextEditingController(
      text: budgetNotifier.value.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _saveSettings() async {
    final name = _nameController.text.trim();
    final budgetText = _budgetController.text.trim();
    final double? budget = double.tryParse(budgetText);

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('使用者名稱不可空白'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (budget == null || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('請輸入有效的每月預算'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setDouble('monthly_budget', budget);

    userNameNotifier.value = name;
    budgetNotifier.value = budget;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('個人設定已成功更新！'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('個人設定')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '使用者名稱',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '每月預算',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveSettings,
                child: const Text('儲存設定', style: TextStyle(fontSize: 18)),
              ),
            ),
            const Divider(height: 40),
            const Text(
              '每月預算使用進度',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<List<Expense>>(
              valueListenable: expensesNotifier,
              builder: (context, expenses, _) {
                return ValueListenableBuilder<double>(
                  valueListenable: budgetNotifier,
                  builder: (context, budget, _) {
                    double totalExpense = 0;
                    for (var e in expenses) {
                      if (e.type == '支出') {
                        totalExpense += e.amount;
                      }
                    }

                    final ratio = budget > 0
                        ? (totalExpense / budget).clamp(0.0, 1.0)
                        : 0.0;
                    final percentage = (ratio * 100).toStringAsFixed(1);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '已支出 \$${totalExpense.toStringAsFixed(0)} / 每月預算 \$${budget.toStringAsFixed(0)} ($percentage%)',
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            Container(
                              height: 20,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: ratio,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: 20,
                                decoration: BoxDecoration(
                                  color: ratio >= 1.0
                                      ? Colors.red
                                      : (ratio >= 0.8
                                            ? Colors.orange
                                            : Colors.teal),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
