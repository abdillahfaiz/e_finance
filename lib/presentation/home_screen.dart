import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/data/account_data.dart';
import 'package:wallet_app/data/finance_data.dart';
import 'package:wallet_app/model/finance_model.dart';
import 'package:wallet_app/theme/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  final amountTextController = TextEditingController();

  String statusUpdate = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    var sisaSaldoIDR = FormatCurrency.convertToIdr(sisaSaldo, 0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(right: 26, left: 26, top: 60),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          'Hello ${accData.name},',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryColor1,
                          ),
                        ),
                      ),
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryColor3),
                      )
                    ],
                  ),
                  Image.asset(
                    'assets/images/notification.png',
                    height: 44,
                    width: 44,
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              _Card(
                sisaSaldo: sisaSaldoIDR,
                addOnTap: () {
                  _modalBottomSheetCustom(context, createDataPemasukan,
                      tittle: 'Pemasukan', buttonText: 'Simpan');
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Actions',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        _modalBottomSheetCustom(context, createDataPemasukan,
                            tittle: 'Pemasukan', buttonText: 'Simpan');
                      },
                      child: const _ActionWidgetPemasukan()),
                  InkWell(
                      onTap: () {
                        _modalBottomSheetCustom(context, createDataPenarikan,
                            tittle: 'Penarikan', buttonText: 'Tarik');
                      },
                      child: const _ActionWidgetPenarikan()),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'History',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10.0,
              ),
              financeData.isEmpty
                  ? const Align(
                      alignment: Alignment.center,
                      child: Text('Belum ada data'))
                  : ListView.separated(
                      padding: const EdgeInsets.only(top: 0),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: financeData.length,
                      itemBuilder: (context, index) {
                        var data = financeData[index];
                        var amount =
                            FormatCurrency.convertToIdr(data.amount, 0);

                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.status == 'pemasukan'
                                                ? 'Pemasukan'
                                                : 'Penarikan',
                                            style: const TextStyle(
                                                color: AppColor.primaryColor2),
                                          ),
                                          Text(
                                            data.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: const TextStyle(
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          const Text(
                                            'Deskripsi :',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(data.description),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(amount),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                                onPressed: () {
                                                  deleteData(index);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Hapus',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Kembali',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 61,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            decoration: const BoxDecoration(
                              color: Color(0xffD9D9D9),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/${data.logo}',
                                      height: 25,
                                      width: 25,
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            data.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.primaryColor3),
                                          ),
                                        ),
                                        Text(
                                          amount,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: data.status == 'pemasukan'
                                                ? const Color(0xff019F07)
                                                : const Color(0xffDA444F),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    titleTextController.text = data.title;
                                    descriptionTextController.text =
                                        data.description;
                                    amountTextController.text =
                                        data.amount.toString();
                                    statusUpdate = data.status;

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text('Edit Data'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  TextField(
                                                    controller:
                                                        titleTextController,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Title',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        descriptionTextController,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Description',
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  TextField(
                                                    maxLength: 15,
                                                    controller:
                                                        amountTextController,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: 'Amount',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColor.primaryColor2,
                                                  ),
                                                  onPressed: () {
                                                    var data = FinanceModel(
                                                      title: titleTextController
                                                          .text,
                                                      description:
                                                          descriptionTextController
                                                              .text,
                                                      amount: int.parse(
                                                          amountTextController
                                                              .text),
                                                      logo: statusUpdate ==
                                                              'pemasukan'
                                                          ? 'pemasukan_icon.png'
                                                          : 'pengeluaran_icon.png',
                                                      status: statusUpdate ==
                                                              'pemasukan'
                                                          ? 'pemasukan'
                                                          : 'penarikan',
                                                    );

                                                    updateData(data, index,
                                                        statusUpdate);
                                                    titleTextController.clear();
                                                    descriptionTextController
                                                        .clear();
                                                    amountTextController
                                                        .clear();
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Update Data',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                ),
                                // IconButton(
                                //   onPressed: () {
                                //     deleteData(index);
                                //   },
                                //   icon: const Icon(
                                //     Icons.delete,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      }),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _modalBottomSheetCustom(
      BuildContext context, Function(FinanceModel)? onPressed,
      {String tittle = '', String buttonText = ''}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                right: 16,
                left: 16,
                top: 25,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tittle,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: titleTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: descriptionTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: amountTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Jumlah',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          backgroundColor: titleTextController.text.isEmpty ||
                                  descriptionTextController.text.isEmpty ||
                                  amountTextController.text.isEmpty
                              ? AppColor.secondaryColor2
                              : AppColor.primaryColor2,
                        ),
                        onPressed: () {
                          if (titleTextController.text.isEmpty ||
                              descriptionTextController.text.isEmpty ||
                              amountTextController.text.isEmpty) {
                            return;
                          } else {
                            var data = FinanceModel(
                                title: titleTextController.text,
                                description: descriptionTextController.text,
                                amount: int.parse(amountTextController.text),
                                logo: '',
                                status: '');

                            onPressed!(data);
                            titleTextController.clear();
                            descriptionTextController.clear();
                            amountTextController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    titleTextController.dispose();
    descriptionTextController.dispose();
    amountTextController.dispose();
    super.dispose();
  }

  void createDataPenarikan(FinanceModel data) {
    setState(() {
      data.logo = 'pengeluaran_icon.png';
      data.status = 'penarikan';
      financeData.add(data);
      sisaSaldo = sisaSaldo - data.amount;
    });
  }

  void createDataPemasukan(FinanceModel data) {
    setState(() {
      data.logo = 'pemasukan_icon.png';
      data.status = 'pemasukan';
      financeData.add(data);
      sisaSaldo = sisaSaldo + data.amount;
    });

    titleTextController.clear();
    descriptionTextController.clear();
    amountTextController.clear();
  }

  void updateData(FinanceModel data, int index, String status) {
    setState(() {
      sisaSaldo = status == 'pemasukan'
          ? sisaSaldo - financeData[index].amount
          : sisaSaldo + financeData[index].amount;
      financeData[index] = data;
      status == 'pemasukan'
          ? sisaSaldo = sisaSaldo + financeData[index].amount
          : sisaSaldo = sisaSaldo - financeData[index].amount;
    });
  }

  void deleteData(int index) {
    setState(() {
      sisaSaldo = sisaSaldo - financeData[index].amount;
      financeData.removeAt(index);
    });
  }
}

class FormatCurrency {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

class _ActionWidgetPenarikan extends StatelessWidget {
  const _ActionWidgetPenarikan();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 138,
      child: Stack(children: [
        Positioned(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/penarikan_bg.png',
              width: 130,
            ),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/penarikan.png',
              width: 107,
            )),
        const Positioned.fill(
          left: 10,
          bottom: 30,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Penarikan',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _ActionWidgetPemasukan extends StatelessWidget {
  const _ActionWidgetPemasukan();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: 138,
      child: Stack(children: [
        Positioned(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/pemasukan_bg.png',
              width: 130,
            ),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/pemasukan.png',
              width: 107,
            )),
        const Positioned.fill(
          left: 10,
          bottom: 30,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Pemasukan',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.sisaSaldo,
    required this.addOnTap,
  });

  final String sisaSaldo;
  final Function()? addOnTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 194,
      child: Stack(children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/bg_card.png',
              height: 168,
            ),
          ),
        ),
        Positioned(
            right: 0,
            child: Image.asset(
              'assets/images/coin.png',
              width: 127,
            )),
        Positioned(
            bottom: -6,
            left: 30,
            child: InkWell(
              onTap: addOnTap,
              child: Image.asset(
                'assets/images/add_button.png',
                height: 70,
              ),
            )),
        Positioned.fill(
          left: 27,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              sisaSaldo,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: sisaSaldo.characters.length > 9 ? 28 : 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        const Positioned.fill(
          left: 27,
          top: 60,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Saldo Anda',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: AppColor.primaryColor1),
            ),
          ),
        ),
      ]),
    );
  }
}
