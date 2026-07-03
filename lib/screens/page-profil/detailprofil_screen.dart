import 'package:flutter/material.dart';
import 'editprofil_screen.dart';
import 'dart:io';

class DetailProfilScreen extends StatelessWidget {

  final File? profileImage;

  final Map<String, dynamic>? profile;

  const DetailProfilScreen({
    super.key,
    this.profileImage,
    this.profile,
  });

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
            onPressed: () async {
              final result =
                  await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditProfileScreen(
                    profile: profile,
                    profileImage:
                        profileImage,
                  ),
                ),
              );

              if (result == true) {
                if (!context.mounted) return;
                Navigator.pop(
                  context,
                  true,
                );

              }

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
                          backgroundImage:
                          profileImage != null
                              ? FileImage(profileImage!)
                              : profile?["foto_profile_url"] != null &&
                                      profile!["foto_profile_url"] != ""
                                  ? NetworkImage(
                                      profile!["foto_profile_url"],
                                    )
                                  : null,
                          child:
                            profileImage == null &&
                                    (profile?["foto_profile_url"] == null ||
                                        profile!["foto_profile_url"] == "")
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

                  Text(
                    profile?["nama"] ?? "-",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "ID: ${profile?["id"]?.toString().substring(0, 8) ?? "-"}",
                    style: const TextStyle(
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

      child: Column(
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
            profile?["tipe_keanggotaan"] ?? "-",
            style: const TextStyle(
              fontSize: 13,
            ),
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
            profile?["created_at"] != null
                ? profile!["created_at"]
                    .toString()
                    .substring(0, 10)
                : "-",
            style: const TextStyle(
              fontSize: 13,
            ),
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
            visualDensity: VisualDensity.compact,

            backgroundColor:
                profile?["status"] == "approved"
                    ? const Color(0xffDDF5D0)
                    : profile?["status"] == "pending"
                        ? const Color(0xffFFF3CD)
                        : const Color(0xffFFDAD6),

            label: Text(

              profile?["status"] == "approved"
                  ? "ANGGOTA AKTIF"
                  : profile?["status"] == "pending"
                      ? "MENUNGGU PERSETUJUAN"
                      : "TIDAK AKTIF",

              style: TextStyle(
                color:
                    profile?["status"] == "approved"
                        ? Colors.green.shade800
                        : profile?["status"] == "pending"
                            ? Colors.orange.shade800
                            : Colors.red.shade800,
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
            profile?["nik"] ?? "-",
          ),

          _infoItem(
            Icons.person_outline,
            'Nama Lengkap',
            profile?["nama"] ?? "-",
          ),

          _infoItem(
            Icons.cake_outlined,
            'Tempat, Tanggal Lahir',
            "${profile?["tempat_lahir"] ?? "-"}, ${profile?["tanggal_lahir"]?.toString().substring(0, 10) ?? "-"}",
          ),

          _infoItem(
            Icons.call_outlined,
            'Nomor Telepon',
            profile?["no_hp"] ?? "-",
          ),

          _infoItem(
            Icons.email_outlined,
            'Email',
            profile?["email"] ?? "-",
          ),

          _infoItem(
            Icons.wc_outlined,
            'Jenis Kelamin',
            profile?["jenis_kelamin"] ?? "-",
          ),

          _infoItem(
            Icons.work_outline,
            'Pekerjaan',
            profile?["pekerjaan"] ?? "-",
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
            profile?["alamat"] ?? "-",
          ),

          _infoItem(
            Icons.account_circle_outlined,
            'Username',
            profile?["username"] ?? "-",
          ),

          _infoItem(
            Icons.admin_panel_settings_outlined,
            'Role',
            profile?["role"] ?? "-",
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