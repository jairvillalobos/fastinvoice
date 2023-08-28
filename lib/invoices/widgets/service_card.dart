import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceCard({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Row(children:[
          const Icon(Icons.description),
          const SizedBox(width: 8),
          Expanded(child:
            Text(service['descripcion']),
          ),
        ]),
        Row(children:[
          const Icon(Icons.attach_money),
          const SizedBox(width: 8),
          Text(service['valor'].toString()),
        ])
      ]
    );
  }
}
