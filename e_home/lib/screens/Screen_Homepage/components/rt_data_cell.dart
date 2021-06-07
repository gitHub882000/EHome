/// This class is used to support saving realtime data history
class RtDataCell {
  double data;
  DateTime date;

  RtDataCell(this.data, this.date);

  RtDataCell.withData(this.data);
}