import 'package:flutter/material.dart';
import 'editprofil_screen.dart';
import 'dart:io';

class DetailProfilScreen extends StatelessWidget {
  final File? profileImage;
  const DetailProfilScreen({super.key, this.profileImage});

  static const Color primaryColor = Color(0xFFAF101A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'Detail Profil',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // FOTO PROFIL
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                children: [
                  Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
                          child: profileImage == null
                              ? Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.grey.shade600,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xffAF101A),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 14),

                  const Text(
                    'Budi Santoso',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'ID: KOP-2024-0891',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            _buildMembershipCard(),

            const SizedBox(height: 12),

            _buildPersonalCard(),

            const SizedBox(height: 12),

            _buildAddressCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: const Color(0xffE4BEBA),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),

      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                Icons.stars_outlined,
                color: primaryColor,
                size: 18,
              ),

              SizedBox(width: 6),

              Text(
                'Informasi Keanggotaan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          Divider(
            height: 18,
            color: Color(0xffE4BEBA),
          ),

          Text(
            'Tipe Anggota',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 2),

          Text(
            'Anggota Biasa',
            style: TextStyle(fontSize: 13),
          ),

          SizedBox(height: 10),

          Text(
            'Tanggal Bergabung',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 2),

          Text(
            '12 Jan 2023',
            style: TextStyle(fontSize: 13),
          ),

          SizedBox(height: 10),

          Text(
            'Status',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),

          SizedBox(height: 6),

          Chip(
            backgroundColor: Color(0xffDDF5DD),
            visualDensity: VisualDensity.compact,

            label: Text(
              'AKTIF',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: const Color(0xffE4BEBA),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 4,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Row(
            children: [
              Icon(
                Icons.person_outline,
                color: primaryColor,
                size: 18,
              ),

              SizedBox(width: 6),

              Text(
                'Data Pribadi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const Divider(
            height: 18,
            color: Color(0xffE4BEBA),
          ),

          _infoItem(
            Icons.badge_outlined,
            'NIK',
            '3471021201850001',
          ),

          _infoItem(
            Icons.person_outline,
            'Nama Lengkap',
            'Budi Santoso',
          ),

          _infoItem(
            Icons.cake_outlined,
            'Tempat, Tanggal Lahir',
            'Sleman, 12 Januari 1983',
          ),

          _infoItem(
            Icons.call_outlined,
            'Nomor Telepon',
            '+62 812-3456-7890',
          ),

          _infoItem(
            Icons.email_outlined,
            'Email',
            'budi.santoso@email.com',
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: const Color(0xffE4BEBA),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 4,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: primaryColor,
                size: 18,
              ),

              SizedBox(width: 6),

              Text(
                'Alamat Domisili',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const Divider(
            height: 18,
            color: Color(0xffE4BEBA),
          ),

          _infoItem(
            Icons.home_outlined,
            'Alamat Lengkap',
            'Jl. Mawar Indah No. 45, RT 003 / RW 002, Kel. Sido Muncul, Kec. Gajah Mada, Sleman, Yogyakarta 55581',
          ),
        ],
      ),
    );
  }

  Widget _infoItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.black54,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}