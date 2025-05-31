import 'package:flutter/material.dart';
import 'package:hydrosmart/features/irrigation/domain/tank.dart';

class TankCard extends StatelessWidget {
  final Tank tank;
  final ValueChanged<Tank> onEdit;
  final ValueChanged<Tank> onDelete;

  const TankCard({
    super.key,
    required this.tank,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF1856C3).withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.water,
                        size: 30, color: Color(0xFF1856C3)),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tank.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${tank.remainingLiters.toStringAsFixed(0)} L / ${tank.totalLiters.toStringAsFixed(0)} L'
                      ),
                  ],
                ),
                
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Color(0xFF27AE60)),
                      onPressed: () => onEdit(tank), // Call edit callback
                      tooltip: 'Editar tanque',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => onDelete(tank), // Call delete callback
                      tooltip: 'Eliminar tanque',
                    ),
                  ],
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}