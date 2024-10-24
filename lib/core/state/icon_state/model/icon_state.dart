class IconState {
  final String iconId;
  bool isActive;

  IconState({required this.iconId, required this.isActive});


  void setIsActive(bool toggle) {
    this.isActive = toggle;
  }

  bool getIsActive() {
    return this.isActive;
  }

  Map<String, dynamic> toJson() {
    return {
      'iconId': iconId,
      'isActive': isActive,
    };
  }

  static IconState fromJson(Map<String, dynamic> map) {
    return IconState(
      iconId: map['iconId'],
      isActive: map['isActive'],
    );
  }
}