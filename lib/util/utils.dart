String useQueryString(String baseUrl, Map<String, String> params) =>
    baseUrl +
    params.map((key, value) => MapEntry(key, '$key=$value')).values.join('&');
