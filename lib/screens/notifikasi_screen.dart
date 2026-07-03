import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import 'news/show_screen.dart';
// import 'pengumuman/show_screen.dart';
// import 'simpanan/simpanan_screen.dart';
// import 'tarik/tarik_screen.dart';
import 'page-profil/profile_screen.dart';
import 'detailtransaksi_screen.dart';
import '../services/transaction_service.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int unreadCount = 0;
  List<dynamic> notifications = [];
  bool isLoading = true;

  Future<void> loadNotifications() async {
    setState(() {
      isLoading = true;
    });

    notifications = await NotificationService.getNotifications();

    unreadCount = notifications.where((item) {
      return item["is_read"] == false;
    }).length;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> markAllAsRead() async {
    final success = await NotificationService.markAllAsRead();

    if (!success) return;

    await loadNotifications();
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Semua notifikasi telah dibaca")),
    );
  }

  Future<void> markRead(int index) async {
    if (notifications[index]["is_read"] == true) {
      return;
    }
    final success = await NotificationService.markAsRead(
      notifications[index]["id"],
    );

    if (!success) return;
    await loadNotifications();
  }

  Color getCategoryColor(String category) {
    switch(category){
      case "Transaksi":
        return const Color(0xFFD32F2F);
      case "Pengumuman":
        return const Color(0xFF5D5F5F);
      case "Informasi":
        return const Color(0xFF565858);
      case "Berita":
        return Colors.blue;
      case "Tagihan":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Future<void> openNotification(Map<String, dynamic> item) async{
    final type = item["type"];

    switch (type) {
      
      case "news":
        if (item["reference_id"] == null) {
          return;
        }
        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (_) => DetailBeritaScreen(id: item["reference_id"]),
          ),
        );

        break;

      case "announcement":
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Fitur sedang dikembangkan",
            ),
          ),
        );

        break;

      case "setoran":
        if (item["reference_id"] == null) return;
        final transaksi =
            await TransactionService.getSetoranById(
          item["reference_id"].toString(),
        );

        if (transaksi == null) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Detail transaksi tidak ditemukan",
              ),
            ),
          );
          return;
        }

        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailTransaksiScreen(
              transaction: transaksi,
            ),
          ),
        );

        break;

      case "penarikan":
        if (item["reference_id"] == null) return;
        final transaksi =
            await TransactionService.getPenarikanById(
          item["reference_id"].toString(),
        );
        if (transaksi == null) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Detail transaksi tidak ditemukan",
              ),
            ),
          );
          return;
        }

        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailTransaksiScreen(
              transaction: transaksi,
            ),
          ),
        );

        break;

      case "tagihan":
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Detail tagihan sedang dikembangkan",
            ),
          ),
        );

        break;

      case "anggota":
        Navigator.push(
          context,

          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );

        break;

        default:

        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(
            content: Text(
              "Halaman notifikasi belum tersedia",
            ),
          ),
        );
        break;
    }
  }

  IconData getNotificationIcon(String category) {
    switch (category) {
      case "Transaksi":
        return Icons.account_balance_wallet;
      case "Pengumuman":
        return Icons.campaign;
      case "Informasi":
        return Icons.info_outline;
      case "Tagihan":
        return Icons.receipt_long;
      case "Berita":
        return Icons.article;
      default:
        return Icons.notifications;
    }
  }

  Color getBackgroundColor(String category) {
    switch (category) {
      case "Transaksi":
        return const Color(0xFFFFDAD6);
      case "Pengumuman":
        return const Color(0xFFE8EAF6);
      case "Informasi":
        return const Color(0xFFE3F2FD);
      case "Tagihan":
        return const Color(0xFFFFF3E0);
      case "Berita":
        return const Color(0xFFE8F5E9);
      default:
        return Colors.grey.shade200;
    }
  }

  String formatTimeAgo(String createdAt) {
    final date = DateTime.parse(createdAt);
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) {
      return "Baru saja";
    }

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} menit lalu";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours} jam lalu";
    }

    if (diff.inDays == 1) {
      return "Kemarin";
    }

    return "${diff.inDays} hari lalu";
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFAF101A);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F3F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Color(0xFF1B1C1C),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed:
            unreadCount == 0
            ? null
            : () async {
                await markAllAsRead();
              },
            icon: const Icon(Icons.done_all, color: primaryColor),
            label: const Text(
              'Tandai Dibaca',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),

      body:
        isLoading
        ? const Center(
            child: CircularProgressIndicator(),
        )
        : notifications.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 70,
                  color: Colors.grey.shade400,
                ),

                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Belum ada notifikasi",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Text(
                  "Semua informasi terbaru akan muncul di sini.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
        )

        : RefreshIndicator(
        onRefresh: loadNotifications,
        child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TERBARU',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF5B403D),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
              Text(
                unreadCount == 0
                ? "Tidak ada notifikasi baru"
                : "$unreadCount Notifikasi Baru",
                style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          ...List.generate(
            notifications.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _notificationCard(index, notifications[index]),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _notificationCard(int index, Map<String, dynamic> item) {
    final bool unread = item["is_read"] == false;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        await markRead(index);
        openNotification(item);
      },
      child: Stack(
        children: [
          Opacity(
            opacity: unread ? 1 : 0.75,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: unread ? Colors.white : const Color(0xFFF6F3F2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE4BEBA)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: getBackgroundColor(item["category"] ?? ""),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      getNotificationIcon(item["category"] ?? ""),
                      color: const Color(0xFF1B1C1C),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAE7E7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                item["category"] ?? "-",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: getCategoryColor(item['category']),
                                ),
                              ),
                            ),
                            Text(
                              formatTimeAgo(item["created_at"]),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5B403D),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Text(
                          item["title"] ?? "-",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          item["message"] ?? "-",
                          style: const TextStyle(
                            color: Color(0xFF616363),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (unread)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFBA1A1A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
