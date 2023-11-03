import 'package:flutter/material.dart';

enum status{
 New,Done,Archive
}
const statusColor = {
  status.New: Color(0xFF9C28B1),
  status.Done: Color(0xFF4CB050),
  status.Archive: Colors.grey,
};