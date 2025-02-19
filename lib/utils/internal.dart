class Internal {
    static final Internal _instance = Internal._internal();

    factory Internal() {
        return _instance;
    }

    Internal._internal();

    Map<String, dynamic> data = {};

    void set(String key, dynamic value) {
        data[key] = value;
    }

    dynamic get(String key) {
        return data[key];
    }
}