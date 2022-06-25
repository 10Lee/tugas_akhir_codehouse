import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/global/constants.dart';
import 'package:tugas_akhir_stenly_rachmad/global/formatter.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/transaction/detail_transaction_controller.dart';

class DetailTransactionPage extends StatelessWidget {
  const DetailTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailTransactionController controller =
        Get.find<DetailTransactionController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
              "Trans Code: ${controller.detailTransCode.isNotEmpty ? controller.detailTransCode.value : 'Data telah dihapus dari server'}"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal : ${controller.detailTransDate.isNotEmpty ? controller.detailTransDate : 'Data telah dihapus dari server'}',
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Jumlah : ${controller.detailTransData.length} Transaksi",
                      style: const TextStyle(fontSize: 20.0),
                    )
                  ],
                ),
              ),
              Column(
                children: List<Widget>.generate(
                    controller.detailTransData.length, (index) {
                  final detail = controller.detailTransData[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: double.infinity,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                          child: Image.network(
                            '${kImageUrl}/${detail.photo}',
                            width: 180.0,
                            height: 110.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, _, __) {
                              return Image.network(
                                'https://www.sragenkab.go.id/assets/images/image-not-available-.jpg',
                                width: 180.0,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${detail.name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Rp. ${Formatter.format.format(detail.price! * detail.qty!)}",
                                ),
                                Text("${detail.qty} Pcs"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
