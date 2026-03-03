export default class CommonConstants {
  static readonly CREATE_TRANSACTIONS_TABLE_SQL: string =
    "CREATE TABLE IF NOT EXISTS transactions (" +
      "id INTEGER PRIMARY KEY AUTOINCREMENT," +
      "type VARCHAR(16) CHECK(type IN ('income', 'expense', 'transfer'))," +
      "time INTEGER NOT NULL," +
      "amount DECIMAL(15, 2) NOT NULL," +
      "currency CHAR(3) DEFAULT 'CNY'" +
      ")";
}