class Device {
  String name;
  String type; // Light, Fan, AC, Camera
  String room;
  bool isOn;
  double value; // brightness/speed

  Device({
    required this.name,
    required this.type,
    required this.room,
    this.isOn = false,
    this.value = 50,
  });
}
