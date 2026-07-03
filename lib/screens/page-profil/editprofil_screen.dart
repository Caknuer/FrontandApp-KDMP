import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../services/profile_service.dart';
import '../../services/upload_service.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? profile;
  final File? profileImage;
  const EditProfileScreen({super.key, this.profile, this.profileImage});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController tempatLahirController;
  late TextEditingController tanggalLahirController;
  late TextEditingController addressController;
  late TextEditingController pekerjaanController;

  bool isSaving = false;
  bool saved = false;
  String? jenisKelamin;

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isSaving = true;
      saved = false;
    });

    final success =
        await ProfileService.updateProfile(
      nama: nameController.text,
      noHp: phoneController.text,
      alamat: addressController.text,
      tempatLahir: tempatLahirController.text,
      tanggalLahir: tanggalLahirController.text,
      jenisKelamin: jenisKelamin ?? "",
      pekerjaan: pekerjaanController.text.trim(),
      fotoProfileUrl: fotoProfileUrl,
    );

    if (!mounted) return;
    setState(() {
      isSaving = false;
      saved = success;
    });

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Profil berhasil diperbarui",
          ),
        ),
      );

      Navigator.pop(
        context,
        true,
      );

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Gagal memperbarui profil",
          ),
        ),
      );
    }
  }

  File? profileImage;
  String? fotoProfileUrl;
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    profileImage = widget.profileImage;
    fotoProfileUrl = widget.profile?["foto_profile_url"];
    nameController = TextEditingController(text: widget.profile?["nama"] ?? "");
    phoneController = TextEditingController(
      text: widget.profile?["no_hp"] ?? "",
    );
    emailController = TextEditingController(
      text: widget.profile?["email"] ?? "",
    );
    tempatLahirController = TextEditingController(
      text: widget.profile?["tempat_lahir"] ?? "",
    );
    tanggalLahirController = TextEditingController(
      text: widget.profile?["tanggal_lahir"]?.toString().substring(0, 10) ?? "",
    );
    addressController = TextEditingController(
      text: widget.profile?["alamat"] ?? "",
    );
    pekerjaanController = TextEditingController(
      text: widget.profile?["pekerjaan"] ?? "",
    );
    jenisKelamin = widget.profile?["jenis_kelamin"];
  }

  Future<void> pickProfileImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      final file =
          File(image.path);
      setState(() {
        profileImage = file;
      });

      final url =
          await UploadService.uploadImage(
        file,
      );

      if (url != null) {
        fotoProfileUrl = url;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    tempatLahirController.dispose();
    tanggalLahirController.dispose();
    addressController.dispose();
    pekerjaanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFAF101A);
    const backgroundColor = Color(0xFFFCF9F8);

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black87,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profil",
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Profile Photo
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(20),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: profileImage != null
                              ? Image.file(profileImage!, fit: BoxFit.cover)
                              : widget.profile?["foto_profile_url"] != null &&
                                    widget.profile!["foto_profile_url"]
                                        .toString()
                                        .isNotEmpty
                              ? Image.network(
                                  widget.profile!["foto_profile_url"],
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.person,
                                  size: 70,
                                  color: Colors.grey.shade500,
                                ),
                        ),
                      ),

                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: pickProfileImage,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "ID Anggota: ${widget.profile?["id"]?.toString().substring(0, 8) ?? "-"}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              TextButton.icon(
                onPressed: pickProfileImage,
                icon: const Icon(Icons.photo_library, size: 18),
                label: const Text("Ubah Foto Profil"),
              ),

              const SizedBox(height: 20),

              _buildField(
                label: "Nama Lengkap",
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama wajib diisi";
                    }
                    if (value.length < 3) {
                      return "Nama terlalu pendek";
                    }

                    return null;
                  },
                  decoration: _inputDecoration("Masukkan nama lengkap"),
                ),
              ),

              const SizedBox(height: 20),

              _buildField(
                label: "NIK (Terverifikasi)",
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F3F2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextFormField(
                    initialValue: widget.profile?["nik"] ?? "-",
                    readOnly: true,
                    decoration: _inputDecoration("").copyWith(
                      prefixIcon: const Icon(
                        Icons.badge_outlined,
                        color: Color(0xFFAF101A),
                      ),
                      suffixIcon: const Icon(
                        Icons.verified,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _buildField(
                label: "Nomor WhatsApp",
                child: TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nomor HP wajib diisi";
                    }
                    if (value.length < 10) {
                      return "Nomor HP tidak valid";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: _inputDecoration(
                    "81234567890",
                  ).copyWith(prefixText: "+62 "),
                ),
              ),

              const SizedBox(height: 20),

              _buildField(
                label: "Jenis Kelamin",
                child: DropdownMenu<String>(
                  width: MediaQuery.of(context).size.width - 32,
                  initialSelection: jenisKelamin ?? "Laki-laki",
                  hintText: "Pilih Jenis Kelamin",
                  leadingIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFFAF101A),
                  ),
                  menuStyle: MenuStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: const Color(0xFFF6F3F2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFAF101A),
                        width: 2,
                      ),
                    ),
                  ),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(
                      value: "Laki-laki",
                      label: "Laki-laki",
                      leadingIcon: Icon(Icons.male),
                    ),
                    DropdownMenuEntry(
                      value: "Perempuan",
                      label: "Perempuan",
                      leadingIcon: Icon(Icons.female),
                    ),
                  ],
                  onSelected: (value) {
                    setState(() {
                      jenisKelamin = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      label: "Tempat Lahir",
                      child: TextFormField(
                        controller: tempatLahirController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tempat lahir wajib diisi';
                          }
                          return null;
                        },
                        decoration: _inputDecoration("Contoh: Klaten").copyWith(
                          prefixIcon: const Icon(
                            Icons.location_city,
                            color: Color(0xFFAF101A),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _buildField(
                      label: "Tanggal Lahir",
                      child: TextFormField(
                        controller: tanggalLahirController,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal lahir wajib diisi';
                          }
                          return null;
                        },
                        decoration: _inputDecoration("Pilih Tanggal").copyWith(
                          prefixIcon: const Icon(
                            Icons.calendar_month,
                            color: Color(0xFFAF101A),
                          ),
                        ),
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            tanggalLahirController.text =
                                "${pickedDate.year}-"
                                "${pickedDate.month.toString().padLeft(2, '0')}-"
                                "${pickedDate.day.toString().padLeft(2, '0')}";
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildField(
                label: "Pekerjaan",
                child: TextFormField(
                  controller: pekerjaanController,
                  decoration: _inputDecoration(
                    "Masukkan pekerjaan",
                  ).copyWith(
                    prefixIcon: const Icon(
                      Icons.work_outline,
                      color: Color(0xFFAF101A),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _buildField(
                label: "Email",
                child: TextFormField(
                  controller: emailController,

                  readOnly: true,

                  decoration: _inputDecoration("").copyWith(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xFFAF101A),
                    ),

                    suffixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Todo:
              // Ganti TextFormField menjadi:
              // Provinsi
              // Kabupaten/Kota
              // Kecamatan
              // Kelurahan/Desa
              // Detail Alamat
              _buildField(
                label: "Alamat Domisili",
                child: TextFormField(
                  controller: addressController,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat wajib diisi';
                    }
                    return null;
                  },
                  decoration: _inputDecoration("Masukkan alamat"),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isSaving
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            saveProfile();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: saved ? Colors.green : primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isSaving
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text("Menyimpan..."),
                          ],
                        )
                      : saved
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle),
                            SizedBox(width: 8),
                            Text("Berhasil Disimpan"),
                          ],
                        )
                      : const Text("Simpan Perubahan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF6F3F2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFAF101A)),
      ),
    );
  }
}
