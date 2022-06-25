import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_stenly_rachmad/app_routes.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';
import 'package:tugas_akhir_stenly_rachmad/global/constants.dart';
import 'package:tugas_akhir_stenly_rachmad/models/get_api/transaction_model.dart';
import 'package:tugas_akhir_stenly_rachmad/pages/stats/stats_controller.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/profile_gauge.dart';
import 'package:tugas_akhir_stenly_rachmad/widgets/profile_stat_display.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatsController controller = Get.find<StatsController>();

    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: ((notification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              // logger.i("MENTOK");
              controller.page++;
              controller.getAllTransactionData();
            }
            return true;
          }),
          child: Obx(
            () => ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: Dimensions.height70),
              itemCount: controller.isNoMoreLoad.value
                  ? controller.transactionList.length
                  : controller.transactionList.length + 1,
              itemBuilder: (context, index) {
                // var datas = controller.transactionList
                //   ..sort((a, b) => b.date!.compareTo(a.date!))
                //   ..toList();

                if (index == 0) {
                  return _buildStats(context, controller);
                } else {
                  if (index - 2 < controller.transactionList.length) {
                    // var transactionData = controller.transactionList.sort(
                    //     (item1, item2) => item2.date!.compareTo(item1.date!));
                    // final transactionSorted = transactionData[index - 1];

                    final transaction = controller.transactionList[index - 1];

                    // final data = datas[index - 1];

                    return _buildTransactionList(transaction);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionList(Results transactionSorted) {
    return InkWell(
      onTap: () => Get.toNamed(
        AppRoutes.detailTransactionRoute,
        arguments: {
          'id': transactionSorted.id,
        },
      ),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.width40,
          vertical: Dimensions.height10,
        ),
        child: Row(
          children: [
            Text(
              "${transactionSorted.date} ",
              style: TextStyle(
                  fontSize: Dimensions.font15, fontWeight: FontWeight.bold),
            ),
            Text(
              ' • TransCode : ${transactionSorted.transCode} •',
              style:
                  TextStyle(fontSize: Dimensions.font15, color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context, StatsController controller) {
    return Column(
      children: [
        // Total spending & total transaksi
        Container(
          // Container untuk Box Total Spending dan Transaksi
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20, vertical: Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  controller.clearBoxSpending();
                },
                child: ProfileStatDisplay(
                  title: "Total Spending",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 18.0),
                        child: Text("Rp. "),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Countup(
                            begin: 0.0,
                            // end: controller.totalSpending.value.toDouble(),
                            end: 7,
                            duration: const Duration(milliseconds: 1000),
                            style: TextStyle(
                                fontSize: Dimensions.font40,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Dimensions.height20),
                            child: Text(
                              "Juta",
                              style: TextStyle(fontSize: Dimensions.font20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => ProfileStatDisplay(
                    title: 'Total Transaksi',
                    child: Countup(
                      begin: 0,
                      end: controller.isLoading.value
                          ? 0
                          : controller.totalTransaction.value.toDouble(),
                      duration: const Duration(milliseconds: 700),
                      style: TextStyle(
                          fontSize: Dimensions.font40,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ),
        ////////////////////////////////
        SizedBox(height: Dimensions.height20),
        // Container untuk Gauge
        Container(
          height: Dimensions.height200,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            children: const [
              ProfileGauge(
                title: "Poin Terkumpul",
                // currentValue: controller.totalPoin.value.toDouble(),
                currentValue: 77,
              ),
              ProfileGauge(title: "Quest", currentValue: 77),
            ],
          ),
        ),
        /////////////////////////////////////
        SizedBox(height: Dimensions.height20),
        // AGENDA TRANSAKSI
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: Row(
            children: [
              Text(
                "Agenda Transaksi",
                style: TextStyle(
                  fontSize: Dimensions.font24,
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: Dimensions.width20),
              Container(
                width: getMediaQuery(context, MediaQueryTypes.width) / 3,
                height: .5,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.height20),
      ],
    );
  }
}
