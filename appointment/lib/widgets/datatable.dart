// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class tableWidget extends StatefulWidget {
  const tableWidget({super.key});

  @override
  State<tableWidget> createState() => _tableWidgetState();
}

class _tableWidgetState extends State<tableWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          PaginatedDataTable(
            header: Text('Schedules'),
            rowsPerPage: _DataSource(context).rowCount >=10? 10:_DataSource(context).rowCount,
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
            source: _DataSource(context),
          ),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueF,
    this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
  );
  final String valueF;
  final String valueA;
  final String valueB;
  final String valueC;
  final int valueD;
  final int valueE;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row(
        'Cell A1',
        'Cell A1',
        'CellB1',
        'CellC1',
        1,
        10
      ),
      _Row(
        'Cell A1',
        'Cell A2',
        'CellB2',
        'CellC2',
        2,
        10
      ),
      _Row(
        'Cell A1',
        'Cell A3',
        'CellB3',
        'CellC3',
        3,
        10
      ),
      _Row(
        'Cell A1',
        'Cell A4',
        'CellB4',
        'CellC4',
        4,
        10
      ),
      _Row(
        'Cell A1',
        'Cell A5',
        'CellB5',
        'CellC5',
        5,
        10
      ),
        _Row(
        'Cell A1',
        'Cell A5',
        'CellB5',
        'CellC5',
        5,
        10
      ),
        _Row(
        'Cell A1',
        'Cell A5',
        'CellB5',
        'CellC5',
        5,
        10
      ),
      
    ];
  }

  final BuildContext context;
  List<_Row> _rows = [];

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Checkbox(value: true,onChanged: (value) {
          
        },)),
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
                    onPressed: () {},
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
                    onPressed: () {},
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
