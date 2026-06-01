import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int unreadCount = 2;

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Setoran Berhasil',
      'message': 'Rp 500.000 telah masuk ke Simpanan Sukarela Anda.',
      'time': '2 jam lalu',
      'category': 'Transaksi',
      'icon': Icons.shopping_bag,
      'unread': true,
      'bgColor': Color(0xFFFFDAD6),
    },
    {
      'title': 'Rapat Tahunan Anggota 2024',
      'message': 'Undangan RAT ke-15 untuk seluruh anggota koperasi.',
      'time': '5 jam lalu',
      'category': 'Pengumuman',
      'icon': Icons.campaign,
      'unread': true,
      'bgColor': Color(0xFFDFE0E0),
    },
    {
      'title': 'Tips Keuangan',
      'message': 'Cara cerdas mengelola SHU untuk modal usaha produktif.',
      'time': '1 hari lalu',
      'category': 'Informasi',
      'icon': Icons.info,
      'unread': false,
      'bgColor': Color(0xFFE2E2E2),
    },
    {
      'title': 'Penarikan Berhasil',
      'message': 'Penarikan dana Rp 200.000 telah diproses.',
      'time': '2 hari lalu',
      'category': 'Transaksi',
      'icon': Icons.shopping_bag,
      'unread': false,
      'bgColor': Color(0xFFE5E2E1),
    },
  ];

  void markAllAsRead() {
    setState(() {
      unreadCount = 0;
      for (var item in notifications) {
        item['unread'] = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Semua notifikasi telah ditandai sebagai dibaca'),
      ),
    );
  }

  void markRead(int index) {
    if (notifications[index]['unread']) {
      setState(() {
        notifications[index]['unread'] = false;
        unreadCount--;
      });
    }
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Transaksi':
        return const Color(0xFFD32F2F);
      case 'Pengumuman':
        return const Color(0xFF5D5F5F);
      case 'Informasi':
        return const Color(0xFF565858);
      default:
        return Colors.grey;
    }
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
            onPressed: markAllAsRead,
            icon: const Icon(
              Icons.done_all,
              color: primaryColor,
            ),
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

      body: ListView(
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
                '$unreadCount Notifikasi Baru',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...List.generate(
            notifications.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _notificationCard(
                index,
                notifications[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationCard(
    int index,
    Map<String, dynamic> item,
  ) {
    final bool unread = item['unread'];

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => markRead(index),
      child: Stack(
        children: [
          Opacity(
            opacity: unread ? 1 : 0.75,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: unread
                    ? Colors.white
                    : const Color(0xFFF6F3F2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE4BEBA),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: item['bgColor'],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'],
                      color: const Color(0xFF1B1C1C),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFEAE7E7,
                                ),
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                              child: Text(
                                item['category'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight.w600,
                                  color: getCategoryColor(
                                    item['category'],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              item['time'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF5B403D),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          item['message'],
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