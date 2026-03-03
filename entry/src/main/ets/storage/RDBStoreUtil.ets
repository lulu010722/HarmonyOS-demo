import { relationalStore } from '@kit.ArkData';
import { hilog } from '@kit.PerformanceAnalysisKit';
import CommonConstants from '../common/constants/CommonConstants';

const TAG: string = "RDBStoreUtil"

class RDBStoreUtil {
  private mainRDBStore?: relationalStore.RdbStore;

  createRDB(context: Context) {
    const STORE_CONFIG: relationalStore.StoreConfig = {
      name: 'main_rdb_store',
      securityLevel: relationalStore.SecurityLevel.S1
    }

    relationalStore.getRdbStore(context, STORE_CONFIG, (err: BusinessError, store: relationalStore.RdbStore) => {
      this.mainRDBStore = store;
      if (err) {
        hilog.error(0x0000, TAG, `Get RDBStore failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      hilog.error(0x0000, TAG, 'Get RDBStore successfully')
    })
  }

  createTransactionTable() {
    this.createTable(CommonConstants.CREATE_TRANSACTIONS_TABLE_SQL)
    hilog.error(0x0000, TAG, 'create table transaction successfully')
  }

  async insertTransaction() {
    const transactionData: relationalStore.ValuesBucket = {
      'type': 'income',
      'time': Date.now(),
      'amount': 12.34,
    }

    try {
      await this.mainRDBStore?.insert('transactions', transactionData,
        relationalStore.ConflictResolution.ON_CONFLICT_REPLACE);
      hilog.error(0x0000, TAG, 'insert transaction successfully')
    } catch (err) {
      hilog.error(0x0000, TAG, `insert transaction failed, code is ${err.code}, message is ${err.message}`)
    }
  }

  private createTable(query: string) {
    this.mainRDBStore?.execute(query)
      .then(() => {
        hilog.error(0x0000, TAG, 'execute create table successfully')
      })
      .catch((err: BusinessError) => {
        hilog.error(0x0000, TAG, `execute create table failed, code is ${err.code}, message is ${err.message}`)
      })
  }
}

export default new RDBStoreUtil()