class PacketControl{
  static const startPacket = 'SST*';
  static const endPacket = '*ED';
  static const splitChar = r'''$''';
  static const readPacket = '1';
  static const writePacket = '2';
}