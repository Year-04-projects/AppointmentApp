// ignore_for_file: prefer_const_constructors

import 'package:appointment/screens/AdminScreens/updateschedulescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/schedule.service.dart';

class tableWidget extends StatefulWidget {
  final Function(String) getData;
  final List<QueryDocumentSnapshot> records;
  const tableWidget(this.records, {super.key, required this.getData});
  //  const tableWidget({super.key});

  @override
  State<tableWidget> createState() => _tableWidgetState();
}

class _tableWidgetState extends State<tableWidget> {
  void initState() {
    widget.records.forEach((doc) {
      print('Doctor Name: ${doc['venue']}');
    });
    print('recordis ${widget.records}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          PaginatedDataTable(
            header: Text('Schedules'),
            rowsPerPage: _DataSource(context, widget.records, widget.getData)
                        .rowCount >=
                    10
                ? 10
                : _DataSource(context, widget.records, widget.getData).rowCount,
            // ignore: prefer_const_literals_to_create_immutables
            columns: [
              DataColumn(label: Text('')),
              DataColumn(label: Text('Doctor Name')),
              DataColumn(label: Text('Venue')),
              DataColumn(label: Text('Arrival Time')),
              DataColumn(label: Text('Leaving Time')),
              DataColumn(label: Text('Appointments/Slot')),
              DataColumn(label: Text('')),
            ],
            source: _DataSource(context, widget.records, widget.getData),
          ),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.valuesid,
    this.valueF,
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
  );
  final String valuesid;
  final String valueF;
  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final int valueE;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context, records, this.getData) {
    _rows = records.map<_Row>((record) {
      print(record.data()); // print all fields and their values
      return _Row(
        record['sid'],
        'checkbox',
        record['docid'],
        record['venue'],
        record['arivaltime'],
        record['leavingtime'],
        record['patientcount'],
      );
    }).toList();
  }

  final BuildContext context;
  List<_Row> _rows = [];
  final Function(String) getData;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Checkbox(
          value: true,
          onChanged: (value) {},
        )),
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
        DataCell(Text(row.valueE.toString())),
        DataCell(Row(
          children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green),
                    color: Colors.green),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateScheduleScreen(
                                    scheduleId: row.valuesid,
                                  )));
                    },
                    icon: Icon(Icons.update),
                    color: Colors.white,
                  ),
                )),
            SizedBox(
              width: 10,
            ),
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red),
                    color: Colors.red),
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      // print('objectds ${row.valuesid}');

                      final res =
                          await ScheduleService().deleteSchedule(row.valuesid);
                      getData('ho');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(res),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.white,
                  ),
                ))
          ],
        )),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
