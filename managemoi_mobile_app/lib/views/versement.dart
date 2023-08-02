import 'package:flutter/material.dart';

class Versement extends StatelessWidget {
  const Versement({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DataTable(columns: [
          DataColumn(
              label: Text(
            'Date',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w800, color: Colors.red),
          )),
          DataColumn(
              label: Text(
            'Montant',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w800, color: Colors.red),
          )),
          DataColumn(
              label: Text(
            'Statut',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w800, color: Colors.red),
          )),
        ], rows: [
          DataRow(cells: [
            DataCell(Text('2023-07-22')),
            DataCell(Text('Zisan')),
            DataCell(Text('16')),
          ]),
          DataRow(cells: [
            DataCell(Text('0002')),
            DataCell(Text('Riyan')),
            DataCell(Text('21')),
          ]),
          DataRow(cells: [
            DataCell(Text('0003')),
            DataCell(Text('Safiq')),
            DataCell(Text('29')),
          ]),
          DataRow(cells: [
            DataCell(Text('0004')),
            DataCell(Text('Faruk')),
            DataCell(Text('36')),
          ]),
          DataRow(cells: [
            DataCell(Text('0001')),
            DataCell(Text('Zisan')),
            DataCell(Text('16')),
          ]),
          DataRow(cells: [
            DataCell(Text('0002')),
            DataCell(Text('Riyan')),
            DataCell(Text('21')),
          ]),
          DataRow(cells: [
            DataCell(Text('0003')),
            DataCell(Text('Safiq')),
            DataCell(Text('29')),
          ]),
          DataRow(cells: [
            DataCell(Text('0004')),
            DataCell(Text('Faruk')),
            DataCell(Text('36')),
          ]),
          DataRow(cells: [
            DataCell(Text('0001')),
            DataCell(Text('Zisan')),
            DataCell(Text('16')),
          ]),
          DataRow(cells: [
            DataCell(Text('0002')),
            DataCell(Text('Riyan')),
            DataCell(Text('21')),
          ]),
          DataRow(cells: [
            DataCell(Text('0003')),
            DataCell(Text('Safiq')),
            DataCell(Text('29')),
          ]),
          DataRow(cells: [
            DataCell(Text('0004')),
            DataCell(Text('Faruk')),
            DataCell(Text('36')),
          ]),
          DataRow(cells: [
            DataCell(Text('0001')),
            DataCell(Text('Zisan')),
            DataCell(Text('16')),
          ]),
          DataRow(cells: [
            DataCell(Text('0002')),
            DataCell(Text('Riyan')),
            DataCell(Text('21')),
          ]),
          DataRow(cells: [
            DataCell(Text('0003')),
            DataCell(Text('Safiq')),
            DataCell(Text('29')),
          ]),
          DataRow(cells: [
            DataCell(Text('0004')),
            DataCell(Text('Faruk')),
            DataCell(Text('36')),
          ]),
        ])
      ],
    );
  }
}
