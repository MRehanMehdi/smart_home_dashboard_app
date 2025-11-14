import 'package:flutter/material.dart';
import '../models/device.dart';
import 'device_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Device> devices = [
    Device(name: "Living Room Light", type: "Light", room: "Living Room"),
    Device(name: "Bedroom Fan", type: "Fan", room: "Bedroom"),
    Device(name: "Main AC", type: "AC", room: "Hall"),
    Device(name: "Security Camera", type: "Camera", room: "Entrance"),
  ];

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

  void openAddDeviceDialog() {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController roomCtrl = TextEditingController();
    String selectedType = "Light";

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "Add New Device",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: "Device Name",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: roomCtrl,
                decoration: InputDecoration(
                  labelText: "Room",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedType,
                  underline: const SizedBox(),
                  items: ["Light", "Fan", "AC", "Camera"]
                      .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => selectedType = v!),
                ),
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text("Add"),
              onPressed: () {
                if (nameCtrl.text.isEmpty || roomCtrl.text.isEmpty) return;

                setState(() {
                  devices.add(Device(
                    name: nameCtrl.text,
                    room: roomCtrl.text,
                    type: selectedType,
                  ));
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Home Dashboard"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/profile.png"),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.95,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          Device device = devices[index];

          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DeviceDetails(device: device),
                ),
              ).then((_) => setState(() {}));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: device.isOn
                    ? LinearGradient(
                  colors: [
                    Colors.blue.shade200,
                    Colors.blue.shade100,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : LinearGradient(
                  colors: [Colors.white, Colors.grey.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(2, 4),
                    color: Colors.black.withOpacity(0.08),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    getIcon(device.type),
                    size: 48,
                    color:
                    device.isOn ? Colors.blue.shade700 : Colors.grey[700],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    device.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    device.room,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Switch.adaptive(
                    value: device.isOn,
                    onChanged: (v) {
                      setState(() => device.isOn = v);
                    },
                    activeColor: Colors.blue.shade600,
                    inactiveThumbColor: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    device.isOn
                        ? "${device.type} is ON"
                        : "${device.type} is OFF",
                    style: TextStyle(
                      color: device.isOn
                          ? Colors.blue.shade700
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddDeviceDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 28),
        tooltip: "Add Device",
        elevation: 6,
      ),
    );
  }
}
