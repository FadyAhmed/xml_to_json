import 'dart:io';
import 'dart:convert';

void main() async {
  File gen = new File('generated.json');
  await gen.writeAsString("{\"Reviews\" :[ ", mode: FileMode.append);
  List<String> titles = [
    '"review_id"',
    '"user_id"',
    '"brand"',
    '"product"',
    '"date_rev"',
    '"date_buy"',
    '"pros"',
    '"cons"',
    '"rate"',
    '"rate1"',
    '"rate2"',
    '"rate3"',
    '"rate4"',
    '"rate5"',
    '"rate6"',
    '"shown"',
    '"brand_bros"',
    '"brand_cons"',
    '"brand_rate"',
    '"skipped"', // skip
    '"user_name"',
    '"email"',
    '"user_avatar"',
    '"youtube"',
    '"approved"',
    '"twitter"',
    '"facebook"',
    '"comments"',
    '"likes"', //array
  ];

  new File('reviews.xml').readAsString().then(
    (data) async {
      int numberOfRows = data.split('<Row>').length - 1;

      for (int i = 1; i <= numberOfRows; i++) {
        print(i);
        await gen.writeAsString(
          '{ \n',
          mode: FileMode.append,
        );

        for (int j = 0; j < 27; j++) {
          if (j == 19) {
            continue;
          } else {
            String title = titles[j];
            String prop =
                getDataFromCell(getCell(getExcactRow(data, i), j + 1));

            await gen.writeAsString(
              title + ': ' + jsonEncode(prop) + ',',
              mode: FileMode.append,
            );
          }
        }
        await gen.writeAsString(
          titles[27] + ':"0",\n',
          mode: FileMode.append,
        );
        await gen.writeAsString(
          titles[28] + ': [],\n',
          mode: FileMode.append,
        );
        await gen.writeAsString(
          '"views"' + ': 0 \n',
          mode: FileMode.append,
        );
        await gen.writeAsString(
          '},\n',
          mode: FileMode.append,
        );
      }
      await gen.writeAsString('] \n}', mode: FileMode.append);
    },
  ).then((_) => {print('////////////////DONE///////////////')});
}

String getExcactRow(String data, int rowNum) {
  return data.split('<Row>')[rowNum].split('</Row>')[0].trim();
}

String getCell(String row, int i) {
  return row.split('<Cell>')[i].split('</Cell>')[0].trim();
}

String getDataFromCell(String cell) {
  // get rid of last part
  String ss = cell.split('>')[1];
  // must equal 2 and get result
  String result = ss.split('<')[0];

  return result;
}
