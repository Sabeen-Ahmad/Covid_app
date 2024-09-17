import 'package:covid_tracker/Model/worldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid_tracker/View/countries_list.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)..repeat();

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  StatesServices statesServices = StatesServices();

  final colorlist = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            FutureBuilder<WorldStatesModel>(

              future: statesServices.fetchWorldStatesRecords(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Loading state, show loading spinner
                  return Expanded(
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: controller,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Handle errors
                  return Expanded(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'), // Display the error message
                    ),
                  );
                } else if (snapshot.hasData) {
                  // When data is available, show your chart and stats
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          'Total': double.parse(snapshot.data!.cases.toString()),
                          'Recovered': double.parse(snapshot.data!.recovered.toString()),
                          'Deaths': double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: true,
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        animationDuration: const Duration(microseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorlist,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * .06,
                        ),
                        child: Card(
                          child: Column(
                            children: [
                              ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                              ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                              ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReuseableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                              ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CountriesList()));
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Track Countries',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No data available.'));
                }
              },
            )

          ],
        ),
      ),
      ),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title,value;
   ReuseableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10,right: 10,top: 10,bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
