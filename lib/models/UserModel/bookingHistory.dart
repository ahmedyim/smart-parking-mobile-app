class History {
  String? day_start;
  String? time_start;
  String? day_end;
  String? time_end;
  String? status;

  History({
    this.day_start,
    this.time_start,
    this.day_end,
    this.time_end,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'day_start': day_start,
      'time_start': time_start,
      'day_end': day_end,
      'time_end': time_end,
      'status': status,
    };
  }

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        day_start: json['day_start'],
        time_start: json['time_start'],
        day_end: json['day_end'],
        time_end: json['time_end'],
        status: json['status']);
  }
}
