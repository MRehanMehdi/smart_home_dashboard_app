import 'package:flutter/material.dart';
import '../models/device.dart';

class DeviceDetails extends StatefulWidget {
  final Device device;

  const DeviceDetails({required this.device});

  @override
  State<DeviceDetails> createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  IconData getIcon(String type) {
    switch (type) {
      case "Light":
        return Icons.lightbulb;
      case "Fan":
        return Icons.toys;
      case "AC":
        return Icons.ac_unit;
      case "Camera":
        return Icons.videocam;
      default:
        return Icons.devices_other;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isOn = widget.device.isOn;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Icon with glow when ON
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isOn ? Colors.blue.shade100 : Colors.grey.shade200,
                boxShadow: isOn
                    ? [
                  BoxShadow(
                    color: Colors.blue.shade200,
                    blurRadius: 25,
                    spreadRadius: 2,
                  )
                ]
                    : [],
              ),
              child: Icon(
                getIcon(widget.device.type),
                size: 70,
                color: isOn ? Colors.blue.shade700 : Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // Status chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isOn ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isOn ? "Status: ON" : "Status: OFF",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isOn ? Colors.green.shade700 : Colors.red.shade700,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Control Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      widget.device.type == "Light" ||
                          widget.device.type == "Fan"
                          ? "Adjust Level"
                          : "Device Control",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Slider only for Light / Fan
                    if (widget.device.type == "Light" ||
                        widget.device.type == "Fan")
                      Column(
                        children: [
                          Slider(
                            min: 0,
                            max: 100,
                            value: widget.device.value,
                            activeColor: Colors.blue.shade600,
                            onChanged: (v) {
                              setState(() => widget.device.value = v);
                            },
                          ),
                          Text(
                            "Level: ${widget.device.value.toInt()}%",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 10),

                    // Turn ON/OFF button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          setState(() => widget.device.isOn = !widget.device.isOn);
                        },
                        child: Text(
                          isOn ? "Turn OFF" : "Turn ON",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
