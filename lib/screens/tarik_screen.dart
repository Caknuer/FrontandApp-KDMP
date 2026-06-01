import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TarikPage extends StatefulWidget {
  const TarikPage({super.key});

  @override
  State<TarikPage> createState() => _TarikPageState();
}

class _TarikPageState extends State<TarikPage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String selectedSavings = 'Simpanan Sukarela';

  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  final Map<String, int> balances = {
    'Simpanan Pokok': 500000,
    'Simpanan Wajib': 1200000,
    'Simpanan Sukarela': 750000,
  };

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFAF101A);

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tarik Simpanan',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(
              Icons.account_balance,
              color: Color(0xFF5B403D),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward),
            label: const Text(
              'Tarik Dana',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSavingsDropdown(),
              const SizedBox(height: 16),

              _buildAmountInput(primaryColor),
              const SizedBox(height: 16),

              _buildNotesInput(),
              const SizedBox(height: 16),

              _buildAddBalanceButton(),
              const SizedBox(height: 20),

              _buildBalanceCard(primaryColor),
              const SizedBox(height: 20),

              _buildWithdrawMethod(primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavingsDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jenis Simpanan',
          style: TextStyle(
            color: Color(0xFF5B403D),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue
          : selectedSavings,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF6F3F2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          items: balances.entries.map((e) {
            return DropdownMenuItem(
              value: e.key,
              child: Text(
                '${e.key} (Rp ${e.value.toStringAsFixed(0)})',
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedSavings = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAmountInput(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nominal Penarikan',
          style: TextStyle(
            color: Color(0xFF5B403D),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          decoration: InputDecoration(
            hintText: 'Rp 0',
            filled: true,
            fillColor: const Color(0xFFFFDAD6).withAlpha(56),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyInputFormatter(),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Minimal penarikan Rp 10.000',
          style: TextStyle(
            color: Color(0xFF5B403D),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Keterangan (Opsional)',
          style: TextStyle(
            color: Color(0xFF5B403D),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Tujuan penarikan...',
            filled: true,
            fillColor: const Color(0xFFF6F3F2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddBalanceButton() {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color(0xFFE4BEBA),
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {},
      icon: const Icon(Icons.add_circle_outline),
      label: const Text('Tambah Saldo Lain'),
    );
  }

  Widget _buildBalanceCard(Color primaryColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.account_balance_wallet,
                  color: Color(0xFFAF101A),
                ),
                SizedBox(width: 8),
                Text(
                  'Rincian Saldo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            _balanceRow('Simpanan Pokok', 500000),
            _balanceRow('Simpanan Wajib', 1200000),
            _balanceRow(
              'Simpanan Sukarela',
              750000,
              valueColor: primaryColor,
            ),

            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Saldo Tersedia',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Rp 2.450.000',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _balanceRow(
    String title,
    int amount, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            'Rp ${amount.toStringAsFixed(0)}',
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawMethod(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Metode Penarikan',
          style: TextStyle(
            color: Color(0xFF5B403D),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F3F2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE4BEBA),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: primaryColor.withAlpha(26),
                child: Icon(
                  Icons.payments,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tunai (Kantor Koperasi)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Dana diambil langsung di kantor koperasi pada jam kerja.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) {
      return const TextEditingValue(text: '');
    }

    final number = int.parse(digits);
    final newText = formatter.format(number);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }
}