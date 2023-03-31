library patterns;

class EasyRegexPattern {
  static String emailPattern =
      '\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}\\b';
  static String webPattern =
      //(?!(\/EMAILPATTERN\/))
      //ingore domain from email
      '[hH]ttps?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,20}\\b([-a-zA-Z0-9()@:%_\\+.~#?&\\/\\/=]*)';
  // '(http(s)?:\\/\\/)?(www\\.)?[-a-zA-Z0-9:%_\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+\\/.~#?&=]*)';
  // '^((?:.|\\n)*?)((http:\\/\\/www\\.|https:\\/\\/www\\.|http:\\/\\/|https:\\/\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';

  static String telPattern = '[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\\s/0-9]{5,11}';

  static String richTextPattern =
      '<C\\s\\{(.*?)\\}>[\$@A-Z-a-z\\p{L}=,+\\d\\s\\.%]+</C>';
}
