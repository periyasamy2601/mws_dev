import {inject, lifeCycleObserver, LifeCycleObserver, ValueOrPromise} from '@loopback/core';
import {juggler} from '@loopback/repository';

const config = {
  name: 'avk',
  connector: 'postgresql',
  url:
    'postgresql://' +
    process.env.DB_USER +
    ':' +
    process.env.DB_PASSWORD +
    '@' +
    process.env.DB_HOST +
    '/' +
    process.env.DB_NAME +
    '?retryWrites=true&w=majority',
  host: process.env.DB_HOST as string,
  port: process.env.DB_PORT as string,
  user: process.env.DB_USER as string,
  password: process.env.DB_PASSWORD as string,
  database: process.env.DB_NAME as string,
};

// Observe application's life cycle to disconnect the datasource when
// application is stopped. This allows the application to be shut down
// gracefully. The `stop()` method is inherited from `juggler.DataSource`.
// Learn more at https://loopback.io/doc/en/lb4/Life-cycle.html
@lifeCycleObserver('datasource')
export class AvkDataSource extends juggler.DataSource
  implements LifeCycleObserver {
  static dataSourceName = 'avk';
  static readonly defaultConfig = config;
  private readonly retryDelay = Number(process.env.DB_RETRY ?? 15000);

  constructor(
    @inject('datasources.config.avk', {optional: true})
    dsConfig: object = config,
  ) {
    super(dsConfig);
    // Listen for the 'connected' event and log a success message
    this.on('connected', () => {
      console.log(
        `✅ Connected to ${process.env.DB_NAME} database successfully!`,
      );
    });
    // Listen for the 'error' event and log an error message
    this.on('error', async err => {
      console.error({
        message: `❌ ${process.env.DB_NAME} database connection failed: ${err.message}`,
      });
      setTimeout(() => this.reconnect(), this.retryDelay);
    });
  }

  /**
  * Establish connection while connection was closed
  */
  async reconnect() {
    try {
      await this.connect();
      await this.verifyConnection();
      console.log(
        `✅ Successfully reconnected to ${process.env.DB_NAME} database.`,
      );
    } catch (err) {
      console.error({
        message: `❌ Failed to reconnect to ${process.env.DB_NAME} database:`,
        err,
      });
    }
  }

  // To verify the database connection
  private async verifyConnection() {
    try {
      await this.execute('SELECT 1');
      console.log(
        `✅ ${process.env.DB_NAME} Database connection verified successfully`,
      );
    } catch (error) {
      console.error({
        message: `❌ Failed to verify ${process.env.DB_NAME} database connection:`,
        error,
      });
      throw error;
    }
  }

  /**
 * Disconnect the datasource when application is stopped. This allows the
 * application to be shut down gracefully.
 */
  stop(): ValueOrPromise<void> {
    return super.disconnect();
  }
}
