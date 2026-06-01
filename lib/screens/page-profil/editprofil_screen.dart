import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(
    text: "Budi Santoso",
  );

  final phoneController = TextEditingController(
    text: "81234567890",
  );

  final emailController = TextEditingController(
    text: "budi.santoso@email.com",
  );

  final tempatLahirController = TextEditingController(
    text: "Pasuruan",
  );

  final tanggalLahirController = TextEditingController(
    text: "15 Agustus 1998",
  );

  final addressController = TextEditingController(
    text:
        "Jl. Desa Makmur No. 12, RT 04 RW 02, Kec. Sukamaju, Kabupaten Klaten, Jawa Tengah",
  );

  bool isSaving = false;
  bool saved = false;
  String? jenisKelamin;

  Future<void> saveProfile() async {
    setState(() {
      isSaving = true;
      saved = false;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      isSaving = false;
      saved = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pop(context,true);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    tempatLahirController.dispose();
    tanggalLahirController.dispose();
    addressController.dispose();
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
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Profile Photo
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 4,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuA0FXiVcG3TR5YwDIR_g4eKz-PZBzzPID8hsgjjZFcfrPgX__LyLF7yrYFOc5RxIZUHYUDfMr5CBQEfp_68UvIqMq1VLS0w1j1H3StGQHKCzJ7Pw50KzGFpnsxQto8iB05lkYAjPviHPd-HBZozyiBlFn7FNLE_3KRbJyLClWwCdhZNkQ9eyLYL3nf9Bz2Dz8EU2SlwxzioNcL71D49F8nPzJBPZO2XsAy2r3chNYnRyBnP9gvnCcnGqC8lx8759nCygDIHhA4N2jIO",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: primaryColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Text(
                  "ID Anggota: KOP-2023-0881",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            _buildField(
              label: "Nama Lengkap",
              child: TextFormField(
              controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
                decoration: _inputDecoration(
                  "Masukkan nama lengkap",
                ),
              )
            ),

            const SizedBox(height: 20),

            _buildField(
              label: "Nomor WhatsApp",
              child: TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP wajib diisi';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration(
                  "81234567890",
                ).copyWith(
                  prefixText: "+62 ",
                ),
              ),
            ),

            _buildField(
              label: "Jenis Kelamin",
              child: DropdownMenu<String>(
                width: MediaQuery.of(context).size.width - 32,
                initialSelection: jenisKelamin,
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
                      decoration: _inputDecoration(
                        "Contoh: Klaten",
                      ).copyWith(
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
                      decoration: _inputDecoration(
                        "Pilih Tanggal",
                      ).copyWith(
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
                              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _buildField(
              label: "Email",
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }

                  if (!value.contains('@')) {
                    return 'Format email tidak valid';
                  }

                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  "Masukkan email",
                ),
              ),
            ),

            const SizedBox(height: 20),

            _buildField(
              label: "Alamat Domisili",
              child: TextFormField(
                controller: addressController,
                maxLines: 4,
                decoration: _inputDecoration(
                  "Masukkan alamat",
                ),
              ),
            ),

            const SizedBox(height: 20),

            _buildField(
              label: "NIK (Terverifikasi)",
              child: TextFormField(
                initialValue: "3300112233440001",
                readOnly: true,
                decoration: _inputDecoration("").copyWith(
                  suffixIcon: const Icon(
                    Icons.verified,
                    color: primaryColor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isSaving? null: () {
                    if (_formKey.currentState!.validate()) {
                      saveProfile();
                    }
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      saved ? Colors.green : primaryColor,
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
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle),
                              SizedBox(width: 8),
                              Text("Berhasil Disimpan"),
                            ],
                          )
                        : const Text(
                            "Simpan Perubahan",
                          ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required Widget child,
  }) {
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
        borderSide: const BorderSide(
          color: Color(0xFFAF101A),
        ),
      ),
    );
  }
}